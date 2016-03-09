using System;
using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using EPiServer.SpecializedProperties;

namespace AlloyDemoKit.Models.Pages
{
    [ContentType(DisplayName = "Profile Page", GUID = "b626c743-e043-4056-88fc-d8f8abe8d400", Description = "This page will be used to display a logged in user's profile.")]
    [SiteImageUrl(Global.StaticGraphicsFolderPath + "/icons/blocks/CMS-icon-block-17.png")]
    public class ProfilePage : SitePageData
    {
        [CultureSpecific]
        [Display(
            Name = "Profile Header",
            Description = "This will display header text on top of the user's profile",
            GroupName = SystemTabNames.Content,
            Order = 100)]
        public virtual String ProfileHeader { get; set; }

        [CultureSpecific]
        [Display(
            Name = "Main Body",
            Description = "This will display main body.",
            GroupName = SystemTabNames.Content,
            Order = 200)]
        public virtual XhtmlString MainBody { get; set; }

        [CultureSpecific]
        [Display(
            Name = "Main Content Area",
            Description = "This will display the main content area.",
            GroupName = SystemTabNames.Content,
            Order = 300)]
        public virtual ContentArea MainContentArea { get; set; }

        [CultureSpecific]
        [Display(
            Name = "Left Hand Content Area",
            Description = "This will display the main content area.",
            GroupName = SystemTabNames.Content,
            Order = 300)]
        public virtual ContentArea LeftHandContentArea { get; set; }
    }
}