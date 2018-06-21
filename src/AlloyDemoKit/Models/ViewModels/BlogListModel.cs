using System.Collections.Generic;
using EPiServer.Core;
using AlloyDemoKit.Models.Pages.Models.Blocks;

namespace AlloyDemoKit.Models.ViewModels
{
    public class BlogListModel
    {
        public BlogListModel(BlogListBlock block)
        {
            Heading = block.Heading;
            ShowIntroduction = block.IncludeIntroduction;
            ShowPublishDate = block.IncludePublishDate;
        }
        public string Heading { get; set; }
        public IEnumerable<PageData> Blogs { get; set; }
        public bool ShowIntroduction { get; set; }
        public bool ShowPublishDate { get; set; }
    }
}