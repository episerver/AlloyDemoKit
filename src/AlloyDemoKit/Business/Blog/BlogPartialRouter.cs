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

namespace AlloyDemoKit.Models.Pages.Business.Initialization
{
    public class BlogPartialRouter : IPartialRouter<BlogStartPage, Category>
    {

        public PartialRouteData GetPartialVirtualPath(Category cat, string language, RouteValueDictionary routeValues, RequestContext requestContext)
        {
            var contentLink = ContentRoute.GetValue("node", requestContext, routeValues) as ContentReference;
         
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
                    var category = Category.Find(categoryName);
                    segmentContext.RoutedContentLink = content.ContentLink;

                    segmentContext.SetCustomRouteData<Category>("category", category);
                

                    return content;
                }

                //var user = _securityHandler.GetUserByUserName(SlugDecode(namePart.Next));
                //if (user != null)
                //{
                //    var blog = _myPageHandler.GetMyPage(user).Blog;

                //    var remaingPath = namePart.Remaining;
                //    segmentContext.SetCustomRouteData<Blog>(BlogPostKey, blog);

                //    //Check if the optional Header part is present
                //    var headerPart = segmentContext.GetNextValue(namePart.Remaining);
                //    if (!String.IsNullOrEmpty(headerPart.Next))
                //    {
                //        var blogEntry = GetBlogEntry(blog, headerPart);
                //        if (blogEntry != null)
                //        {
                //            remaingPath = headerPart.Remaining;
                //            segmentContext.SetCustomRouteData<Entry>(BlogEntryKey, blogEntry);
                //        }
                //    }

             

                    //We do not change the page which is routed to. Instead we set routed blog/entry on request 
                    //through SetCustomRouteData which can then be consumed from MyBlog page.
                //    return content;
                //}
            }

            return null;
        }
    }
}