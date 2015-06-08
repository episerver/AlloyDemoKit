using EPiServer.ServiceLocation;
using EPiServer.Shell.ContentQuery;
using EPiServer.Templates.Alloy.Models.Pages;
using AlloyDemoKit.Models.Pages;
using PowerSlice;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EPiServer.Templates.Alloy.Business.PowerSlice
{
    [ServiceConfiguration(typeof(IContentQuery)), ServiceConfiguration(typeof(IContentSlice))]
    public class PagesSlice : ContentSliceBase<SitePageData>
    {
        public override string Name
        {
            get { return "Pages"; }
        }
    }
}