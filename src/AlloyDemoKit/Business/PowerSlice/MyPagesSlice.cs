using EPiServer.Cms.Shell.UI.Rest.ContentQuery;
using EPiServer.Core;
using EPiServer.Find;
using EPiServer.ServiceLocation;
using EPiServer.Shell.ContentQuery;
using AlloyDemoKit.Models.Pages;
using PowerSlice;
using System.Web;

namespace AlloyDemoKit.Business.PowerSlice
{
    [ServiceConfiguration(typeof(IContentQuery)), ServiceConfiguration(typeof(IContentSlice))]
    public class MyPagesSlice : ContentSliceBase<SitePageData>
    {
        public override string Name
        {
            get { return "My Pages"; }
        }
        public override string DisplayName
        {
            get { return "My Pages"; }
        }

        protected override ITypeSearch<SitePageData> Filter(ITypeSearch<SitePageData> searchRequest, ContentQueryParameters parameters)
        {
            var userName = HttpContext.Current.User.Identity.Name;
            return searchRequest.Filter(x => x.MatchTypeHierarchy(typeof(IChangeTrackable)) & ((IChangeTrackable)x).CreatedBy.Match(userName));
        }
    }
}