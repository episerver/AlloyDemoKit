using Newtonsoft.Json;

namespace WeatherService
{

    public class Clouds
    {
        [JsonProperty("all")]
        public int All { get; set; }
    }
}
