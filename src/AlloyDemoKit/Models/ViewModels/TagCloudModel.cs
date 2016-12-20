using System.Collections.Generic;
using EPiServer.Core;
using AlloyDemoKit.Models.Pages.Models.Blocks;
using AlloyDemoKit.Models.Pages.Tags;

namespace EPiServer.Templates.Blog.Mvc.Models.ViewModels
{
    public class TagCloudModel
    {
        public TagCloudModel(TagCloudBlock block)
        {
            Heading = block.Heading;    
        }

        public string Heading { get; set; }

        public IEnumerable<TagItem> Tags { get; set; }

    }
}