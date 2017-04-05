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
        public double Windspeed { get; set; }
        public int Humidity { get; set; }
        public double Pressure { get; set; }
        public double Temperature { get; set; }
        public DateTime Time { get; set; }
        public string Unit { get; set; }
    }
}
