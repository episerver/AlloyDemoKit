using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using EPiServer.Filters;
using EPiServer.ServiceLocation;
using EPiServer.Web.Routing;
using AlloyDemoKit.Models.Blocks;

namespace AlloyDemoKit.Models.Pages.Models.Blocks
{
    /// <summary>
    /// Used to insert a list of date pages where blogs are created
    /// </summary>
    [SiteContentType(GUID = "73F610A5-D705-4BCA-960A-3CA03F312D30", DisplayName="Blog Archive Block")]
    [SiteImageUrl]
    public class BlogArchiveBlock : SiteBlockData
    {
        [DefaultValue("Archive")]
        public virtual string Heading { get; set; }

        public virtual PageReference BlogStart { get; set; }
    }
}