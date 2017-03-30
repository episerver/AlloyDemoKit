using Newtonsoft.Json;

namespace WeatherService
{

    public class Coord
    {
        [JsonProperty("lat")]
        public double Latitude { get; set; }

        [JsonProperty("lon")]
        public double Longitude { get; set; }
    }
}
