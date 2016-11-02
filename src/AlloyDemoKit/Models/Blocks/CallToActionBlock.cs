using System;
using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using EPiServer.Web;

namespace AlloyDemoKit.Models.Blocks
{
    [ContentType(DisplayName = "Call To Action", GUID = "f82da800-c923-48f6-b701-fd093078c5d9", Description = "Provides a CTA anchor or link")]
    [SiteImageUrl("~/Static/gfx/icons/blocks/CMS-icon-block-26.png")]
    public class CallToActionBlock : SiteBlockData
    {
        private const string AdvTab = "Advanced Options";

        [CultureSpecific]
        [Display(
            Name = "Title",
            Description = "Title displayed",
            GroupName = SystemTabNames.Content,
            Order = 1)]
        public virtual string Title { get; set; }

        [CultureSpecific]
        [Display(           
            GroupName = SystemTabNames.Content,
            Order = 2)]
        public virtual XhtmlString Subtext { get; set; }
        
        [Display(
           GroupName = SystemTabNames.Content,
           Order = 3)]
        public virtual ButtonBlock Button { get; set; }

        [Display(
            Name = "Text Color",
            GroupName = AdvTab,
            Order = 1)]
        public virtual String TextColor { get; set; }

        [Display(            
            Name = "Background Image",
            GroupName = AdvTab,
            Order = 2)]
        [UIHint(UIHint.Image)]
        public virtual ContentReference BackgroundImage { get; set; }

        public override void SetDefaultValues(ContentType contentType)
        {
            base.SetDefaultValues(contentType);

            TextColor = "#000";
        }

    }
}
