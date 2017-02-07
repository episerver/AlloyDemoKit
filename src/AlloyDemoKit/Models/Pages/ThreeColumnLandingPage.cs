using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;

namespace AlloyDemoKit.Models.Pages
{
    /// <summary>
    /// Used for campaign or landing pages, commonly used for pages linked in online advertising such as AdWords
    /// </summary>
    [SiteContentType(
       GUID = "947EDF31-8C8C-4595-8591-A17DEF75685E",
       DisplayName = "Three column landing page",
       Description = "Three column landing page with three equally sized columns",
       GroupName = Global.GroupNames.Specialized)]
    [SiteImageUrl("~/Static/gfx/page-type-thumbnail-landingpage-threecol.png")]
    public class ThreeColumnLandingPage : LandingPage
    {
        [Display(
            GroupName = SystemTabNames.Content,
            Order=300)]
        [CultureSpecific]
        public virtual ContentArea LeftHandContentArea { get; set; }

        [Display(
            GroupName = SystemTabNames.Content,
            Order = 350)]
        [CultureSpecific]
        public virtual ContentArea RightHandContentArea { get; set; }
    }
}
