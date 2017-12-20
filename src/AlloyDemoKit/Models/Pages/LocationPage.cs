using System;
using System.ComponentModel.DataAnnotations;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using EPiServer.Find;
using TedGustaf.Episerver.GoogleMapsEditor.Shell;

namespace AlloyDemoKit.Models.Pages
{
    [ContentType(DisplayName = "Location Page", GUID = "894ae55c-880c-4e3b-a776-3db206eb86d2", Description = "A page displaying a location", GroupName = Global.GroupNames.Specialized)]
    [SiteImageUrl(Global.StaticGraphicsFolderPath + "page-type-thumbnail-standard.png")]
    public class LocationPage : StandardPage
    {
        [Display(GroupName = Global.GroupNames.Location, Name = "Location Name",
            Order =1)]
        public virtual string LocationName { get; set; }

        [Display(GroupName = Global.GroupNames.Location,
                    Order = 2
                    )]
        public virtual string Address { get; set; }

        [Display(
            GroupName = Global.GroupNames.Location,
            Order = 3)]
        public virtual string PostCode { get; set; }


        [Display(   Name = "Select Location",
                    GroupName = Global.GroupNames.Location,
                    Order = 5)]
        [UIHint(GoogleMapsEditorDescriptor.UIHint)]
        public virtual string GoogleLocation { get; set; }

        [Display(
            GroupName = Global.GroupNames.Location,
            Order = 4)]
        public virtual string Country { get; set; }


        [ScaffoldColumn(false)]
        public GeoLocation Coordinates
        {
            get
            {
                if (string.IsNullOrWhiteSpace(GoogleLocation))
                {
                    return null;
                }
                int splitter = GoogleLocation.IndexOf(',');
                if (splitter <= 0)
                {
                    return null;
                }

                double latitude = 0, longitude = 0;
                latitude = Convert.ToDouble(GoogleLocation.Substring(0, splitter));
                longitude = Convert.ToDouble(GoogleLocation.Substring(splitter+1));

                return new GeoLocation(latitude, longitude);
            }
        }
    }
}