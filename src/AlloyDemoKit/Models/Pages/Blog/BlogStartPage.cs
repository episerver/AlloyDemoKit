using EPiServer.Core;
using EPiServer.DataAbstraction;
using AlloyDemoKit.Models.Pages.Models.Blocks;
using System.ComponentModel.DataAnnotations;
using EPiServer.DataAnnotations;
using AlloyDemoKit.Business;

namespace AlloyDemoKit.Models.Pages.Models.Pages
{
    /// <summary>
    /// Used primarily for publishing news articles on the website
    /// </summary>
    [SiteContentType(
        GroupName = "Blog",
        GUID = "EAACADF4-3E89-4117-ADEB-F8D43565D2F4", DisplayName="Blog Start", Description="Blog Start Page with blog items underneath")]
    [SiteImageUrl(Global.StaticGraphicsFolderPath + "page-type-thumbnail-article.png")]
    [AvailableContentTypes(
   Availability.Specific,
   Include = new[] { typeof(BlogListPage), typeof(BlogItemPage) })]  // Pages we can create under the start page...
 
    public class BlogStartPage : StandardPage
    {
        [Display(GroupName = SystemTabNames.Content)]
        public virtual string Heading { get; set; }

        [Display(GroupName = SystemTabNames.Content)]
        public virtual string Author { get; set; }

        [Display(GroupName = SystemTabNames.Content)]
        public virtual BlogListBlock BlogList { get; set; }

        [Display(GroupName = SystemTabNames.Content)]
        public virtual TagCloudBlock TagCloud { get; set; }

        [Display(GroupName = SystemTabNames.Content)]
        public virtual BlogArchiveBlock Archive { get; set; }

        [Display(GroupName = SystemTabNames.Content)]
        public virtual ContentArea RightContentArea { get; set; }

        #region IInitializableContent

        /// <summary>
        /// Sets the default property values on the content data.
        /// </summary>
        /// <param name="contentType">Type of the content.</param>
        public override void SetDefaultValues(ContentType contentType)
        {
            base.SetDefaultValues(contentType);

            BlogList.PageTypeFilter = typeof(BlogItemPage).GetPageType();
            BlogList.Recursive = true;
        }

        #endregion
    }
}