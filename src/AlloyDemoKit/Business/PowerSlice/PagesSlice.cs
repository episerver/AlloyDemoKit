using EPiServer.ServiceLocation;
using EPiServer.Shell.ContentQuery;
using AlloyDemoKit.Models.Pages;
using PowerSlice;

namespace AlloyDemoKit.Business.PowerSlice
{
    [ServiceConfiguration(typeof(IContentQuery)), ServiceConfiguration(typeof(IContentSlice))]
    public class PagesSlice : ContentSliceBase<SitePageData>
    {
        public override string Name
        {
            get { return "Pages"; }
        }
        public override string DisplayName
        {
            get { return "Pages"; }
        }
    }
}