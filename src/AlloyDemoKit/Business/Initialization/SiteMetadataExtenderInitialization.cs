using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer.Core;
using EPiServer.Framework;
using EPiServer.Framework.Initialization;
using EPiServer.Shell.ObjectEditing;

namespace AlloyDemoKit.Business.Initialization
{
    [InitializableModule]
    [ModuleDependency(typeof(EPiServer.Cms.Shell.InitializableModule))]
    public class SiteMetadataExtenderInitialization : IInitializableModule
    {
        public void Initialize(InitializationEngine context)
        {
            if (context.HostType == HostType.WebApplication)
            {
                var registry = context.Locate.Advanced.GetInstance<MetadataHandlerRegistry>();
                registry.RegisterMetadataHandler(typeof(ContentData), new ContentCreateMetadataExtender());
            }
        }

        public void Preload(string[] parameters) { }

        public void Uninitialize(InitializationEngine context) { }
    }
}