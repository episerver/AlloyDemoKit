using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer;
using EPiServer.Core;
using EPiServer.Security;
using EPiServer.ServiceLocation;
using EPiServer.Web;
using EPiServer.Web.PageExtensions;
using StructureMap.AutoMocking;

namespace AlloyDemoKit.Business.QuickNavigator
{
    [ServiceConfiguration(typeof(IQuickNavigatorItemProvider))]
    public class AddUsefulLinks : IQuickNavigatorItemProvider
    {
        public IDictionary<string, QuickNavigatorMenuItem> GetMenuItems(ContentReference currentContent)
        {
            var menuItems = new Dictionary<string, QuickNavigatorMenuItem>();

            if (PrincipalInfo.Current.Principal.IsInRole("CmsAdmins") || PrincipalInfo.Current.Principal.IsInRole("VisitorGroupAdmins"))
            {
                menuItems.Add("Visitor Groups",
                    new QuickNavigatorMenuItem("/shell/cms/visitorgroups/index/name",
                        UriSupport.ResolveUrlFromUIAsRelativeOrAbsolute("VisitorGroups"), null, "true", null));
            }

            if (PrincipalInfo.HasAdminAccess)
            {
                menuItems.Add("Admin mode",
                    new QuickNavigatorMenuItem("/shell/cms/menu/admin",
                        UriSupport.ResolveUrlFromUIAsRelativeOrAbsolute("Admin/default.aspx"), null, "true", null));
            }

            return menuItems;
        }

        public int SortOrder => int.MaxValue - 10;
    }
}