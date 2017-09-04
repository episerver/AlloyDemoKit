using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EPiServer;
using EPiServer.Core;
using EPiServer.Web;
using EPiServer.Web.Mvc;
using AlloyDemoKit.Models.Blocks;
using EPiServer.ServiceLocation;
using AlloyDemoKit.Models.Media;

namespace AlloyDemoKit.Controllers
{
    public class ImageGalleryBlockController : BlockController<ImageGalleryBlock>
    {
        public override ActionResult Index(ImageGalleryBlock currentBlock)
        {
            var repo = ServiceLocator.Current.GetInstance<IContentRepository>();
            var images = repo.GetChildren<ImageFile>(currentBlock.Images);

            return PartialView(images);
        }
    }
}
