using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using EPiServer.Core;
using EPiServer.Filters;
using AlloyDemoKit.Models.Pages.Business;
using AlloyDemoKit.Models.Pages.Models.Blocks;
using EPiServer.Web.Mvc;
using EPiServer.Web.Routing;
using EPiServer.ServiceLocation;
using AlloyDemoKit.Models.Pages.Models.Pages;
using EPiServer.Web;
using EPiServer.DataAbstraction;
using AlloyDemoKit.Models.ViewModels;
using EPiServer;
using AlloyDemoKit.Business;
using AlloyDemoKit.Controllers;

namespace AlloyDemoKit.Models.Pages.Controllers
{
    public class BlogStartPageController : PageControllerBase<BlogStartPage>
    {
        private ContentLocator contentLocator;
        private IContentLoader contentLoader;
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
