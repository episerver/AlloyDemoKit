using System;
using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAnnotations;
using AlloyDemoKit.Models;
using AlloyDemoKit;
using EPiServer.DataAbstraction;

namespace AlloyDemoKit.Models.Blocks
{
    [SiteContentType(
        GUID = "fe935bfb-44b0-4ce2-a448-1d366ff3bbc0",
        Description = "Shows Facebook information for a specific account",
        GroupName = "Social media")]
    [SiteImageUrl]
    public class FacebookBlock : SiteBlockData
    {
        [Display(
            Name = "Accountname",
            GroupName = SystemTabNames.Content,
            Order = 100)]
        public virtual String AccountName { get; set; }
    }
}