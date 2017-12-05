using System;
using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using EPiServer.Web;

namespace AlloyDemoKit.Models.Blocks
{
    [ContentType(DisplayName = "Image Gallery Block", GUID = "2035809e-8797-4758-93e7-d9dade59bb76", Description = "")]
    [SiteImageUrl]
    public class ImageGalleryBlock : SiteBlockData
    {
        [Display(
             Name = "Images",
             Description = "This will link to the media folder with the images for the gallery",
             GroupName = SystemTabNames.Content,
             Order = 1)]
        [Required(AllowEmptyStrings = false)]
        [UIHint(UIHint.AssetsFolder)]
        [CultureSpecific]
        public virtual ContentReference Images { get; set; }
    }
}