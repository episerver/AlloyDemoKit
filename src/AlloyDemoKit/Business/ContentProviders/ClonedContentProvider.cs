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
        private static readonly ILogger Logger = LogManager.GetLogger();
        private readonly NameValueCollection _parameters = new NameValueCollection(1);

        public ClonedContentProvider(PageReference cloneRoot, PageReference entryRoot) : this(cloneRoot, entryRoot, null) { }

        public ClonedContentProvider(PageReference cloneRoot, PageReference entryRoot, CategoryList categoryFilter)
        {
            if (cloneRoot.CompareToIgnoreWorkID(entryRoot))
            {
                throw new NotSupportedException("Entry root and clone root cannot be set to the same content reference");
            }

            if (ServiceLocator.Current.GetInstance<IContentLoader>().GetChildren<IContent>(entryRoot).Any())
            {
                throw new NotSupportedException("Unable to create ClonedContentProvider, the EntryRoot property must point to leaf content (without children)");
            }

            CloneRoot = cloneRoot;
            EntryRoot = entryRoot;
            Category = categoryFilter;

            // Set the entry point parameter
            Parameters.Add(ContentProviderElement.EntryPointString, EntryRoot.ID.ToString(CultureInfo.InvariantCulture));
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
            if (originalPage.ParentLink.CompareToIgnoreWorkID(CloneRoot))
            {
                clone.ParentLink = EntryRoot;
            }

            // All pages but the entry root should appear to come from this content provider
            if (!clone.PageLink.CompareToIgnoreWorkID(EntryRoot))
            {
                clone.ContentLink.ProviderName = ProviderKey;    
            }

            // Unless the parent is the entry root, it should appear to come from this content provider
            if (!clone.ParentLink.CompareToIgnoreWorkID(EntryRoot))
            {
                var parentLinkClone = clone.ParentLink.CreateWritableClone();

                parentLinkClone.ProviderName = ProviderKey;

                clone.ParentLink = parentLinkClone;
            }
            
            // This is integral to map the cloned page to this content provider
            clone.LinkURL = ConstructContentUri(originalPage.PageTypeID, clone.ContentLink, clone.ContentGuid).ToString();

            return clone;
        }

        /// <summary>
        /// Filters out content references to content that does not match current category filters, if any
        /// </summary>
        /// <param name="contentReferences"></param>
        /// <returns></returns>
        private IList<T> FilterByCategory<T>(IEnumerable<T> contentReferences)
        {
            if (Category == null || !Category.Any())
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
                } else if (typeof(T) == typeof(GetChildrenReferenceResult))
                {
                    content = (contentReference as GetChildrenReferenceResult).ContentLink.Get<IContent>() as ICategorizable;
                }

                if (content != null)
                {
                    var atLeastOneMatchingCategory = content.Category.Any(c => Category.Contains(c));

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
                return ContentStore.LoadVersion(contentLink, -1);
            }

            var languageBranchRepository = ServiceLocator.Current.GetInstance<ILanguageBranchRepository>();

            LanguageBranch langBr = null;

            if (languageSelector.Language != null)
            {
                langBr = languageBranchRepository.Load(languageSelector.Language);
            }

            if (contentLink.GetPublishedOrLatest)
            {
                return ContentStore.LoadVersion(contentLink, langBr != null ? langBr.ID : -1);
            }

            // Get published version of Content
            var originalContent = ContentStore.Load(contentLink, langBr != null ? langBr.ID : -1);

            var page = originalContent as PageData;

            if (page == null)
            {
                throw new NotSupportedException("Only cloning of pages is supported");
            }

            return ClonePage(page);
        }

        protected override ContentResolveResult ResolveContent(ContentReference contentLink)
        {
            var contentData = ContentCoreDataLoader.Service.Load(contentLink.ID);

            // All pages but the entry root should appear to come from this content provider
            if (!contentLink.CompareToIgnoreWorkID(EntryRoot))
            {
                contentData.ContentReference.ProviderName = ProviderKey;
            }

            var result = CreateContentResolveResult(contentData);

            if (!result.ContentLink.CompareToIgnoreWorkID(EntryRoot))
            {
                result.ContentLink.ProviderName = ProviderKey;
            }

            return result;
        }

        protected override Uri ConstructContentUri(int contentTypeId, ContentReference contentLink, Guid contentGuid)
        {
            if (!contentLink.CompareToIgnoreWorkID(EntryRoot))
            {
                contentLink.ProviderName = ProviderKey;
            }

            return base.ConstructContentUri(contentTypeId, contentLink, contentGuid);
        }

        protected override IList<GetChildrenReferenceResult> LoadChildrenReferencesAndTypes(ContentReference contentLink, string languageID, out bool languageSpecific)
        {
            // If retrieving children for the entry point, we retrieve pages from the clone root
            contentLink = contentLink.CompareToIgnoreWorkID(EntryRoot) ? CloneRoot : contentLink;

            FilterSortOrder sortOrder;

            var children = ContentStore.LoadChildrenReferencesAndTypes(contentLink.ID, languageID, out sortOrder);

            languageSpecific = sortOrder == FilterSortOrder.Alphabetical;

            foreach (var contentReference in children.Where(contentReference => !contentReference.ContentLink.CompareToIgnoreWorkID(EntryRoot)))
            {
                contentReference.ContentLink.ProviderName = ProviderKey;
            }

            return FilterByCategory <GetChildrenReferenceResult>(children);
        }

        protected override IEnumerable<IContent> LoadContents(IList<ContentReference> contentReferences, ILanguageSelector selector)
        {
            return contentReferences
                   .Select(contentReference => ClonePage(ContentLoader.Get<PageData>(contentReference.ToReferenceWithoutVersion())))
                   .Cast<IContent>()
                   .ToList();
        }

        protected override void SetCacheSettings(IContent content, CacheSettings cacheSettings)
        {
            // Make the cache of this content provider depend on the original content
            cacheSettings.CacheKeys.Add(DataFactoryCache.PageCommonCacheKey(new ContentReference(content.ContentLink.ID)));
        }

        protected override void SetCacheSettings(ContentReference contentReference, IEnumerable<GetChildrenReferenceResult> children, CacheSettings cacheSettings)
        {
            // Make the cache of this content provider depend on the original content

            cacheSettings.CacheKeys.Add(DataFactoryCache.PageCommonCacheKey(new ContentReference(contentReference.ID)));

            foreach (var child in children)
            {
                cacheSettings.CacheKeys.Add(DataFactoryCache.PageCommonCacheKey(new ContentReference(child.ContentLink.ID)));
            }
        }

        public override IList<ContentReference> GetDescendentReferences(ContentReference contentLink)
        {
            // If retrieving children for the entry point, we retrieve pages from the clone root
            contentLink = contentLink.CompareToIgnoreWorkID(EntryRoot) ? CloneRoot : contentLink;

            var descendents = ContentStore.ListAll(contentLink);

            foreach (var contentReference in descendents.Where(contentReference => !contentReference.CompareToIgnoreWorkID(EntryRoot)))
            {
                contentReference.ProviderName = ProviderKey;
            }

            return FilterByCategory<ContentReference>(descendents);
        }

        public PageDataCollection FindAllPagesWithCriteria(PageReference pageLink, PropertyCriteriaCollection criterias, string languageBranch, ILanguageSelector selector)
        {
            // Any search beneath the entry root should in fact be performed under the clone root as that's where the original content resides
            if (pageLink.CompareToIgnoreWorkID(EntryRoot))
            {
                pageLink = CloneRoot;
            }
            else if (!string.IsNullOrWhiteSpace(pageLink.ProviderName)) // Any search beneath a cloned page should in fact be performed under the original page, so we use a page link without any provider information
            {
                pageLink = new PageReference(pageLink.ID);
            }

            var pages = PageQueryService.FindAllPagesWithCriteria(pageLink, criterias, languageBranch, selector);

            // Return cloned search result set
            return new PageDataCollection(pages.Select(ClonePage));
        }

        public PageDataCollection FindPagesWithCriteria(PageReference pageLink, PropertyCriteriaCollection criterias, string languageBranch, ILanguageSelector selector)
        {
            // Any search beneath the entry root should in fact be performed under the clone root as that's where the original content resides
            if (pageLink.CompareToIgnoreWorkID(EntryRoot))
            {
                pageLink = CloneRoot;
            }
            else if (!string.IsNullOrWhiteSpace(pageLink.ProviderName)) // Any search beneath a cloned page should in fact be performed under the original page, so we use a page link without any provider information
            {
                pageLink = new PageReference(pageLink.ID);
            }

            var pages = PageQueryService.FindPagesWithCriteria(pageLink, criterias, languageBranch, selector);

            // Return cloned search result set
            return new PageDataCollection(pages.Select(ClonePage));
        }

        /// <summary>
        /// Gets the content store used to get original content
        /// </summary>
        protected virtual ContentStore ContentStore
        {
            get { return ServiceLocator.Current.GetInstance<ContentStore>(); }
        }

        /// <summary>
        /// Gets the content loader used to get content
        /// </summary>
        protected virtual IContentLoader ContentLoader
        {
            get { return ServiceLocator.Current.GetInstance<IContentLoader>(); }
        }

        /// <summary>
        /// Gets the service used to query for pages using criterias
        /// </summary>
        protected virtual IPageCriteriaQueryService PageQueryService 
        { 
            get { return ServiceLocator.Current.GetInstance<IPageCriteriaQueryService>(); }
        }

        /// <summary>
        /// Content that should be cloned at the entry point
        /// </summary>
        public PageReference CloneRoot { get; protected set; }

        /// <summary>
        /// Gets the page where the cloned content will appear
        /// </summary>
        public PageReference EntryRoot { get; protected set; }

        /// <summary>
        /// Gets the category filters used for this content provider
        /// </summary>
        /// <remarks>If set, pages not matching at least one of these categories will be excluded from this content provider</remarks>
        public CategoryList Category { get; protected set; }

        /// <summary>
        /// Gets a unique key for this content provider instance
        /// </summary>
        public override string ProviderKey
        {
            get
            {
                return string.Format("ClonedContent-{0}-{1}", CloneRoot.ID, EntryRoot.ID);
            }
        }

        /// <summary>
        /// Gets capabilities indicating no content editing can be performed through this provider
        /// </summary>
        public override ContentProviderCapabilities ProviderCapabilities { get { return ContentProviderCapabilities.Search; } }

        /// <summary>
        /// Gets configuration parameters for this content provider instance
        /// </summary>
        public override NameValueCollection Parameters { get { return _parameters; } }
    }
}
