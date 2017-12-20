using System.Web.Mvc;
using EPiServer.Framework;
using EPiServer.Framework.Initialization;
using EPiServer.ServiceLocation;

namespace AlloyDemoKit.Business.VisitorGroupUIStyling
{
    [ModuleDependency(typeof(EPiServer.Web.InitializationModule))]
    public class OverrideVisitorGroupStylingInit : IInitializableModule
    {
        public void Initialize(InitializationEngine context)
        {
            GlobalFilters.Filters.Add(ServiceLocator.Current.GetInstance<OverrideVisitorGroupCssAttribute>());
        }

        public void Uninitialize(InitializationEngine context) { }
    }
}