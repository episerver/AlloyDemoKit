using AlloyDemoKit.Models.ViewModels;
using System.Web.Mvc;
using AlloyDemoKit.Models.Pages.Blog;

namespace AlloyDemoKit.Controllers
{
    public class BlogUserStartPageController : PageControllerBase<BlogUserStartPage>
    {
        public ActionResult Index(BlogUserStartPage currentPage)
        {
            var model = new PageViewModel<BlogUserStartPage>(currentPage);
            return View(model);
        }
    }
}
