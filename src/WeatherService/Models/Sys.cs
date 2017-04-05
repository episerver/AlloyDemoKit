using System;
using Newtonsoft.Json;

namespace WeatherService
{
    public class Sys
    {
        [JsonProperty("message")]
        public double? Message { get; set; }

        [JsonProperty("country")]
        public string Country { get; set; }

        [JsonProperty("sunrise")]
        [JsonConverter(typeof(Epoch2DateTime))]
        public DateTime? Sunrise { get; set; }

        [JsonProperty("sunset")]
        [JsonConverter(typeof(Epoch2DateTime))]
        public DateTime? Sunset { get; set; }

        [JsonProperty("pod")]
        public string PartOfDay { get; set; }
    }
}
