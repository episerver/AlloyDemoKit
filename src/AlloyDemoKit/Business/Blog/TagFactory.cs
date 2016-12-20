using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.ServiceLocation;
using AlloyDemoKit.Models.Pages.Models.Pages;
using EPiServer.Web.Routing;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AlloyDemoKit.Business;
using EPiServer;

namespace AlloyDemoKit.Models.Pages.Tags
{
    public class TagFactory
    {
        private Injected<ContentLocator> ContentLocator { get; set; }
        private static TagFactory _instance;

        public TagFactory()
        {
        }

        public static TagFactory Instance
        {
            get { return _instance ?? (_instance = new TagFactory()); }
        }

        public string GetTagUrl(PageData currentPage, Category cat)
        {

            var contentLocator = ServiceLocator.Current.GetInstance<IContentRepository>();

            var start = FindParentByPageType(currentPage, typeof(BlogStartPage), contentLocator);

            var urlResolver = ServiceLocator.Current.GetInstance<UrlResolver>();
            var pageUrl = urlResolver.GetUrl(start.ContentLink);

            var url = String.Format("{0}{1}", pageUrl, cat.Name);

            return url;
        }

        protected PageData FindParentByPageType(PageData pd, Type pagetype, IContentRepository contentLocator)
        {
            if (pd is BlogStartPage)
            {
                return pd;
            }
            return FindParentByPageType(contentLocator.Get<PageData>(pd.ParentLink), pagetype, contentLocator);

        }

        public IEnumerable<TagItem> CalculateTags(PageReference startPoint)
        {
            var blogs = ContentLocator.Service.FindPagesByPageType(startPoint, true, typeof(BlogItemPage).GetPageType().ID);

            var tags = new List<TagItem>();

            foreach (var item in blogs)
            {
                foreach (var catID in item.Category)
                {
                    var categoryRepository = ServiceLocator.Current.GetInstance<CategoryRepository>();
                    var cat = categoryRepository.Get(catID);

                    var tagitem = tags.Where(x => x.TagName == cat.Name).FirstOrDefault();

                    if (tagitem == null)
                    {
                        tags.Add(new TagItem()
                        {
                            Count = 1,
                            TagName = cat.Name
                        });
                    }
                    else
                    {
                        tagitem.Count++;
                    }
                }

            }

            //Now we have all tags and the count, lets find the highest count as well as the lowest count
            int largestCount = 0;
            int smallestCount = 0;

           tags = tags.OrderBy(x => x.Count).ToList();

           smallestCount = tags[0].Count;
           largestCount = tags[tags.Count - 1].Count;

           foreach (var tag in tags)
           {
               double weightPercent = (double.Parse(tag.Count.ToString()) / largestCount) * 100;
               int weight = 0;


               if (weightPercent >= 99)
               {
                   //heaviest
                   weight = 1;
               }
               else if (weightPercent >= 70)
               {
                   weight = 2;
               }
               else if (weightPercent >= 40)
               {
                   weight = 3;
               }
               else if (weightPercent >= 20)
               {
                   weight = 4;
               }
               else if (weightPercent >= 3)
               {
                   //weakest
                   weight = 5;
               }
               else
               {
                   // use this to filter out all low hitters
                   weight = 0;
               }

               tag.Weight = weight;

           }

           return tags;

        }
    }
}