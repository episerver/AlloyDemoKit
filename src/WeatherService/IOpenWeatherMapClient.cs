using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WeatherService
{
    internal interface IOpenWeatherMapClient
    {
        /// <summary>
        ///     Gets or sets the application identifier.
        /// </summary>
        /// <value>
        ///     The application identifier.
        /// </value>
        string AppId { get; set; }

        /// <summary>
        ///     Gets the current weather client.
        /// </summary>
        /// <value>
        ///     The current weather.
        /// </value>
        ICurrentWeatherClient CurrentWeather { get; }

        /// <summary>
        ///     Gets the forecast client.
        /// </summary>
        /// <value>
        ///     The forecast.
        /// </value>
        IForecastClient Forecast { get; }

        /// <summary>
        ///     Gets the search client.
        /// </summary>
        /// <value>
        ///     The search.
        /// </value>
        ISearchClient Search { get; }

        //Task<CurrentWeather> GetWeather(string query, Units unit = Units.Imperial);
        //Task<CurrentWeather> GetWeather(int id, Units unit = Units.Imperial);
        //Task<CurrentWeather> GetWeather(double lat, double lng, Units unit = Units.Imperial);
    }
}
