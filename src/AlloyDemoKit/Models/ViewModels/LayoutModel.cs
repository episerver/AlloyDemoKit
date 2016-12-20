using System.Collections.Generic;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using EPiServer.Core;
using EPiServer.SpecializedProperties;
using AlloyDemoKit.Models.Blocks;

namespace AlloyDemoKit.Models.ViewModels
{
    public class LayoutModel
    {
        public SiteLogotypeBlock Logotype { get; set; }
        public IHtmlString LogotypeLinkUrl { get; set; }
        public RouteValueDictionary SearchPageRouteValues { get; set; }
        public bool HideHeader { get; set; }
        public bool HideFooter { get; set; }
        public LinkItemCollection ProductPages { get; set; }
        public LinkItemCollection CompanyInformationPages { get; set; }
        public LinkItemCollection NewsPages { get; set; }
        public LinkItemCollection CustomerZonePages { get; set; }
        public bool LoggedIn { get; set; }
        public MvcHtmlString LoginUrl { get; set; }
        public MvcHtmlString LogOutUrl { get; set; }
        public MvcHtmlString SearchActionUrl { get; set; }

        public bool IsInReadonlyMode {get;set;}
    }
}
