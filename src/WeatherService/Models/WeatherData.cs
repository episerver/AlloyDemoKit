using System;

namespace WeatherService.Models
{
    public class WeatherData
    {
        public string LocationName { get; set; }
        public DateTime CurrentTime { get; set; }
        public string Conditions { get; set; }
        public Temperature Temp { get; set; }

        public WeatherData()
        {
            Temp = new Temperature();
        }
    }
}
