using System.Web.Mvc;
using AlloyDemoKit.Models.Media;
using AlloyDemoKit.Models.ViewModels;
using EPiServer.Web.Mvc;
using EPiServer.Web.Routing;

namespace AlloyDemoKit.Controllers
{
    /// <summary>
    /// Controller for the image file.
    /// </summary>
    public class ImageFileController : PartialContentController<ImageFile>
    {
        private readonly UrlResolver _urlResolver;

        public ImageFileController(UrlResolver urlResolver)
        {
            _urlResolver = urlResolver;
        }

        /// <summary>
        /// The index action for the image file. Creates the view model and renders the view.
        /// </summary>
        /// <param name="currentContent">The current image file.</param>
        public override ActionResult Index(ImageFile currentContent)
        {
            var model = new ImageViewModel
            {
                Url = _urlResolver.GetUrl(currentContent.ContentLink),
                Name = currentContent.Name,
                Copyright = currentContent.Copyright
            };

            return PartialView(model);
        }
    }
}
