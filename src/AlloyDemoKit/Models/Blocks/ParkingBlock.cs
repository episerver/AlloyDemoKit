using System;
using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;

namespace AlloyDemoKit.Models.Blocks
{
    [ContentType(DisplayName = "Parking Block", GUID = "eabb66f4-bff0-4fdb-8b28-d8891f0796ee", Description = "Displays information for a parking location")]
    [SiteImageUrl("~/Static/gfx/block-thumbnail-parking.png")]
    public class ParkingBlock : SiteBlockData
    {
        
        [CultureSpecific]
        [Display(
            GroupName = SystemTabNames.Content,
            Order = 1)]
        public virtual String Heading { get; set; }

        
        [Display(
            GroupName = SystemTabNames.Content,
            Order = 2)]
        [Required]
        [UIHint(Global.SiteUIHints.Parking)]
        public virtual String Location { get; set; }
    }
}