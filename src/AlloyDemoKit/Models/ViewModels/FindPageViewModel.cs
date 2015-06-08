using System;
using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using EPiServer.SpecializedProperties;
using EPiServer.Find.UnifiedSearch;
using AlloyDemoKit.Models.Pages;

namespace AlloyDemoKit.Models.ViewModels
{
    public class FindPageViewModel : PageViewModel<FindPage>
    {

        public FindPageViewModel(FindPage currentPage): base(currentPage)
        {
        }

        public UnifiedSearchResults Results { get; set; }
        public string SearchedQuery { get; set; }
        public int NumberOfHits { get; set; }
    }
}