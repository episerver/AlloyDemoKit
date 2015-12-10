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
using WeatherService;
using AlloyDemoKit.Models.ViewModels;

namespace AlloyDemoKit.Controllers
{
    public class WeatherBlockController : BlockController<WeatherBlock>
    {
       [OutputCache(Duration = 120)]
        public override ActionResult Index(WeatherBlock currentBlock)
        {
            Client client = new Client();
            var results = client.GetWeather(currentBlock.City, currentBlock.Country);

            WeatherBlockViewModel model = new WeatherBlockViewModel()
            {
                Heading = currentBlock.Heading,
                Location = currentBlock.City + ", " + currentBlock.Country,
                Conditions = results.Conditions,
                Time = results.CurrentTime,
                ShowCelsius = currentBlock.DisplayCelsius,
                ShowFahrenheit = currentBlock.DisplayFahrenheit,
                Celsius = results.Temp.Celsius,
                Fahrenheit = results.Temp.Fahrenheit
            };

            return PartialView("WeatherDisplay", model);
        }
    }
}
