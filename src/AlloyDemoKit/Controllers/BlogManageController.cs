using System.Globalization;
using AlloyDemoKit.Models.Pages;
using AlloyDemoKit.Models.Pages.Blog;
using AlloyDemoKit.Models.ViewModels;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAccess;
using EPiServer.Personalization;
using EPiServer.Security;
using EPiServer.Web;
using EPiServer.Web.Mvc;
using System.Linq;
using System.Web.Mvc;
using AlloyDemoKit.Business.Attributes;
using EPiServer.Globalization;
using EPiServer.Web.Routing;

namespace AlloyDemoKit.Controllers
{
    public class BlogManageController : PageController<BlogManage>
    {
        private readonly IContentRepository _contentRepository;
        private readonly IUrlSegmentGenerator _urlSegmentGenerator;
        private readonly IContentRouteHelper _contentRouteHelper;
        private ContentReference _blogRoot;
        private BlogUserStartPage _blogUserStartPage;

        public BlogManageController(IContentRepository contentRepository,
            IUrlSegmentGenerator urlSegmentGenerator,
            IContentRouteHelper contentRouteHelper)
        {
            _contentRepository = contentRepository;
            _urlSegmentGenerator = urlSegmentGenerator;
            _contentRouteHelper = contentRouteHelper;
        }

        public ContentReference BlogRoot
        {
            get
            {
                if (ContentReference.IsNullOrEmpty(_blogRoot))
                {
                    _blogRoot = _contentRepository.Get<StartPage>(SiteDefinition.Current.StartPage).
                        BlogPageLink;
                }
                return _blogRoot;
            }
        }

        public BlogUserStartPage BlogUserStartPage
        {
            get
            {
                return _blogUserStartPage ??
                       (_blogUserStartPage = _contentRepository.GetChildren<BlogUserStartPage>(BlogRoot).
                           FirstOrDefault(x => x.User.Equals(User.Identity.Name)));
            }
        }
        public ActionResult Index(BlogManage currentPage)
        {
            var userRoot = BlogUserStartPage;
            if (userRoot == null)
            {
                var profile = EPiServerProfile.Current;
                var name = string.Format("{0} {1}", profile.FirstName, profile.LastName);
                userRoot = _contentRepository.GetDefault<BlogUserStartPage>(BlogRoot);
                userRoot.Author = name;
                userRoot.User = User.Identity.Name;
                userRoot.URLSegment = _urlSegmentGenerator.Create(name);
                userRoot.Name = name;
                userRoot.MetaDescription = name + " Blog";
                userRoot.Archive.Heading = "Archive";
                userRoot.TagCloud.Heading = "Tags";
                _contentRepository.Save(userRoot, SaveAction.Publish, AccessLevel.NoAccess);
                userRoot.TagCloud.BlogTagLinkPage = userRoot.PageLink;
                userRoot.Archive.BlogStart = userRoot.PageLink;
                _contentRepository.Save(userRoot, SaveAction.Publish, AccessLevel.NoAccess);
            }
            var items = _contentRepository.GetItems(_contentRepository.GetDescendents(userRoot.ContentLink), ContentLanguage.PreferredCulture)
                .OfType<BlogItemPage>();
            return View(new ManageBlogViewModel(currentPage, items));
        }

        [HttpGet]
        public ActionResult EditBlog(BlogManage currentPage, int blogid)
        {
            var blog = _contentRepository.Get<BlogItemPage>(new ContentReference(blogid));
            return View(new ManageBlogItemViewModel(currentPage)
            {
                MetaDescription = blog.MetaDescription ?? "",
                MetaKeywords = blog.MetaKeywords != null && blog.MetaKeywords.Any() ? string.Join(",", blog.MetaKeywords) : "",
                MetaTitle = blog.MetaTitle,
                Title = blog.TeaserText,
                Post = blog.MainBody != null ? blog.MainBody.ToHtmlString() : "",
                ContentLink = blog.ContentLink.ToString()
            });
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        [MultipleButton(Name = "action", Argument = "Save")]
        public ActionResult EditBlog(ManageBlogItemViewModel blog)
        {
            var item = _contentRepository.Get<BlogItemPage>(ContentReference.Parse(blog.ContentLink));
            item = item.CreateWritableClone() as BlogItemPage;
            item.MainBody = new XhtmlString(blog.Post);
            item.MetaDescription = blog.MetaDescription;
            item.MetaKeywords = blog.MetaKeywords.Split(',');
            item.MetaTitle = blog.MetaTitle;
            item.TeaserText = blog.Title;
            _contentRepository.Save(item, SaveAction.Default, AccessLevel.NoAccess);
            return RedirectToAction("Index", "BlogManage");
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        [MultipleButton(Name = "action", Argument = "Publish")]
        public ActionResult PublishBlog(ManageBlogItemViewModel blog)
        {
            var item = _contentRepository.Get<BlogItemPage>(ContentReference.Parse(blog.ContentLink));
            item = item.CreateWritableClone() as BlogItemPage;
            item.MainBody = new XhtmlString(blog.Post);
            item.MetaDescription = blog.MetaDescription;
            item.MetaKeywords = blog.MetaKeywords.Split(',');
            item.MetaTitle = blog.MetaTitle;
            item.TeaserText = blog.Title;
            _contentRepository.Save(item, SaveAction.Publish, AccessLevel.NoAccess);
            return RedirectToAction("Index", "BlogManage");
        }


        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult CreateNewBlog(string blogHeading)
        {
            var blog = _contentRepository.GetDefault<BlogItemPage>(BlogUserStartPage.ContentLink);
            blog.TeaserText = blogHeading;
            blog.Name = blogHeading;
            _contentRepository.Save(blog, SaveAction.Default, AccessLevel.NoAccess);
            return RedirectToAction("EditBlog", new { blogid = blog.ContentLink.ID });
        }


    }
}