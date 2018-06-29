using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Mvc;
using AlloyDemoKit.Business;
using AlloyDemoKit.Models.Pages.Models.Blocks;
using AlloyDemoKit.Models.Pages.Models.Pages;
using AlloyDemoKit.Models.Pages.Tags;
using AlloyDemoKit.Models.ViewModels;
using EPiServer;
using EPiServer.Core;
using EPiServer.Core.Html;
using EPiServer.DataAbstraction;
using EPiServer.Filters;
using EPiServer.ServiceLocation;
using EPiServer.Web.Mvc;
using EPiServer.Web.Routing;

namespace AlloyDemoKit.Models.Pages.Controllers
{
    public class BlogListBlockController : BlockController<BlogListBlock>
    {
        public int PreviewTextLength { get; set; }
        private ContentLocator contentLocator;
        private IContentLoader contentLoader;
        public BlogListBlockController(ContentLocator contentLocator, IContentLoader contentLoader)
        {
            this.contentLocator = contentLocator;
            this.contentLoader = contentLoader;
        }

        public override ActionResult Index(BlogListBlock currentBlock)
        {

            var category = Request.RequestContext.GetCustomRouteData<Category>("category");

            var blogs = FindPages(currentBlock, category);

            blogs = Sort(blogs, currentBlock.SortOrder);

            if(currentBlock.Count > 0)
            {
                blogs = blogs.Take(currentBlock.Count);
            }


            var model = new BlogListModel(currentBlock)
                {
                    Blogs = blogs, 
                    Heading = category != null ? "Blog tags for post: "+category.Name : string.Empty
                };

            return PartialView(model);
        }

        public ActionResult Preview(PageData currentPage, BlogListModel blogModel)
        {
            var pd = (BlogItemPage)currentPage;
            PreviewTextLength = 200;

            var model = new BlogItemPageModel(pd)
            {
                Tags = GetTags(pd),
                PreviewText = GetPreviewText(pd),
                ShowIntroduction = blogModel.ShowIntroduction,
                ShowPublishDate = blogModel.ShowPublishDate
            };

            return PartialView("Preview", model);
        }
        public IEnumerable<BlogItemPageModel.TagItem> GetTags(BlogItemPage currentPage)
        {
            List<BlogItemPageModel.TagItem> tags = new List<BlogItemPageModel.TagItem>();
            var categoryRepository = ServiceLocator.Current.GetInstance<CategoryRepository>();

            foreach (var item in currentPage.Category)
            {
                Category cat = categoryRepository.Get(item);

                tags.Add(new BlogItemPageModel.TagItem() { Title = cat.Name, Url = TagFactory.Instance.GetTagUrl(currentPage, cat) });
            }

            return tags;
        }



        protected string GetPreviewText(BlogItemPage page)
        {
            if (PreviewTextLength <= 0)
            {
                return string.Empty;
            }

            string previewText = String.Empty;

            if (page.MainBody != null)
            {
                previewText = page.MainBody.ToHtmlString();
            }

            if (String.IsNullOrEmpty(previewText))
            {
                return string.Empty;
            }

            //If the MainBody contains DynamicContents, replace those with an empty string
            StringBuilder regexPattern = new StringBuilder(@"<span[\s\W\w]*?classid=""");
            //regexPattern.Append(DynamicContentFactory.Instance.DynamicContentId.ToString());
            regexPattern.Append(@"""[\s\W\w]*?</span>");
            previewText = Regex.Replace(previewText, regexPattern.ToString(), string.Empty, RegexOptions.IgnoreCase | RegexOptions.Multiline);

            return TextIndexer.StripHtml(previewText, PreviewTextLength);
        }


        private IEnumerable<PageData> FindPages(BlogListBlock currentBlock, Category category)
        {
            var pageRouteHelper = ServiceLocator.Current.GetInstance<IPageRouteHelper>();
            PageData currentPage = pageRouteHelper.Page ?? contentLoader.Get<PageData>(ContentReference.StartPage);

            var listRoot = currentBlock.Root ?? currentPage.ContentLink.ToPageReference();

            IEnumerable<PageData> pages;
            
            if (currentBlock.Recursive)
            {
                if (currentBlock.PageTypeFilter != null)
                {
                    pages = contentLocator.FindPagesByPageType(listRoot, true, currentBlock.PageTypeFilter.ID);
                }
                else
                {
                    pages = contentLocator.GetAll<PageData>(listRoot);
                }
            }
            else
            {
                if (currentBlock.PageTypeFilter != null)
                {
                    pages = contentLoader.GetChildren<PageData>(listRoot)
                        .Where(p => p.ContentTypeID == currentBlock.PageTypeFilter.ID);
                }
                else
                {
                    pages = contentLoader.GetChildren<PageData>(listRoot);
                }
            }

            if (currentBlock.CategoryFilter != null && currentBlock.CategoryFilter.Any())
            {
                pages = pages.Where(x => x.Category.Intersect(currentBlock.CategoryFilter).Any());
            }
            else if(category != null)
            {
                var catlist = new CategoryList
                {
                    category.ID
                };

                pages = pages.Where(x => x.Category.Intersect(catlist).Any());
            }
            pages = pages.Where(p => p.PageTypeName == typeof(BlogItemPage).GetPageType().Name).ToList();
            return pages;
        }

        private IEnumerable<PageData> Sort(IEnumerable<PageData> pages, FilterSortOrder sortOrder)
        {
            var asCollection = new PageDataCollection(pages);
            var sortFilter = new FilterSort(sortOrder);
            sortFilter.Sort(asCollection);
            return asCollection;
        }

      
    }
}
