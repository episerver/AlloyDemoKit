using AlloyDemoKit.Models.Blocks;
using AlloyDemoKit.Models.Media;
using AlloyDemoKit.Models.Pages;
using AlloyDemoKit.Models.ViewModels;
using EPiServer;
using EPiServer.Core;
using EPiServer.Framework.Web;
using EPiServer.Globalization;
using EPiServer.ServiceLocation;
using EPiServer.Web;
using EPiServer.Web.Mvc;
using EPiServer.Web.Mvc.Html;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using System.Web.Routing;

namespace AlloyDemoKit.Controllers
{
    public class SnippetsController : Controller
    {
        private readonly IContentLoader _contentLoader;
        private readonly ITemplateResolver _templateResolver;
        private readonly ContentAreaRenderer _contentAreaRenderer;
        private readonly IContentRenderer _contentRender;
        private readonly PartialRequest _partialRequest;

        public SnippetsController(IContentLoader contentLoader,
            ITemplateResolver templateResolver,
            ContentAreaRenderer contentAreaRenderer,
            IContentRenderer contentRender,
            PartialRequest partialRequest)
        {
            _contentLoader = contentLoader;
            _templateResolver = templateResolver;
            _contentAreaRenderer = contentAreaRenderer;
            _contentRender = contentRender;
            _partialRequest = partialRequest;
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
                    Select(GetSnippet).
                    ToList()
            };

            return model;
        }

        private Snippet GetSnippet(IContent content)
        {
            var snippet = new Snippet();
            var version = content as IVersionable;
            if (version != null)
            {
                snippet.Status = version.Status.ToString();
            }

            var tracking = content as IChangeTrackable;
            if (tracking != null)
            {
                snippet.ModifiedDate = tracking.Changed;
            }

            var file = content as IFileProperties;
            if (file != null)
            {
                snippet.TokenId = file.TokenId;
            }

            var block = content as SiteBlockData;
            if (block != null)
            {
                snippet.TokenId = block.TokenId;
            }

            snippet.Name = content.Name;
            snippet.RawHtml = RenderContent(content);
            return snippet;
        }

        private string RenderContent(IContent content)
        {
            if (content == null)
            {
                throw new ContentNotFoundException("Content was not found");
            }

            var model = _templateResolver.Resolve(HttpContext, content.GetOriginalType(), TemplateTypeCategories.Mvc | TemplateTypeCategories.MvcPartial, new string[0]);
            var contentController = ServiceLocator.Current.GetInstance(model.TemplateType) as ControllerBase;
            var controllerName = model.Name.Replace("Controller", "");

            var routeData = new RouteData();
            routeData.Values.Add("currentContent", content);
            routeData.Values.Add("controllerType", model.TemplateType);
            routeData.Values.Add("language", ContentLanguage.PreferredCulture.Name);
            routeData.Values.Add("controller", controllerName);
            routeData.Values.Add("action", "Index");
            routeData.Values.Add("node", content.ContentLink.ID);

            var viewData = new ViewDataDictionary
            {
                { "HasContainer", false }
            };


            var viewContext = new ViewContext(
                new ControllerContext(HttpContext, routeData, contentController),
                new FakeView(),
                viewData,
                new TempDataDictionary(),
                new StringWriter());

            var helper = new HtmlHelper(viewContext, new ViewPage());

            _contentRender.Render(helper, _partialRequest, content, model);

            return viewContext.Writer.ToString();
        }
    }

    public class FakeView : IView
    {
        public void Render(ViewContext viewContext, TextWriter writer)
        {
        }
    }
}