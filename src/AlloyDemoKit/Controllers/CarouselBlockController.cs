using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using EPiServer.Core;
using EPiServer.Filters;
using AlloyDemoKit.Business;
using AlloyDemoKit.Models.Blocks;
using AlloyDemoKit.Models.ViewModels;
using EPiServer.Web.Mvc;
using EPiServer;
using EPiServer.Templates.Blog.Mvc.Models.Blocks;

namespace AlloyDemoKit.Controllers
{
    public class CarouselBlockController : BlockController<CarouselBlock>
    {
        private readonly ContentLocator contentLocator;
        private IContentLoader contentLoader;
        public CarouselBlockController(ContentLocator contentLocator, IContentLoader contentLoader)
        {
            this.contentLocator = contentLocator;
            this.contentLoader = contentLoader;
        }

        public override ActionResult Index(CarouselBlock currentBlock)
        {
            if (currentBlock.MainContentArea == null) {
                return PartialView("Carousel", null);
            }
            var model = new CarouselViewModel
            {
                Items =
                    currentBlock.MainContentArea.FilteredItems.Select(
                        cai => contentLoader.Get<CarouselItemBlock>(cai.ContentLink)).ToList(),
                        CurrentBlock = currentBlock
            };
            

            return PartialView("Carousel", model);
        }

    }
}
