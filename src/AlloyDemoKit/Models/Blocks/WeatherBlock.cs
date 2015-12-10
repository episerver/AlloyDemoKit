using System;
using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;

namespace AlloyDemoKit.Models.Blocks
{
    [ContentType(DisplayName = "Weather Display Block", GUID = "a7ce8213-33ad-48ef-b5a3-c6e2627f3860", Description = "Displays the current weather for a selected city")]
    [SiteImageUrl("~/Static/gfx/page-type-thumbnail-weather.png")]
    public class WeatherBlock : BlockData
    {

        [Display(
            Description = "Heading to display above weather",
            GroupName = SystemTabNames.Content,
            Order = 0)]
        public virtual string Heading { get; set; }

        [Display(
            Description = "City name",
            GroupName = SystemTabNames.Content,
            Order = 1)]
        public virtual String City { get; set; }


        [Display(
            Description = "Country name",
            GroupName = SystemTabNames.Content,
            Order = 2)]
        public virtual string Country { get; set; }

        [Display( Name = "Display Celsius",
            Description = "Whether to show Celsius",
            GroupName = SystemTabNames.Content,
            Order = 3)]
        public virtual bool DisplayCelsius { get; set; }

        [Display(Name = "Display Fahrenheit",
            Description = "Whether to show Fahrenheit",
            GroupName = SystemTabNames.Content,
            Order = 4)]
        public virtual bool DisplayFahrenheit { get; set; }
        
    }
}