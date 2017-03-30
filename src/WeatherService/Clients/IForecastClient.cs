using System.Threading.Tasks;

namespace WeatherService
{
    public interface IForecastClient
    {
        /// <summary>
        ///     Gets Forecast by city name.
        /// </summary>
        /// <param name="cityName">Name of the city.</param>
        /// <param name="daily">   if set to <c>true</c> [daily].</param>
        /// <param name="metric">  The metric.</param>
        /// <param name="language">The language.</param>
        /// <param name="count">   Number of results.</param>
        /// <returns>
        ///     Task {ForecastResponse}.
        /// </returns>
        Task<ForecastResponse> GetByName(string cityName, bool daily = false, Units unit = Units.Metric, OpenWeatherMapLanguage language = OpenWeatherMapLanguage.EN, int? count = null);

        /// <summary>
        ///     Gets Forecast by coordinates.
        /// </summary>
        /// <param name="coordinates">The coordinates.</param>
        /// <param name="daily">      if set to <c>true</c> [daily].</param>
        /// <param name="metric">     The metric.</param>
        /// <param name="language">   The language.</param>
        /// <param name="count">      The count.</param>
        /// <returns>
        ///     Task {ForecastResponse}.
        /// </returns>
        Task<ForecastResponse> GetByCoordinates(Coord coordinates, bool daily = false, Units unit = Units.Metric, OpenWeatherMapLanguage language = OpenWeatherMapLanguage.EN, int? count = null);

        /// <summary>
        ///     Gets Forecast by city identifier.
        /// </summary>
        /// <param name="cityId">  The city identifier.</param>
        /// <param name="daily">   if set to <c>true</c> [daily].</param>
        /// <param name="metric">  The metric.</param>
        /// <param name="language">The language.</param>
        /// <param name="count">   The count.</param>
        /// <returns>
        ///     Task {ForecastResponse}.
        /// </returns>
        Task<ForecastResponse> GetByCityId(int cityId, bool daily = false, Units unit = Units.Metric, OpenWeatherMapLanguage language = OpenWeatherMapLanguage.EN, int? count = null);
    }
}
