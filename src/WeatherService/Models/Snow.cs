using Newtonsoft.Json;

namespace WeatherService
{
    public class Snow
    {
        [JsonProperty("3h")]
        public double In3h { get; set; }
    }
}
