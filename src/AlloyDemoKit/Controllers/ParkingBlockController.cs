using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EPiServer.Web.Mvc;
using AlloyDemoKit.Models.Blocks;
using AlloyDemoKit.Business.Parking;
using AlloyDemoKit.Models.ViewModels;

namespace AlloyDemoKit.Controllers
{
    public class ParkingBlockController : BlockController<ParkingBlock>
    {
        
        public override ActionResult Index(ParkingBlock currentBlock)
        {
            ParkingGateway gateway = new ParkingGateway();

            ParkingGarage garage = gateway.GetParkingGarage(currentBlock.Location);
            ParkingViewModel model = new ParkingViewModel()
            {
                Heading = currentBlock.Heading,
                Location = currentBlock.Location,
                Address = garage.Address,
                TotalCapacity = garage.ParkingStatus.TotalCapacity,
                AvailableCapacity = garage.ParkingStatus.AvailableCapacity,
                IsOpen = garage.ParkingStatus.Open,
                LastUpdated = Convert.ToDateTime(garage.LastModifiedDate)
            };

            return PartialView(model);
        }
    }
}
