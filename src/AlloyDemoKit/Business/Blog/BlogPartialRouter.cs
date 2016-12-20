using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.Editor;
using AlloyDemoKit.Models.Pages.Models.Pages;
using EPiServer.Web.Routing;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using EPiServer.ServiceLocation;

namespace AlloyDemoKit.Models.Pages.Initialization
{
    public class BlogPartialRouter : IPartialRouter<BlogStartPage, Category>
    {

        public PartialRouteData GetPartialVirtualPath(Category cat, string language, RouteValueDictionary routeValues, RequestContext requestContext)
        {
            var contentLink = requestContext.GetRouteValue("node", routeValues) as ContentReference;

            if (PageEditing.PageIsInEditMode)
            {
                return null;
            }

            return new PartialRouteData
            {
                BasePathRoot = contentLink,
                PartialVirtualPath = String.Format("{0}/", HttpUtility.UrlEncode(cat.Name))
            };

        }


        public object RoutePartial(BlogStartPage content, EPiServer.Web.Routing.Segments.SegmentContext segmentContext)
        {
            //Expected format is Name/<otional>Header/
            var namePart = segmentContext.GetNextValue(segmentContext.RemainingPath);
            if (!String.IsNullOrEmpty(namePart.Next))
            {
                var categoryName = HttpUtility.UrlDecode(namePart.Next);

                if (categoryName != null)
                {
                     var remaingPath = namePart.Remaining;
                    //Update RemainingPath on context.
                    segmentContext.RemainingPath = remaingPath;
                    var categoryRepository = ServiceLocator.Current.GetInstance<CategoryRepository>();
                    var category = categoryRepository.Get(categoryName);
                    segmentContext.RoutedContentLink = content.ContentLink;

                    segmentContext.SetCustomRouteData<Category>("category", category);


                    return content;
                }
            }

            return null;
        }
    }
}