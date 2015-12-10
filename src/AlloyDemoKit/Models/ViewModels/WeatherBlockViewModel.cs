using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AlloyDemoKit.Models.ViewModels
{
    public class WeatherBlockViewModel
    {
        public string Heading { get; set; }
        public string Location { get; set; }
        public string Conditions { get; set; }
        public bool ShowCelsius { get; set; }
        public bool ShowFahrenheit { get; set; }
        public double Celsius { get; set; }
        public double Fahrenheit { get; set; }
        public DateTime Time { get; set; }
    }
}
