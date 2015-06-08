using System.Collections.Generic;
using EPiServer.Core;
using AlloyDemoKit.Models.Blocks;

namespace MyProject.Delegate.Models.ViewModels
{
    public class RssReaderBlockViewModel
    {
        public RssReaderBlock CurrentBlock { get; set; }

        public XhtmlString DescriptiveText { get; set; }
        public bool HasHeadingText { get; set; }
        public string Heading { get; set; }
        public List<RssItem> RssList { get; set; }

        public class RssItem
        {
            public string Title { get; set; }
            public string Url { get; set; }
            public string PublishDate { get; set; }
        }
    }
}