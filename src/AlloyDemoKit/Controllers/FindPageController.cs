using EPiServer;
using EPiServer.Core;
using EPiServer.Find;
using EPiServer.Find.Api.Querying.Queries;
using EPiServer.Find.Framework;
using EPiServer.Find.Cms;
using EPiServer.Find.UnifiedSearch;
using EPiServer.Framework.Web;
using EPiServer.Web;
using EPiServer.Web.Routing;
using AlloyDemoKit.Business;
using AlloyDemoKit.Models.Pages;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;
using AlloyDemoKit.Models.ViewModels;
using EPiServer.Find.Statistics;
using EPiServer.Find.Statistics.Api;
using EPiServer.Find.Framework.Statistics;
using EPiServer.Find.UI;
using EPiServer.Globalization;

namespace AlloyDemoKit.Controllers
{
    public class FindPageController :  PageControllerBase<FindPage>
    {
        private const int MaxResults = 1000;
        private readonly IClient _searchClient;
        private readonly IFindUIConfiguration _findUIConfiguration;     

        public FindPageController(
            IClient searchClient, 
            IFindUIConfiguration findUIConfiguration)
        {
            _searchClient = searchClient;
            _findUIConfiguration = findUIConfiguration;
        }

        [ValidateInput(false)]
        public ViewResult Index(FindPage currentPage, string q)
        {
            var model = new FindSearchContentModel(currentPage)
                {
                    PublicProxyPath = _findUIConfiguration.AbsolutePublicProxyPath()
                };

            if (!string.IsNullOrWhiteSpace(model.Query))
            {
                var query =
                    _searchClient.UnifiedSearchFor(model.Query, _searchClient.Settings.Languages.GetSupportedLanguage(ContentLanguage.PreferredCulture) ??
                                                  Language.None)
                                .UsingSynonyms()
                    //Include a facet whose value we can use to show the total number of hits
                    //regardless of section. The filter here is irrelevant but should match *everything*.
                                .TermsFacetFor(x => x.SearchSection)
                                .FilterFacet("AllSections", x => x.SearchSection.Exists())
                    //Fetch the specific paging page.
                                .Skip((model.PagingPage - 1) * model.CurrentPage.PageSize)
                                .Take(model.CurrentPage.PageSize)
                    //Range facet for date
                    //.RangeFacetFor(x => x.SearchUpdateDate, model.PublishedDateRange.ToArray())
                    //Allow editors (from the Find/Optimizations view) to push specific hits to the top 
                    //for certain search phrases.
                                .ApplyBestBets();

                // obey DNT
                var doNotTrackHeader = System.Web.HttpContext.Current.Request.Headers.Get("DNT");
                // Should Not track when value equals 1
                if (doNotTrackHeader == null || doNotTrackHeader.Equals("0"))
                {
                    query = query.Track();
                }

                //If a section filter exists (in the query string) we apply
                //a filter to only show hits from a given section.
                if (!string.IsNullOrWhiteSpace(model.SectionFilter))
                {
                    query = query.FilterHits(x => x.SearchSection.Match(model.SectionFilter));
                }

                //We can (optionally) supply a hit specification as argument to the GetResult
                //method to control what each hit should contain. Here we create a 
                //hit specification based on values entered by an editor on the search page.
                var hitSpec = new HitSpecification
                {
                    HighlightTitle = model.CurrentPage.HighlightTitles,
                    HighlightExcerpt = model.CurrentPage.HighlightExcerpts
                };

                //Execute the query and populate the Result property which the markup (aspx)
                //will render.
                model.Hits = query.GetResult(hitSpec);
            }
           
            return View(model);
        }

     

       
    }
}
