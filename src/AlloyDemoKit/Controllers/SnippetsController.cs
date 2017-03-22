using AlloyDemoKit.Helpers;
using AlloyDemoKit.Models.Pages;
using AlloyDemoKit.Models.ViewModels;
using EPiServer;
using EPiServer.Core;
using EPiServer.Web;
using System.Linq;
using System.Web.Mvc;

namespace AlloyDemoKit.Controllers
{
    public class SnippetsController : Controller
    {
        private readonly IContentLoader _contentLoader;

        public SnippetsController(IContentLoader contentLoader)
        {
            _contentLoader = contentLoader;
        }

        public ActionResult Index()
        {
            return View(GetViewModel());
        }

        private SnippetViewModel GetViewModel()
        {
            var start = _contentLoader.Get<StartPage>(SiteDefinition.Current.StartPage);
            if (start == null || ContentReference.IsNullOrEmpty(start.SnippetReference))
            {
                return new SnippetViewModel();
            }

            var model = new SnippetViewModel
            {
                Snippets = _contentLoader.GetChildren<IContent>(start.SnippetReference).
                    Select(x => x.GetSnippet()).
                    ToList()
            };

            return model;
        }
        
    }

    
}