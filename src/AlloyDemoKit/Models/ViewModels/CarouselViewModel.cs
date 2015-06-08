using EPiServer.Templates.Blog.Mvc.Models.Blocks;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AlloyDemoKit.Models.ViewModels
{
    public class CarouselViewModel
    {
        public List<CarouselItemBlock> Items { get; set; }

        public CarouselBlock CurrentBlock { get; set; }
    }

}
