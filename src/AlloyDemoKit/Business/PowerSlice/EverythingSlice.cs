using System.Collections.Generic;
using EPiServer.Core;
using EPiServer.ServiceLocation;
using EPiServer.Shell.ContentQuery;
using AlloyDemoKit.Models.Pages;
using PowerSlice;

namespace AlloyDemoKit.Business.PowerSlice
{
    [ServiceConfiguration(typeof(IContentQuery)), ServiceConfiguration(typeof(IContentSlice))]
    public class EverythingSlice : ContentSliceBase<IContent>
    {
        public override string Name
        {
            get { return "Everything"; }
        }

        public override string DisplayName
        {
            get { return "Everything"; }
        }

        public override IEnumerable<CreateOption> CreateOptions
        {
            get
            {
                var options = new List<CreateOption>();
                var newsType = ContentTypeRepository.Load(typeof(NewsPage));
                options.Add(new CreateOption(newsType.LocalizedName, ContentReference.StartPage, newsType.ID));
                var articleType = ContentTypeRepository.Load(typeof(ArticlePage));
                options.Add(new CreateOption(articleType.LocalizedName, ContentReference.StartPage, articleType.ID));
                return options;
            }
        }
    }
}