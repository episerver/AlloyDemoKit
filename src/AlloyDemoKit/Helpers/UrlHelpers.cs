using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using EPiServer.Core;
using EPiServer.Globalization;
using EPiServer.ServiceLocation;
using EPiServer.Web.Routing;
using EPiServer;
using AlloyDemoKit.Models.Pages;

namespace AlloyDemoKit.Helpers
{
    public static class UrlHelpers
    {
        /// <summary>
        /// Returns the target URL for a ContentReference. Respects the page's shortcut setting
        /// so if the page is set as a shortcut to another page or an external URL that URL
        /// will be returned.
        /// </summary>
        public static IHtmlString PageLinkUrl(this UrlHelper urlHelper, ContentReference contentLink)
        {
            if(ContentReference.IsNullOrEmpty(contentLink))
            {
                return MvcHtmlString.Empty;
            }

            var contentLoader = ServiceLocator.Current.GetInstance<IContentLoader>();
            var page = contentLoader.Get<PageData>(contentLink);

            return PageLinkUrl(urlHelper, page);
        }

        /// <summary>
        /// Returns the target URL for a page. Respects the page's shortcut setting
        /// so if the page is set as a shortcut to another page or an external URL that URL
        /// will be returned.
        /// </summary>
        public static IHtmlString PageLinkUrl(this UrlHelper urlHelper, PageData page)
        {
            var urlResolver = ServiceLocator.Current.GetInstance<UrlResolver>();
            switch (page.LinkType)
            {
                case PageShortcutType.Normal:
                case PageShortcutType.FetchData:
                    return new MvcHtmlString(urlResolver.GetUrl(page.ContentLink));

                case PageShortcutType.Shortcut:
                    var shortcutProperty = page.Property["PageShortcutLink"] as PropertyPageReference;
                    if (shortcutProperty != null && !ContentReference.IsNullOrEmpty(shortcutProperty.ContentLink))
                    {
                        return urlHelper.PageLinkUrl(shortcutProperty.ContentLink);
                    }
                    break;

                case PageShortcutType.External:
                    return new MvcHtmlString(page.LinkURL);
            }
            return MvcHtmlString.Empty;
        }

        public static RouteValueDictionary GetPageRoute(this RequestContext requestContext, ContentReference contentLink)
        {
            var values = new RouteValueDictionary
            {
                [RoutingConstants.NodeKey] = contentLink,
                [RoutingConstants.LanguageKey] = ContentLanguage.PreferredCulture.Name
            };
            return values;
        }

        /// <summary>
        /// Returns the target URL for an Employee location.
        /// </summary>
        public static IHtmlString EmployeeLocationUrl(this UrlHelper urlHelper, string location)
        {
            return WriteShortenedUrl(EmployeeLocationRootUrl(urlHelper).ToString(), location);
        }

        /// <summary>
        /// Returns the Root Page Link Url for the Employee Location Page
        /// </summary>
        /// <param name="urlHelper"></param>
        /// <returns></returns>
        public static IHtmlString EmployeeLocationRootUrl(this UrlHelper urlHelper)
        {
            if (string.IsNullOrEmpty(_locationRootUrl))
            {
                lock (_syncObject)
                {
                    var contentLoader = ServiceLocator.Current.GetInstance<IContentLoader>();
                    var urlResolver = ServiceLocator.Current.GetInstance<UrlResolver>();

                    ContentReference locationRoot = contentLoader.Get<StartPage>(ContentReference.StartPage).EmployeeLocationPageLink;
                    if (locationRoot != null)
                    {
                        _locationRootUrl = urlResolver.GetUrl(locationRoot);
                    }
                }
            }

            return new MvcHtmlString(_locationRootUrl);
        }

        /// <summary>
        /// Returns the target URL for an Employee expertise.
        /// </summary>
        public static IHtmlString EmployeeExpertiseUrl(this UrlHelper urlHelper, string expertise)
        {
            return WriteShortenedUrl(EmployeeExpertiseRootUrl(urlHelper).ToString(), expertise);
        }

        /// <summary>
        /// Returns the Root Page Link Url for the Employee Expertise Page
        /// </summary>
        /// <param name="urlHelper"></param>
        /// <returns></returns>
        public static IHtmlString EmployeeExpertiseRootUrl(this UrlHelper urlHelper)
        {
            if (string.IsNullOrEmpty(_expertiseRootUrl))
            {
                lock (_syncObject)
                {
                    var contentLoader = ServiceLocator.Current.GetInstance<IContentLoader>();
                    var urlResolver = ServiceLocator.Current.GetInstance<UrlResolver>();

                    ContentReference expertiseRoot = contentLoader.Get<StartPage>(ContentReference.StartPage).EmployeeExpertiseLink;
                    if (expertiseRoot != null)
                    {
                        _expertiseRootUrl = urlResolver.GetUrl(expertiseRoot);
                    }
                }
            }

            return new MvcHtmlString(_expertiseRootUrl);
        }

        private static readonly object _syncObject = new object();
        private static string _expertiseRootUrl = string.Empty;
        private static string _locationRootUrl = string.Empty;

        private static IHtmlString WriteShortenedUrl(string root, string segment)
        {
            string fullUrlPath = string.Format("{0}{1}/", root, segment.ToLower().Replace(" ", "-"));

            return new MvcHtmlString(fullUrlPath);
        }
    }
}
