using EPiServer.ServiceLocation;
using EPiServer.Shell.ContentQuery;
using EPiServer.Web;
using AlloyDemoKit.Models.Pages.Models.Pages;
using PowerSlice;
using System.Collections.Generic;
using AlloyDemoKit.Models.Pages;

namespace AlloyDemoKit.Business.PowerSlice
{
    [ServiceConfiguration(typeof(IContentQuery)), ServiceConfiguration(typeof(IContentSlice))]
    public class BlogSlice : ContentSliceBase<BlogItemPage>
    {
        public override string Name
        {
            get { return "Blogs"; }
        }

        public override string DisplayName
        {
            get { return "Blogs"; }
        }
    }
}