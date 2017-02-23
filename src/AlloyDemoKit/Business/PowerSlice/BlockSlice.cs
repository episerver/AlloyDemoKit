using EPiServer.ServiceLocation;
using EPiServer.Shell.ContentQuery;
using EPiServer.Templates.Alloy.Models.Blocks;
using AlloyDemoKit.Models.Blocks;
using PowerSlice;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AlloyDemoKit.Business.PowerSlice
{
    [ServiceConfiguration(typeof(IContentQuery)), ServiceConfiguration(typeof(IContentSlice))]
    public class BlocksSlice : ContentSliceBase<SiteBlockData>
    {
        public override string Name
        {
            get { return "Blocks"; }
        }
        public override string DisplayName
        {
            get { return "Blocks"; }
        }
    }
}