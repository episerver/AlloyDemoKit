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
using AlloyDemoKit.Models.ViewModels;
using WeatherService;

namespace AlloyDemoKit.Controllers
{
    public class WeatherBlockController : BlockController<WeatherBlock>
    {
        [OutputCache(Duration = 120)]
        public override ActionResult Index(WeatherBlock currentBlock)
        {
            string unit = currentBlock.DisplayCelsius ? "C" : "F";
            OpenWeatherMapApiClient client = new OpenWeatherMapApiClient("b6d85c82ae14e8d2819f6f5542565201", units: currentBlock.DisplayCelsius ? Units.Metric : Units.Imperial);
            var results = client.GetWeaterByCityNameAsync(currentBlock.City, currentBlock.Country).Result;

            WeatherBlockViewModel model = new WeatherBlockViewModel()
            {
                Heading = currentBlock.Heading,
                Location = currentBlock.City + ", " + currentBlock.Country,
                Windspeed = results.Wind.Speed,
                Humidity = results.Main.Humidity,
                Pressure = results.Main.Pressure,
                Time = results.Timestamp,
                Temperature = results.Main.Temperature,
                Unit = unit
            };

            return PartialView("WeatherDisplay", model);
        }
    }
}
