using EPiServer.Data.Dynamic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AlloyDemoKit.Models.Pages.Tags
{
    [EPiServerDataStore(AutomaticallyCreateStore = true, AutomaticallyRemapStore=true)]
    public class TagItem : IDynamicData
    {

        public string TagName { get; set; }
        public int Count { get; set; }
        public int Weight { get; set; }
        public string Url { get; set; }

        public EPiServer.Data.Identity Id
        {
            get;
            set;
        }
    }
}