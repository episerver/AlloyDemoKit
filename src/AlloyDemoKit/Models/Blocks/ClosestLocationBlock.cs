using System;
using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;

namespace AlloyDemoKit.Models.Blocks
{
    [ContentType(
        GroupName = Global.GroupNames.Specialized, DisplayName = "Closest Location", GUID = "649f6a33-bd91-45aa-ae0a-d6e5020c6bf7", Description = "Displays the closest location to the current visitor")]
    [SiteImageUrl]
    public class ClosestLocationBlock : SiteBlockData
    {
        [CultureSpecific]
        [Required(AllowEmptyStrings = false)]
        [Display(
            GroupName = SystemTabNames.Content,
            Order = 1)]
        public virtual string Heading { get; set; }
    }
}