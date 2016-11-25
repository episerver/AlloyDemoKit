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
using System.Linq.Expressions;

namespace AlloyDemoKit.Controllers
{
    public class EmployeeSearchPageController :  PageControllerBase<EmployeeSearchPage>
    {
        private const int MaxResults = 1000;
        private readonly IClient _searchClient;
        private readonly IFindUIConfiguration _findUIConfiguration;

        public EmployeeSearchPageController(
            IClient searchClient, 
            IFindUIConfiguration findUIConfiguration)
        {
            _searchClient = searchClient;
            _findUIConfiguration = findUIConfiguration;
        }

        [ValidateInput(false)]
        public ViewResult Index(EmployeeSearchPage currentPage, string q)
        {
            var model = new EmployeeSearchPageContentModel(currentPage);

            var query = _searchClient.Search<EmployeePage>();
            bool runQuery = false;

            if (this.ControllerContext.RequestContext.HttpContext.Request.QueryString["FirstName"] != null &&
                !string.IsNullOrWhiteSpace(this.ControllerContext.RequestContext.HttpContext.Request.QueryString["FirstName"]))
            {
                string qs = this.ControllerContext.RequestContext.HttpContext.Request.QueryString["FirstName"].ToString();
                //query = query.Filter(x => x.FirstName.MatchContainedCaseInsensitive(qs));
                query = query.AddWildCardQuery("*" + qs + "*", x => x.FirstName);
                runQuery = true;
            }

            if (this.ControllerContext.RequestContext.HttpContext.Request.QueryString["LastName"] != null &&
                !string.IsNullOrWhiteSpace(this.ControllerContext.RequestContext.HttpContext.Request.QueryString["LastName"]))
            {
                string qs = this.ControllerContext.RequestContext.HttpContext.Request.QueryString["LastName"].ToString();
                //query = query.Filter(x => x.LastName.MatchCaseInsensitive(qs));
                query = query.AddWildCardQuery("*" + qs + "*", x => x.LastName);
                runQuery = true;
            }

            if (this.ControllerContext.RequestContext.HttpContext.Request.QueryString["location"] != null &&
                !string.IsNullOrWhiteSpace(this.ControllerContext.RequestContext.HttpContext.Request.QueryString["location"]))
            {
                string qs = this.ControllerContext.RequestContext.HttpContext.Request.QueryString["location"].ToString();
                query = query.Filter(x => x.EmployeeLocation.Match(qs));
                query = query.AddWildCardQuery("*" + qs + "*", x => x.EmployeeLocation);
                runQuery = true;
            }

            if (this.ControllerContext.RequestContext.HttpContext.Request.QueryString["expertise"] != null &&
                !string.IsNullOrWhiteSpace(this.ControllerContext.RequestContext.HttpContext.Request.QueryString["expertise"]))
            {
                string qs = this.ControllerContext.RequestContext.HttpContext.Request.QueryString["expertise"].ToString();
                query = query.Filter(x => x.EmployeeExpertiseList.Match(qs));
                runQuery = true;
            }

            query = query.TermsFacetFor(x => x.EmployeeLocation);
            query = query.TermsFacetFor(x => x.EmployeeExpertiseList).OrderBy(x => x.LastName);

            if (runQuery == true)
            {
                model.FindResult = query.Take(1000).GetPagesResult();
            }

            var queryLocations = _searchClient.Search<EmployeeLocationPage>().Take(1000).OrderBy(x => x.Name).GetPagesResult();
            var queryExpertise = _searchClient.Search<EmployeeExpertise>().Take(1000).OrderBy(x => x.Name).GetPagesResult();

            model.ExpertiseItems = new List<string>();
            foreach(var item in queryExpertise)
            {
                model.ExpertiseItems.Add(item.Name);
            }

            model.Locations = new List<string>();
            foreach (var item in queryLocations)
            {
                model.Locations.Add(item.Name);
            }
            return View(model);
        }

     

       
    }

    public static class SearchExtensions
    {
        public static ITypeSearch<T> AddWildCardQuery<T>(
            this ITypeSearch<T> search,
            string query,
            Expression<Func<T, string>> fieldSelector)
        {
            var fieldName = search.Client.Conventions.FieldNameConvention
                .GetFieldNameForAnalyzed(fieldSelector);
            var wildcardQuery = new WildcardQuery(fieldName, query.ToLowerInvariant());
            return new Search<T, WildcardQuery>(search, context =>
            {
                if (context.RequestBody.Query != null)
                {
                    var boolQuery = new BoolQuery();
                    boolQuery.Should.Add(context.RequestBody.Query);
                    boolQuery.Should.Add(wildcardQuery);
                    boolQuery.MinimumNumberShouldMatch = 1;
                    context.RequestBody.Query = boolQuery;
                }
                else
                {
                    context.RequestBody.Query = wildcardQuery;
                }
            });
        }
    }
}
