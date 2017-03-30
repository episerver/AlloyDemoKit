using System.Threading.Tasks;

namespace WeatherService
{
    public interface ISearchClient
    {
        /// <summary>
        ///     Search by city name.
        /// </summary>
        /// <param name="cityName">Name of the city.</param>
        /// <param name="metric">  The metric.</param>
        /// <param name="language">The language.</param>
        /// <param name="count">   The count.</param>
        /// <param name="accuracy">The accuracy.</param>
        /// <returns>
        ///     Task {SearchResponse}.
        /// </returns>
        Task<SearchResponse> GetByName(string cityName, Units unit = Units.Metric, OpenWeatherMapLanguage language = OpenWeatherMapLanguage.EN, int? count = null, Accuracy? accuracy = null);

        /// <summary>
        ///     Search by coordinates.
        /// </summary>
        /// <param name="coordinates">The coordinates.</param>
        /// <param name="metric">     The metric.</param>
        /// <param name="language">   The language.</param>
        /// <param name="count">      The count.</param>
        /// <param name="accuracy">   The accuracy.</param>
        /// <returns>
        ///     Task {SearchResponse}.
        /// </returns>
        Task<SearchResponse> GetByCoordinates(Coord coordinates, Units unit = Units.Metric, OpenWeatherMapLanguage language = OpenWeatherMapLanguage.EN, int? count = null, Accuracy? accuracy = null);
    }
}
