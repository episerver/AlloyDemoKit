using System.Collections.Generic;
using System.Web;
using AlloyDemoKit.Models.Pages;

namespace AlloyDemoKit.Models.ViewModels
{
    public class SearchContentModel : PageViewModel<SearchPage>
    {
        public SearchContentModel(SearchPage currentPage) : base(currentPage)
        {
        }

        public bool SearchServiceDisabled { get; set; }
        public string SearchedQuery { get; set; }
        public int NumberOfHits { get; set; }
        public IEnumerable<SearchHit> Hits { get; set; }  
    }
}
