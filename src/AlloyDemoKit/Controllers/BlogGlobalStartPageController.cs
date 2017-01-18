using AlloyDemoKit.Models.Pages.Blog;
using AlloyDemoKit.Models.ViewModels;
using EPiServer.Web.Mvc;
using System.Web.Mvc;

namespace AlloyDemoKit.Controllers
{
    public class BlogGlobalStartPageController : PageController<BlogGlobalStartPage>
    {
        public ActionResult Index(BlogGlobalStartPage currentPage)
        {
            var model = new PageViewModel<BlogGlobalStartPage>(currentPage);
            return View(model);
        }
    }
}