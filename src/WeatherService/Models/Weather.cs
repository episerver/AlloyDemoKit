using Newtonsoft.Json;

namespace WeatherService
{

    public class Weather
    {
        [JsonProperty("id")]
        public ConditionCode Id { get; set; }

        [JsonProperty("main")]
        public string Main { get; set; }

        [JsonProperty("description")]
        public string Description { get; set; }

        [JsonProperty("icon")]
        public string Icon { get; set; }
    }
}
