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
    public class EmployeeLocationPageController :  PageControllerBase<EmployeeLocationPage>
    {
        private const int MaxResults = 1000;
        private readonly IClient _searchClient;
        private readonly IFindUIConfiguration _findUIConfiguration;

        public EmployeeLocationPageController(
            IClient searchClient, 
            IFindUIConfiguration findUIConfiguration)
        {
            _searchClient = searchClient;
            _findUIConfiguration = findUIConfiguration;
        }

        [ValidateInput(false)]
        public ViewResult Index(EmployeeLocationPage currentPage, string q)
        {
            var model = new EmployeeSearchContentModel(currentPage)
                {
                    PublicProxyPath = _findUIConfiguration.AbsolutePublicProxyPath()
                };

            var query = _searchClient.Search<EmployeePage>()
                                    .Filter(x => x.EmployeeLocation.Match(currentPage.Name));

            if (this.ControllerContext.RequestContext.HttpContext.Request.QueryString["expertise"] != null)
            {
                string qs = this.ControllerContext.RequestContext.HttpContext.Request.QueryString["expertise"].ToString();
                query = query.Filter(x => x.EmployeeExpertiseList.Match(qs));
            }

            query = query.TermsFacetFor(x => x.EmployeeExpertiseList).OrderBy(x => x.LastName);

            model.FindResult = query.Take(100).GetPagesResult();

            return View(model);
        }

     

       
    }
}
