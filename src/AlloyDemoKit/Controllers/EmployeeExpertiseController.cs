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
    public class EmployeeExpertiseController :  PageControllerBase<EmployeeExpertise>
    {
        private const int MaxResults = 1000;
        private readonly IClient _searchClient;
        private readonly IFindUIConfiguration _findUIConfiguration;

        public EmployeeExpertiseController(
            IClient searchClient, 
            IFindUIConfiguration findUIConfiguration)
        {
            _searchClient = searchClient;
            _findUIConfiguration = findUIConfiguration;
        }

        [ValidateInput(false)]
        public ViewResult Index(EmployeeExpertise currentPage, string q)
        {
            var model = new EmployeeExpertiseContentModel(currentPage);

            var query = _searchClient.Search<EmployeePage>()
                                    .Filter(x => x.EmployeeExpertiseList.Match(currentPage.Name));

            if (this.ControllerContext.RequestContext.HttpContext.Request.QueryString["location"] != null)
            {
                string qs = this.ControllerContext.RequestContext.HttpContext.Request.QueryString["location"].ToString();
                query = query.Filter(x => x.EmployeeLocation.Match(qs));
            }

            query = query.TermsFacetFor(x => x.EmployeeLocation);

            model.FindResult = query.Take(100).GetPagesResult();

            return View(model);
        }

     

       
    }
}
