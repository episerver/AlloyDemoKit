using Newtonsoft.Json;

namespace WeatherService
{
    public class Rain
    {
        [JsonProperty("3h")]
        public double In3h { get; set; }
    }
}
