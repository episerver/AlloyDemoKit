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

namespace AlloyDemoKit.Controllers
{
    public class FindPageController :  PageControllerBase<FindPage>
    {
        private const int MaxResults = 40;
        private readonly SearchService _searchService;
        private readonly ContentSearchHandler _contentSearchHandler;
        private readonly UrlResolver _urlResolver;
        private readonly TemplateResolver _templateResolver;

        public FindPageController(
            SearchService searchService, 
            ContentSearchHandler contentSearchHandler, 
            TemplateResolver templateResolver,
            UrlResolver urlResolver)
        {
            _searchService = searchService;
            _contentSearchHandler = contentSearchHandler;
            _templateResolver = templateResolver;
            _urlResolver = urlResolver;
        }

        [ValidateInput(false)]
        public ViewResult Index(FindPage currentPage, string q)
        {
            //Create a search/query for the entered search text retrieved from the query string.
            var query = SearchClient.Instance.UnifiedSearchFor(q).StatisticsTrack();

            //Filter by Category
            int categoryId = 3;

            var pages = SearchClient.Instance.Search<PageData>()
              .Filter(x => x.Category.Match(categoryId))
              .GetContentResult();

            //Include a facet for sections.
            query = (IQueriedSearch<ISearchContent>)query.TermsFacetFor(x => x.SearchSection);
                //Include a facet whose value we can use to show the total number of hits
                //regardless of section. The filter here is irrelevant but should match *everything*.
                    //.FilterFacet("AllSections", x =>
                    //    x.SearchTitle.Exists()
                    //    | !x.SearchTitle.Exists());
                //Fetch the specific paging page.
                    //.Skip(10 * currentPage.PageSize)
                    //.Take(currentPage.PageSize);
            //Allow editors (from the Find/Optimizations view) to push specific hits to the top 
            //for certain search phrases.


            //We can (optionally) supply a hit specification as argument to the GetResult
            //method to control what each hit should contain. Here we create a 
            //hit specification based on values entered by an editor on the search page.
            var hitSpec = new HitSpecification
            {
                HighlightTitle = currentPage.HighlightTitles,
                HighlightExcerpt = currentPage.HighlightExcerpts,
                ExcerptLength = currentPage.ExcerptLength
            };

            //Execute the query and populate the Result property which the markup (aspx)
            //will render.
            var results = query.GetResult(hitSpec);

            var model = new FindPageViewModel(currentPage)
            {
                Results = results,
                SearchedQuery = q,
                NumberOfHits  = results.TotalMatching
            };

            return View(model);
        }

        private bool HasTemplate(IContent content)
        {
            return _templateResolver.HasTemplate(content, TemplateTypeCategories.Page);
        }

        private bool IsPublished(IVersionable content)
        {
            if (content == null)
                return true;
            return content.Status.HasFlag(VersionStatus.Published);
        }

       
    }
}
