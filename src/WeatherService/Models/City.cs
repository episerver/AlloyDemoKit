using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace WeatherService
{
    public class City
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public Coordinates Coord { get; set; }
        public string Country { get; set; }
        [JsonProperty("cod")]
        public string Code { get; set; }
        public double Message { get; set; }
        [JsonProperty("cnt")]
        public int Count { get; set; }
        public List<ForecastItem> ForecastList { get; set; }

    }
}
