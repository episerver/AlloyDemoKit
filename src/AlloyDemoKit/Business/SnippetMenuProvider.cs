using EPiServer.Security;
using EPiServer.Shell.Navigation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AlloyDemoKit.Business
{
    [MenuProvider]
    public class CsrMenuProvider : IMenuProvider
    {
        public IEnumerable<MenuItem> GetMenuItems()
        {
            return new [] { new UrlMenuItem("Snippets",
                "/global/cms/snippets",
                "/snippets/index")
            {
                SortIndex = 10,
                IsAvailable = (request) => PrincipalInfo.CurrentPrincipal.IsInRole("WebAdmins")
            }};
        }
    }
}