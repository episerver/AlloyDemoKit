using System.Collections.Generic;
using System.Linq;
using EPiServer.Core;
using EPiServer.Filters;
using EPiServer.Framework.Web;
using EPiServer.ServiceLocation;
using EPiServer;

namespace AlloyDemoKit.Business
{
    /// <summary>
    /// Extension methods for content
    /// </summary>
    public static class ContentExtensions
    {
        /// <summary>
        /// Shorthand for DataFactory.Instance.Get
        /// </summary>
        /// <typeparam name="TContent"></typeparam>
        /// <param name="contentLink"></param>
        /// <returns></returns>
        public static IContent Get<TContent>(this ContentReference contentLink) where TContent : IContent
        {
            return DataFactory.Instance.Get<TContent>(contentLink);
        }

        /// <summary>
        /// Filters content which should not be visible to the user. 
        /// </summary>
        public static IEnumerable<T> FilterForDisplay<T>(this IEnumerable<T> contents, bool requirePageTemplate = false, bool requireVisibleInMenu = false)
            where T : IContent
        {
            var accessFilter = new FilterAccess();
            var publishedFilter = new FilterPublished();
            contents = contents.Where(x => !publishedFilter.ShouldFilter(x) && !accessFilter.ShouldFilter(x));
            if (requirePageTemplate)
            {
                var templateFilter = ServiceLocator.Current.GetInstance<FilterTemplate>();
                templateFilter.TemplateTypeCategories = TemplateTypeCategories.Page;
                contents = contents.Where(x => !templateFilter.ShouldFilter(x));
            }
            if (requireVisibleInMenu)
            {
                contents = contents.Where(x => VisibleInMenu(x));
            }
            return contents;
        }

        private static bool VisibleInMenu(IContent content)
        {
            if (!(content is PageData page))
            {
                return true;
            }
            return page.VisibleInMenu;
        }
    }
}
