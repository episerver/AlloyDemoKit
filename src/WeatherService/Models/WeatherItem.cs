using System;
using System.Xml.Serialization;

namespace WeatherService
{
    /// <summary>
    /// Class WeatherItem.
    /// </summary>
    public class WeatherItem
    {
        /// <summary>
        /// Gets or sets the city coordinates
        /// </summary>
        public Coord Coord { get; set; }

        /// <summary>
        /// Gets or ssets the weather properties
        /// </summary>
        public Weather[] Weather { get; set; }

        /// <summary>
        /// Gets or sets the base property
        /// </summary>
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
        public DateTime Dt { get; set; }

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
        public string Cod { get; set; }
    }
}