using Newtonsoft.Json;

namespace WeatherService
{
    public class Main
    {
        [JsonProperty("temp")]
        public double Temperature { get; set; }

        [JsonProperty("pressure")]
        public double Pressure { get; set; }

        [JsonProperty("humidity")]
        public int Humidity { get; set; }

        [JsonProperty("temp_min")]
        public double MinTemperature { get; set; }

        [JsonProperty("temp_max")]
        public double MaxTemperature { get; set; }

        [JsonProperty("sea_level")]
        public double AtmosphericPressureSeaLevel { get; set; }

        [JsonProperty("grnd_level")]
        public double AtmosphericPressureGroundLevel { get; set; }

        public double? temp_kf { get; set; }
    }
}
