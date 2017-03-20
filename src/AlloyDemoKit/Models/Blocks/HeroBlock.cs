using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using EPiServer.Web;
using System.ComponentModel.DataAnnotations;

namespace AlloyDemoKit.Models.Blocks
{
    [ContentType(DisplayName = "Hero Block", GUID = "dd871c55-3f6e-4450-956e-a20f2d064f2e")]
    public class HeroBlock : SiteBlockData
    {
        [Display(
            GroupName = SystemTabNames.Content, Order = 1)]
        [CultureSpecific]
        [UIHint(UIHint.Image)]
        public virtual ContentReference BackgroundImage { get; set; }

        public virtual HeroBlockCallout Callout { get; set; }

        public virtual Url Link { get; set; }
    }
    
    [ContentType(DisplayName = "Hero Block Callout", GUID = "802DDFAA-4963-4651-9E34-E69362881F90", AvailableInEditMode = false)]
    public class HeroBlockCallout : BlockData
    {
        public virtual bool ShowBackgroundColor { get; set; }
        public virtual string BackgroundColor { get; set; }

        public virtual string PositionTop { get; set; }
        public virtual string PositionBottom { get; set; }
        public virtual string PositionLeft { get; set; }
        public virtual string PositionRight { get; set; }

        public virtual XhtmlString CalloutContent { get; set; }
    }
}