using EPiServer.ServiceLocation;
using EPiServer.Shell.ContentQuery;
using EPiServer.Web;
using AlloyDemoKit.Models.Pages.Models.Pages;
using PowerSlice;
using System.Collections.Generic;
using AlloyDemoKit.Models.Pages;

namespace EPiServer.Templates.Alloy.Business.PowerSlice
{
    [ServiceConfiguration(typeof(IContentQuery)), ServiceConfiguration(typeof(IContentSlice))]
    public class BlogSlice : ContentSliceBase<BlogItemPage>
    {
        public override string Name
        {
            get { return "Blogs"; }
        }
        public override IEnumerable<CreateOption> CreateOptions
        {
            get
            {
               
                var contentType = ContentTypeRepository.Load(typeof(BlogItemPage));
                yield return new CreateOption(contentType.LocalizedName, EPiServer.DataFactory.Instance.Get<StartPage>(SiteDefinition.Current.StartPage).BlogPageLink, contentType.ID);
            }
        }
    }
}