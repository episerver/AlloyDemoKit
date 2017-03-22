using System;
using EPiServer;
using EPiServer.Core;
using EPiServer.Framework.Web;
using EPiServer.Globalization;
using EPiServer.ServiceLocation;
using EPiServer.Web;
using EPiServer.Web.Mvc;
using System.IO;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using AlloyDemoKit.Models.Blocks;
using AlloyDemoKit.Models.Media;
using AlloyDemoKit.Models.ViewModels;

namespace AlloyDemoKit.Helpers
{
    public static class IContentExtensions
    {
        private static readonly ITemplateResolver TemplateResolver = ServiceLocator.Current.GetInstance<ITemplateResolver>();
        private static readonly IContentRenderer ContentRender = ServiceLocator.Current.GetInstance<IContentRenderer>();
        private static readonly PartialRequest PartialRequest = ServiceLocator.Current.GetInstance<PartialRequest>();

        public static string RenderContent(this IContent content)
        {
            if (content == null)
            {
                throw new ContentNotFoundException("Content was not found");
            }

            var model = TemplateResolver.Resolve(HttpContext.Current, content.GetOriginalType(), TemplateTypeCategories.Mvc | TemplateTypeCategories.MvcPartial, new string[0]);
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
                new ControllerContext(new HttpContextWrapper(HttpContext.Current), routeData, contentController),
                new FakeView(),
                viewData,
                new TempDataDictionary(),
                new StringWriter());

            var helper = new HtmlHelper(viewContext, new ViewPage());

            ContentRender.Render(helper, PartialRequest, content, model);

            return viewContext.Writer.ToString();
        }

        public static Snippet GetSnippet(this IContent content)
        {
            var snippet = new Snippet
            {
                ModifiedDate = DateTime.UtcNow
            };
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
            snippet.RawHtml = content.RenderContent();
            return snippet;
        }
    }

    public class FakeView : IView
    {
        public void Render(ViewContext viewContext, TextWriter writer)
        {
        }
    }
}