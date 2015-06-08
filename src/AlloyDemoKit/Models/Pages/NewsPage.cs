using System.ComponentModel.DataAnnotations;
using EPiServer.DataAbstraction;
using EPiServer.Filters;
using EPiServer.Framework.Localization;
using EPiServer.ServiceLocation;
using AlloyDemoKit.Business;
using AlloyDemoKit.Models.Blocks;
using EPiServer.DataAnnotations;
using EPiServer.Core;
using AlloyDemoKit.Models.Pages.Models.Pages;

namespace AlloyDemoKit.Models.Pages
{
    /// <summary>
    /// Presents a news section including a list of the most recent articles on the site
    /// </summary>
    [SiteContentType(GUID = "638D8271-5CA3-4C72-BABC-3E8779233263")]
    [SiteImageUrl]
    [AvailableContentTypes(
        Availability.Specific,
        Exclude = new[] { typeof(ContainerPage), typeof(ProductPage), typeof(FindPage), typeof(SearchPage), typeof(LandingPage), typeof(ContentFolder), typeof(ContactPage), typeof(BlogItemPage), typeof(BlogStartPage), typeof(BlogListPage) },
        Include = new[] { typeof(ArticlePage), typeof(StandardPage), typeof(NewsPage) })] // Pages we can create under the news page...
    public class NewsPage : StandardPage
    {
        [Display(
            GroupName = SystemTabNames.Content,
            Order = 305)]
        public virtual PageListBlock NewsList { get; set; }

        public override void SetDefaultValues(ContentType contentType)
        {
            base.SetDefaultValues(contentType);

            NewsList.Count = 20;
            NewsList.Heading = ServiceLocator.Current.GetInstance<LocalizationService>().GetString("/newspagetemplate/latestnews");
            NewsList.IncludeIntroduction = true;
            NewsList.IncludePublishDate = true;
            NewsList.Recursive = true;
            NewsList.PageTypeFilter = typeof(ArticlePage).GetPageType();
            NewsList.SortOrder = FilterSortOrder.PublishedDescending;
        }
    }
}
