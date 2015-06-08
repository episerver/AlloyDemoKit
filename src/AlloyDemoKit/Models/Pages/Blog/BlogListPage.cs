using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using AlloyDemoKit.Models.Pages.Models.Blocks;
using System.ComponentModel.DataAnnotations;
namespace AlloyDemoKit.Models.Pages.Models.Pages
{
    /// <summary>
    /// Used primarily for publishing news articles on the website
    /// </summary>
    [SiteContentType(
        GroupName = "Blog",
        GUID = "EAADAFF2-3E89-4117-ADEB-F8D43565D2F4", DisplayName = "Blog Item List", Description = "Blog Item List for dates such as year and month")]
    [SiteImageUrl(Global.StaticGraphicsFolderPath + "page-type-thumbnail-article.png")]
    [AvailableContentTypes(
   Availability.Specific,
   Include = new[] { typeof(BlogListPage), typeof(BlogItemPage) })]  // Pages we can create under the start page...
 
    public class BlogListPage : StandardPage
    {

        [Display(GroupName = SystemTabNames.Content)]
        public virtual string Heading { get; set; }

        [Display(GroupName = SystemTabNames.Content)]
        public virtual BlogListBlock BlogList { get; set; }

        [Display(GroupName = SystemTabNames.Content)]
        public virtual string Author { get; set; }

        [Display(GroupName = SystemTabNames.Content)]
        public virtual ContentArea RightContentArea { get; set; }
    }
}