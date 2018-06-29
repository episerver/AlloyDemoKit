using EPiServer.ServiceLocation;
using EPiServer.Shell.Security;
using Owin;
using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace AlloyDemoKit
{
    public static class SetupAdminAndUsersPage
    {
        private static Lazy<bool> _enabled = new Lazy<bool>( () => false);

        public static bool IsEnabled { get { return _enabled.Value; } set { _enabled = new Lazy<bool>(() => value); } }

        public static void UseSetupAdminAndUsersPage(this IAppBuilder app, Func<bool> validation)
        {
            _enabled = new Lazy<bool>(() => validation() && !IsAnyUserRegistered());
            GlobalFilters.Filters.Add(new RegistrationActionFilterAttribute());
            if (validation()) AddRoute();
        }

        private static bool IsAnyUserRegistered()
        {
            var provider = ServiceLocator.Current.GetInstance<UIUserProvider>();
            var res = provider.GetAllUsers(0, 1, out int totalUsers);
            return totalUsers > 0;
        }

        public class RegistrationActionFilterAttribute : ActionFilterAttribute
        {
            public override void OnActionExecuting(ActionExecutingContext context)
            {
                var registerUrl = VirtualPathUtility.ToAbsolute("~/Register");
                if (IsEnabled && !context.RequestContext.HttpContext.Request.Path.StartsWith(registerUrl))
                {
                    context.Result = new RedirectResult(registerUrl);
                }
            }
        }

        static void AddRoute()
        {
            var routeData = new RouteValueDictionary
            {
                { "Controller", "Register" },
                { "action", "Index" },
                { "id", " UrlParameter.Optional" }
            };
            RouteTable.Routes.Add("Register", new Route("{controller}/{action}/{id}", routeData, new MvcRouteHandler()) { RouteExistingFiles = false });
        }
    }
}
