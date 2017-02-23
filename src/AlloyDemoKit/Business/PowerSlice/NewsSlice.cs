using System.Collections.Generic;
using EPiServer.Core;
using EPiServer.ServiceLocation;
using EPiServer.Shell.ContentQuery;
using AlloyDemoKit.Models.Pages;
using PowerSlice;

namespace AlloyDemoKit.Business.PowerSlice
{
    [ServiceConfiguration(typeof(IContentQuery)), ServiceConfiguration(typeof(IContentSlice))]
    public class NewsSlice : ContentSliceBase<NewsPage>
    {
        public override string Name
        {
            get { return "News"; }
        }

        public override string DisplayName
        {
            get { return "News"; }
        }

        public override int Order
        {
            get { return 5; }
        }

        public override bool HideSortOptions
        {
            get
            {
                return false;
            }
        }


    }
}