using System.Threading.Tasks;

namespace WeatherService
{
    /// <summary>
    ///     Interface ICurrentWeatherClient.
    /// </summary>
    public interface ICurrentWeatherClient
    {
        /// <summary>
        ///     Gets Current weather by city name.
        /// </summary>
        /// <param name="cityName">Name of the city.</param>
        /// <param name="metric">  The metric system.</param>
        /// <param name="language">The language.</param>
        /// <returns>
        ///     Task {CurrentWeatherResponse}.
        /// </returns>
        Task<CurrentWeatherResponse> GetByName(string cityName, Units unit = Units.Metric, OpenWeatherMapLanguage language = OpenWeatherMapLanguage.EN);

        /// <summary>
        ///     Gets Current weather by coordinates.
        /// </summary>
        /// <param name="coordinates">The coordinates.</param>
        /// <param name="metric">     The metric system.</param>
        /// <param name="language">   The language.</param>
        /// <returns>
        ///     Task {CurrentWeatherResponse}.
        /// </returns>
        Task<CurrentWeatherResponse> GetByCoordinates(Coord coordinates, Units unit = Units.Metric, OpenWeatherMapLanguage language = OpenWeatherMapLanguage.EN);

        /// <summary>
        ///     Gets Current weather by city identifier.
        /// </summary>
        /// <param name="cityId">  The city identifier.</param>
        /// <param name="metric">  The metric.</param>
        /// <param name="language">The language.</param>
        /// <returns>
        ///     Task {CurrentWeatherResponse}.
        /// </returns>
        Task<CurrentWeatherResponse> GetByCityId(int cityId, Units unit = Units.Metric, OpenWeatherMapLanguage language = OpenWeatherMapLanguage.EN);
    }
}
