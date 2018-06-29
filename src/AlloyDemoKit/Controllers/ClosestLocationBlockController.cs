using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EPiServer;
using EPiServer.Core;
using EPiServer.Web;
using EPiServer.Web.Mvc;
using AlloyDemoKit.Models.Blocks;
using EPiServer.Find;
using AlloyDemoKit.Helpers;
using AlloyDemoKit.Models.Pages;
using EPiServer.Find.Framework;
using EPiServer.Find.Cms;
using AlloyDemoKit.Models.ViewModels;
using EPiServer.Framework.DataAnnotations;

namespace AlloyDemoKit.Controllers
{
    [TemplateDescriptor(AvailableWithoutTag = true, Default = true, Inherited = false)]
    public class ClosestLocationBlockController : BlockController<ClosestLocationBlock>
    {
        private readonly IContentLoader contentLoader;

        public ClosestLocationBlockController(IContentLoader loader)
        {
            this.contentLoader = loader;
        }

        public override ActionResult Index(ClosestLocationBlock currentBlock)
        {
            var model = new ClosestLocationViewModel
            {
                Heading = currentBlock.Heading
            };

            var results = SearchClient.Instance.Search<LocationPage>()
                .OrderBy(x => x.Coordinates)
                .DistanceFrom(UserLocation)
                .Take(1)
                .FilterForVisitor()
                .StaticallyCacheFor(new TimeSpan(0, 1, 0))
                .GetContentResult();

            if (results.TotalMatching > 0)
            {
                LocationPage location = results.FirstOrDefault();
                model.Image = location.PageImage;
                model.Link = location.ContentLink;
                model.Name = location.Name;
                model.Description = location.TeaserText;
            }

            return PartialView("ClosestLocation", model);
        }

        protected GeoLocation UserLocation
        {
            get
            {
                var geoLocationResult = GeoPosition.GetUsersLocation();
                return new GeoLocation(geoLocationResult.Location.Latitude, geoLocationResult.Location.Longitude);
            }
        }
    }
}
