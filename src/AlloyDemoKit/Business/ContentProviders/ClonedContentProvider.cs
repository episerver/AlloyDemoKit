using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using System.Linq;
using EPiServer;
using EPiServer.Configuration;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.Filters;
using EPiServer.Logging;
using EPiServer.ServiceLocation;
using EPiServer.Web;

namespace AlloyDemoKit.Business.ContentProviders
{
    /// <summary>
    /// Used to clone a part of the page tree
    /// </summary>
    /// <remarks>The current implementation only supports cloning of <see cref="PageData"/> content</remarks>
    /// <code>
    /// // Example of programmatically registering a cloned content provider
    ///
    /// var rootPageOfContentToClone = new PageReference(10);
    ///
    /// var pageWhereClonedContentShouldAppear = new PageReference(20);
    ///
    /// var provider = new ClonedContentProvider(rootPageOfContentToClone, pageWhereClonedContentShouldAppear);
    ///
    /// var providerManager = ServiceLocator.Current.GetInstance<IContentProviderManager>();
    ///
    /// providerManager.ProviderMap.AddProvider(provider);
    /// </code>
    public class ClonedContentProvider : ContentProvider, IPageCriteriaQueryService
    {
        private static readonly ILogger Logger = LogManager.GetLogger(typeof(ClonedContentProvider));
        private readonly NameValueCollection _parameters = new NameValueCollection(1);
        private PageReference _cloneRoot;
        private PageReference _entryRoot;
        private CategoryList _category;
        private readonly IContentLoader _contentLoader;
        private readonly ContentStore _contentStore;
        private readonly IPageCriteriaQueryService _pageQueryService;

        /// <summary>
        /// Gets a unique key for this content provider instance
        /// </summary>
        public override string ProviderKey
        {
            get
            {
                return string.Format("ClonedContent-{0}-{1}", _cloneRoot.ID, _entryRoot.ID);
            }
        }

        /// <summary>
        /// Gets capabilities indicating no content editing can be performed through this provider
        /// </summary>
        public override ContentProviderCapabilities ProviderCapabilities
        {
            get
            {
                return ContentProviderCapabilities.Search;
            }
        }

        /// <summary>
        /// Gets configuration parameters for this content provider instance
        /// </summary>
        public override NameValueCollection Parameters { get { return _parameters; } }

        public ClonedContentProvider() : this(ServiceLocator.Current.GetInstance<IContentLoader>(),
                                            ServiceLocator.Current.GetInstance<ContentStore>(),
                                            ServiceLocator.Current.GetInstance<IPageCriteriaQueryService>()
                                            )
        {

        }

        public ClonedContentProvider(IContentLoader contentLoader, ContentStore contentStore, IPageCriteriaQueryService pageCriteriaQueryService)
        {
            _contentLoader = contentLoader;
            _contentStore = contentStore;
            _pageQueryService = pageCriteriaQueryService;
        }

        public void Initialize(PageReference cloneRoot, PageReference entryRoot, CategoryList categoryFilter)
        {
            if (cloneRoot.CompareToIgnoreWorkID(entryRoot))
            {
                throw new NotSupportedException("Entry root and clone root cannot be set to the same content reference");
            }

            if (ServiceLocator.Current.GetInstance<IContentLoader>().GetChildren<IContent>(entryRoot).Any())
            {
                throw new NotSupportedException("Unable to create ClonedContentProvider, the EntryRoot property must point to leaf content (without children)");
            }

            _cloneRoot = cloneRoot;
            _entryRoot = entryRoot;
            _category = categoryFilter;

            // Set the entry point parameter
            Parameters.Add(ContentProviderElement.EntryPointString, _entryRoot.ID.ToString(CultureInfo.InvariantCulture));
        }

        /// <summary>
        /// Clones a page to make it appear to come from where the content provider is attached
        /// </summary>
        private PageData ClonePage(PageData originalPage)
        {
            if (originalPage == null)
            {
                throw new ArgumentNullException("originalPage", "No page to clone specified");
            }

            Logger.Debug("Cloning page {0}...", originalPage.PageLink);

            var clone = originalPage.CreateWritableClone();

            // If original page was under the clone root, we make it appear to be under the entry root instead
            if (originalPage.ParentLink.CompareToIgnoreWorkID(_cloneRoot))
            {
                clone.ParentLink = _entryRoot;
            }

            // All pages but the entry root should appear to come from this content provider
            if (!clone.PageLink.CompareToIgnoreWorkID(_entryRoot))
            {
                clone.ContentLink.ProviderName = ProviderKey;
            }

            // Unless the parent is the entry root, it should appear to come from this content provider
            if (!clone.ParentLink.CompareToIgnoreWorkID(_entryRoot))
            {
                var parentLinkClone = clone.ParentLink.CreateWritableClone();

                parentLinkClone.ProviderName = ProviderKey;

                clone.ParentLink = parentLinkClone;
            }

            // This is integral to map the cloned page to this content provider
            clone.LinkURL = ConstructContentUri(originalPage.ContentTypeID, clone.ContentLink, clone.ContentGuid).ToString();

            return clone;
        }

        /// <summary>
        /// Filters out content references to content that does not match current category filters, if any
        /// </summary>
        /// <param name="contentReferences"></param>
        /// <returns></returns>
        private IList<T> FilterByCategory<T>(IEnumerable<T> contentReferences)
        {
            if (_category == null || !_category.Any())
            {
                return contentReferences.ToList();
            }

            // Filter by category if a category filter has been set
            var filteredChildren = new List<T>();

            foreach (var contentReference in contentReferences)
            {
                ICategorizable content = null;
                if (contentReference is ContentReference)
                {
                    content = (contentReference as ContentReference).Get<IContent>() as ICategorizable;
                }
                else if (typeof(T) == typeof(GetChildrenReferenceResult))
                {
                    content = (contentReference as GetChildrenReferenceResult).ContentLink.Get<IContent>() as ICategorizable;
                }

                if (content != null)
                {
                    var atLeastOneMatchingCategory = content.Category.Any(c => _category.Contains(c));

                    if (atLeastOneMatchingCategory)
                    {
                        filteredChildren.Add(contentReference);
                    }
                }
                else // Non-categorizable content will also be included
                {
                    filteredChildren.Add(contentReference);
                }
            }

            return filteredChildren;
        }

        protected override IContent LoadContent(ContentReference contentLink, ILanguageSelector languageSelector)
        {
            if (ContentReference.IsNullOrEmpty(contentLink) || contentLink.ID == 0)
            {
                throw new ArgumentNullException("contentLink");
            }

            if (contentLink.WorkID > 0)
            {
                return _contentStore.LoadVersion(contentLink, -1);
            }

            var languageBranchRepository = DependencyHelper.LanguageBranchRepository;

            LanguageBranch langBr = null;

            if (languageSelector.Language != null)
            {
                langBr = languageBranchRepository.Load(languageSelector.Language);
            }

            if (contentLink.GetPublishedOrLatest)
            {
                return _contentStore.LoadVersion(contentLink, langBr != null ? langBr.ID : -1);
            }

            // Get published version of Content
            var originalContent = _contentStore.Load(contentLink, langBr != null ? langBr.ID : -1);


            if (!(originalContent is PageData page))
            {
                throw new NotSupportedException("Only cloning of pages is supported");
            }

            return ClonePage(page);
        }

        protected override ContentResolveResult ResolveContent(ContentReference contentLink)
        {
            var contentData = DependencyHelper.ContentCoreDataLoader().Load(contentLink.ID);

            // All pages but the entry root should appear to come from this content provider
            if (!contentLink.CompareToIgnoreWorkID(_entryRoot))
            {
                contentData.ContentReference.ProviderName = ProviderKey;
            }

            var result = CreateContentResolveResult(contentData);

            if (!result.ContentLink.CompareToIgnoreWorkID(_entryRoot))
            {
                result.ContentLink.ProviderName = ProviderKey;
            }

            return result;
        }

        protected override Uri ConstructContentUri(int contentTypeId, ContentReference contentLink, Guid contentGuid)
        {
            if (!contentLink.CompareToIgnoreWorkID(_entryRoot))
            {
                contentLink.ProviderName = ProviderKey;
            }

            return base.ConstructContentUri(contentTypeId, contentLink, contentGuid);
        }

        protected override IList<GetChildrenReferenceResult> LoadChildrenReferencesAndTypes(ContentReference contentLink, string languageID, out bool languageSpecific)
        {
            // If retrieving children for the entry point, we retrieve pages from the clone root
            contentLink = contentLink.CompareToIgnoreWorkID(_entryRoot) ? _cloneRoot : contentLink;

            var children = _contentStore.LoadChildrenReferencesAndTypes(contentLink.ID, languageID, out FilterSortOrder sortOrder);

            languageSpecific = sortOrder == FilterSortOrder.Alphabetical;

            foreach (var contentReference in children.Where(contentReference => !contentReference.ContentLink.CompareToIgnoreWorkID(_entryRoot)))
            {
                contentReference.ContentLink.ProviderName = ProviderKey;
            }

            return FilterByCategory<GetChildrenReferenceResult>(children);
        }

        protected override IEnumerable<IContent> LoadContents(IList<ContentReference> contentReferences, ILanguageSelector selector)
        {
            return contentReferences
                   .Select(contentReference => ClonePage(_contentLoader.Get<PageData>(contentReference.ToReferenceWithoutVersion())))
                   .Cast<IContent>()
                   .ToList();
        }

        protected override void SetCacheSettings(IContent content, CacheSettings cacheSettings)
        {
            // Make the cache of this content provider depend on the original content
            cacheSettings.CacheKeys.Add(DependencyHelper.ContentCacheKeyCreator.CreateCommonCacheKey(new ContentReference(content.ContentLink.ID)));
        }

        protected override void SetCacheSettings(ContentReference contentReference, IEnumerable<GetChildrenReferenceResult> children, CacheSettings cacheSettings)
        {
            // Make the cache of this content provider depend on the original content

            cacheSettings.CacheKeys.Add(DependencyHelper.ContentCacheKeyCreator.CreateCommonCacheKey(new ContentReference(contentReference.ID)));

            foreach (var child in children)
            {
                cacheSettings.CacheKeys.Add(DependencyHelper.ContentCacheKeyCreator.CreateCommonCacheKey(new ContentReference(child.ContentLink.ID)));
            }
        }

        public override IList<ContentReference> GetDescendentReferences(ContentReference contentLink)
        {
            // If retrieving children for the entry point, we retrieve pages from the clone root
            contentLink = contentLink.CompareToIgnoreWorkID(_entryRoot) ? _cloneRoot : contentLink;

            var descendents = _contentStore.ListAll(contentLink);

            foreach (var contentReference in descendents.Where(contentReference => !contentReference.CompareToIgnoreWorkID(_entryRoot)))
            {
                contentReference.ProviderName = ProviderKey;
            }

            return FilterByCategory<ContentReference>(descendents);
        }

        public PageDataCollection FindAllPagesWithCriteria(PageReference pageLink, PropertyCriteriaCollection criterias, string languageBranch, ILanguageSelector selector)
        {
            // Any search beneath the entry root should in fact be performed under the clone root as that's where the original content resides
            if (pageLink.CompareToIgnoreWorkID(_entryRoot))
            {
                pageLink = _cloneRoot;
            }
            else if (!string.IsNullOrWhiteSpace(pageLink.ProviderName)) // Any search beneath a cloned page should in fact be performed under the original page, so we use a page link without any provider information
            {
                pageLink = new PageReference(pageLink.ID);
            }

            var pages = _pageQueryService.FindAllPagesWithCriteria(pageLink, criterias, languageBranch, selector);

            // Return cloned search result set
            return new PageDataCollection(pages.Select(ClonePage));
        }

        public PageDataCollection FindPagesWithCriteria(PageReference pageLink, PropertyCriteriaCollection criterias, string languageBranch, ILanguageSelector selector)
        {
            // Any search beneath the entry root should in fact be performed under the clone root as that's where the original content resides
            if (pageLink.CompareToIgnoreWorkID(_entryRoot))
            {
                pageLink = _cloneRoot;
            }
            else if (!string.IsNullOrWhiteSpace(pageLink.ProviderName)) // Any search beneath a cloned page should in fact be performed under the original page, so we use a page link without any provider information
            {
                pageLink = new PageReference(pageLink.ID);
            }

            var pages = _pageQueryService.FindPagesWithCriteria(pageLink, criterias, languageBranch, selector);

            // Return cloned search result set
            return new PageDataCollection(pages.Select(ClonePage));
        }
    }
}
