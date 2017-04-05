using Newtonsoft.Json;

namespace WeatherService
{
    public class Wind
    {
        [JsonProperty("speed")]
        public double Speed { get; set; }

        public double? Gust { get; set; }

        [JsonProperty("deg")]
        public double Direction { get; set; }
    }
}
