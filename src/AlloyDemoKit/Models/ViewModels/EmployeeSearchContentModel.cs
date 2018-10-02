using System;
using System.Collections.Generic;
using System.Web;
using AlloyDemoKit.Models.Pages;
using EPiServer.Find.Api.Facets;
using EPiServer.Find.Cms;
using EPiServer.Find.UnifiedSearch;
using EPiServer.Web;

namespace AlloyDemoKit.Models.ViewModels
{
    public class EmployeeSearchPageContentModel : PageViewModel<EmployeeSearchPage>
    {
        public EmployeeSearchPageContentModel(EmployeeSearchPage currentPage)
            : base(currentPage)
        {

        }

        public PagesResult<EmployeePage> FindResult;

        public List<string> ExpertiseItems;

        public List<string> Locations;
    }

    public class EmployeeExpertiseContentModel : PageViewModel<EmployeeExpertise>
    {
        public EmployeeExpertiseContentModel(EmployeeExpertise currentPage)
            : base(currentPage)
        {

        }

        public PagesResult<EmployeePage> FindResult;
    }

    public class EmployeeSearchContentModel : PageViewModel<EmployeeLocationPage>
    {
        public EmployeeSearchContentModel(EmployeeLocationPage currentPage)
            : base(currentPage)
        {

        }

        public PagesResult<EmployeePage> FindResult;

        public TermsFacet ExpertiseFacet;

        public UnifiedSearchResults Hits { get; set; }

        public string PublicProxyPath { get; set; }

        public string GetSectionGroupUrl(string groupName)
        {
            string url = UriUtil.AddQueryString(HttpContext.Current.Request.RawUrl, "t", HttpContext.Current.Server.UrlEncode(groupName));
            url = UriUtil.AddQueryString(url, "p", "1");
            return url;
        }

        public int NumberOfHits
        {
            get { return Hits.TotalMatching; }
        }

        public List<DateRange> PublishedDateRange
        {
            get
            {
                var dateRanges = new List<DateRange>()
                {
                    new DateRange { From = DateTime.Now.AddDays(-1), To = DateTime.Now },
                    new DateRange { From = DateTime.Now.AddDays(-7), To = DateTime.Now.AddDays(-1) },
                    new DateRange { From = DateTime.Now.AddDays(-30), To = DateTime.Now.AddDays(-7) },
                    new DateRange { From = DateTime.Now.AddDays(-365), To = DateTime.Now.AddDays(-365) },
                    new DateRange { From = DateTime.Now.AddYears(-2), To = DateTime.Now.AddDays(-365) },
                };
                return dateRanges;
            }
        }

        public string SectionFilter
        {
            get { return HttpContext.Current.Request.QueryString["t"] ?? string.Empty; }
        }

        //Retrieve the paging page from the query string parameter "p".
        //If no such parameter exists the user hasn't requested a specific
        //page so we default to the first (1).
        public int PagingPage
        {
            get
            {
                if (!int.TryParse(HttpContext.Current.Request.QueryString["p"], out int pagingPage))
                {
                    pagingPage = 1;
                }

                return pagingPage;
            }
        }

        //Calculate the number of paged result listings based on the
        //total number of hits and the PageSize.
        public int TotalPagingPages
        {
            get
            {
                //if (CurrentPage.PageSize > 0)
                if (10 > 0)
                    {
                        return 1 + (Hits.TotalMatching - 1) / 10; // CurrentPage.PageSize;
                }

                //return 0;
            }
        }

        //Create URL for a specific paging page.
        public string GetPagingUrl(int pageNumber)
        {
            return UriUtil.AddQueryString(HttpContext.Current.Request.RawUrl, "p", pageNumber.ToString());
        }

        public string Query
        {
            get { return (HttpContext.Current.Request.QueryString["q"] ?? string.Empty).Trim(); }
        }
    }
}
