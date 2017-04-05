using System;
using System.Collections.Generic;
using System.Xml.Serialization;
using Newtonsoft.Json;

namespace WeatherService
{
    /// <summary>
    /// Class CurrentWeatherData.
    /// </summary>
    public class CurrentWeatherData
    {
        /// <summary>
        /// Gets or sets the city coordinates
        /// </summary>
        [JsonProperty("coord")]
        public Coordinates Coord { get; set; }

        /// <summary>
        /// Gets or sets the weather conditions
        /// </summary>
        public List<Weather> Weather { get; set; }

        /// <summary>
        /// Gets or sets the base property
        /// </summary>
        [JsonProperty("base")]
        public string Base { get; set; }

        /// <summary>
        /// Gets or sets the main properties
        /// </summary>
        public Main Main { get; set; }

        /// <summary>
        /// Gets or sets the wind properties
        /// </summary>
        public Wind Wind { get; set; }

        /// <summary>
        /// Gets or sets the cloudiness, %
        /// </summary>
        public Clouds Clouds { get; set; }

        /// <summary>
        /// Gets or sets the rain volume
        /// </summary>
        public Rain Rain { get; set; }

        /// <summary>
        /// Gets or sets the snow volume
        /// </summary>
        public Snow Snow { get; set; }

        /// <summary>
        /// Gets or sets the time of data calculation
        /// </summary>
        [JsonProperty("dt"), JsonConverter(typeof(Epoch2DateTime))]
        public DateTime Timestamp { get; set; }

        /// <summary>
        /// Gets or sets the sys properties
        /// </summary>
        public Sys Sys { get; set; }


        /// <summary>
        /// Gets or sets the city id
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// Gets or sets the city name
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// Gets or set the cod property
        /// </summary>
        [JsonProperty("cod")]
        public string Code { get; set; }
    }
}