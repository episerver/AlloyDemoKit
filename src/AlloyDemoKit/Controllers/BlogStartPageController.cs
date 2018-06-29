using System.Web.Mvc;
using AlloyDemoKit.Models.Pages.Models.Pages;
using AlloyDemoKit.Models.ViewModels;
using EPiServer;
using AlloyDemoKit.Business;
using AlloyDemoKit.Controllers;

namespace AlloyDemoKit.Models.Pages.Controllers
{
    public class BlogStartPageController : PageControllerBase<BlogStartPage>
    {
        private readonly ContentLocator contentLocator;
        private readonly IContentLoader contentLoader;

        public BlogStartPageController(ContentLocator contentLocator, IContentLoader contentLoader)
        {
            this.contentLocator = contentLocator;
            this.contentLoader = contentLoader;
        }

        public ActionResult Index(BlogStartPage currentPage)
        {

            var model = new PageViewModel<BlogStartPage>(currentPage);

            return View(model);
        }


    }
}
