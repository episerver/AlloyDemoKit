using System;
using System.Collections.Generic;

namespace AlloyDemoKit.Models.ViewModels
{
    public class SnippetViewModel
    {
        public SnippetViewModel()
        {
            Snippets = new List<Snippet>();
        }

        public List<Snippet> Snippets { get; set; }
    }

    public class Snippet
    {
        public string Name { get; set; }
        public string TokenId { get; set; }
        public string RawHtml { get; set; }
        public string Status { get; set; }
        public DateTime ModifiedDate { get; set; }
    }
}