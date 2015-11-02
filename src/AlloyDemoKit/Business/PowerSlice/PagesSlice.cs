using EPiServer.ServiceLocation;
using EPiServer.Shell.ContentQuery;
using AlloyDemoKit.Models.Pages;
using PowerSlice;

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