using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using System.ComponentModel.DataAnnotations;

namespace AlloyDemoKit.Models.Pages.Blog
{
    /// <summary>
    /// Used primarily for publishing news articles on the website
    /// </summary>
    [SiteContentType(
        GroupName = "Blog",
        GUID = "EAACADF2-3E89-4117-ADEB-F8D43565D2F4", DisplayName = "Blog Item", Description = "Blog Item created underneath the start page and moved to the right area")]
    [SiteImageUrl(Global.StaticGraphicsFolderPath + "page-type-thumbnail-article.png")]
    [AvailableContentTypes(
     Availability.Specific,
     Include = new[] { typeof(BlogUserStartPage), typeof(BlogItemPage) })]  // Pages we can create under the start page...
      public class BlogItemPage : StandardPage
    {
        [Display(GroupName = SystemTabNames.Content)]
        public virtual ContentArea RightContentArea { get; set; }

    }
}