using AlloyDemoKit.Models.Pages;
using AlloyDemoKit.Models.ViewModels;
using EPiServer.MarketingAutomation.Salesforce.Contracts.DataClasses;
using EPiServer.MarketingAutomationIntegration.Salesforce.Framework;
using EPiServer.Personalization;
using EPiServer.ServiceLocation;
using EPiServer.Shell.Security;
using EPiServer.Web.Routing;
using System;
using System.Collections.Generic;
using System.Security.Principal;
using System.Web.Mvc;

namespace AlloyDemoKit.Business
{
    /// <summary>
    /// Intercepts actions with view models of type IPageViewModel and populates the view models
    /// Layout and Section properties.
    /// </summary>
    /// <remarks>
    /// This filter frees controllers for pages from having to care about common context needed by layouts
    /// and other page framework components allowing the controllers to focus on the specifics for the page types
    /// and actions that they handle. 
    /// </remarks>
    public class PageContextActionFilter : IResultFilter
    {
        private readonly PageViewContextFactory _contextFactory;
        private readonly SalesforceManager _salesforceManager = new SalesforceManager();
        private  Injected<UIUserProvider> _userManager;

        public PageContextActionFilter(PageViewContextFactory contextFactory)
        {
            _contextFactory = contextFactory;
        }

        public void OnResultExecuting(ResultExecutingContext filterContext)
        {
            var viewModel = filterContext.Controller.ViewData.Model;

            var model = viewModel as IPageViewModel<SitePageData>;
            if (model != null)
            {
                var currentContentLink = filterContext.RequestContext.GetContentLink();
                
                var layoutModel = model.Layout ?? _contextFactory.CreateLayoutModel(currentContentLink, filterContext.RequestContext);
                
                var layoutController = filterContext.Controller as IModifyLayout;
                if(layoutController != null)
                {
                    layoutController.ModifyLayout(layoutModel);
                }
                
                model.Layout = layoutModel;

                if (model.Section == null)
                {
                    model.Section = _contextFactory.GetSection(currentContentLink);
                }

                model.SalesForceProperties = GetSalesforceProperties(filterContext.HttpContext.User);

            }


        }

        public void OnResultExecuted(ResultExecutedContext filterContext)
        {
        }

        private Dictionary<string, string> GetSalesforceProperties(IPrincipal principal)
        {
            var profile = EPiServerProfile.Current;
            if (profile == null)
            {
                return new Dictionary<string, string>();
            }
            var key = profile.GetPropertyValue("SalesForceKey");
            if (key != null && !String.IsNullOrEmpty(key.ToString()))
            {
                var lookupcriteria = new Dictionary<string, object>
                {
                    {"id", key.ToString()}
                };
                return _salesforceManager.GetObject(ObjectType.Contact, lookupcriteria);
            }

            if (!principal.Identity.IsAuthenticated)
            {
                return new Dictionary<string, string>();
            }
            var user = _userManager.Accessor.Invoke().GetUser(principal.Identity.Name);
            if (user == null)
            {
                return new Dictionary<string, string>();
            }
            
            var existingContact = _salesforceManager.GetObject(ObjectType.Contact, new Dictionary<string, object>
            {
                {"email", user.Email}
            });
            if (existingContact != null && existingContact.ContainsKey("Id"))
            {
                profile.SetPropertyValue("SalesForceKey", existingContact["Id"]);
                return existingContact;
            }
            var userProperties = new Dictionary<string, string>
            {
                {"email", user.Email},
                {"LastName", !String.IsNullOrEmpty(profile.LastName) ? profile.LastName : user.Email }
            };
            var id = _salesforceManager.SaveObject(ObjectType.Contact, userProperties);
            if (String.IsNullOrEmpty(id))
            {
                return new Dictionary<string, string>();
            }
            profile.SetPropertyValue("SalesForceKey", id);
            return userProperties;
        }
    }
}
