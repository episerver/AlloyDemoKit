using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Serialization;

namespace WeatherService
{
    /// <summary>
    ///     Class ApiClientBase.
    /// </summary>
    /// <seealso cref="T:OpenWeatherMap.IApiClientBase"/>
    internal class ApiClientBase : IApiClientBase
    {
        /// <summary>
        ///     Initializes a new instance of the OpenWeatherMap.ApiClientBase class.
        /// </summary>
        /// <param name="request">The openweathermap request.</param>
        /// <param name="segment">The segment.</param>
        protected ApiClientBase(IOpenWeatherMapRequest request, string segment)
        {
            request.Uri = request.Uri.AddSegment(segment);
            this.Request = request;
        }

        /// <summary>
        ///     Gets or sets the openweathermap request.
        /// </summary>
        /// <value>
        ///     The request.
        /// </value>
        /// <seealso cref="P:OpenWeatherMap.IApiClientBase.Request"/>
        public IOpenWeatherMapRequest Request { get; set; }

        /// <summary>
        ///     Gets by name.
        /// </summary>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="cityName">Name of the city.</param>
        /// <param name="unit">  The metric.</param>
        /// <param name="language">The language.</param>
        /// <param name="count">   The count.</param>
        /// <param name="accuracy">The accuracy.</param>
        /// <returns>
        ///     The by name.
        /// </returns>
        internal Task<T> GetByName<T>(string cityName, Units? unit, OpenWeatherMapLanguage? language, int? count, Accuracy? accuracy)
        {
            Ensure.ArgumentNotNullOrEmptyString(cityName, "cityName");
            Ensure.ArgumentNotNull(unit, "metric");
            Ensure.ArgumentNotNull(language, "language");

            this.Request.Parameters.Add("q", cityName.UrlEncode());
            if (unit != Units.Standard)
            {
                this.Request.Parameters.Add("units", unit.ToString().ToLowerInvariant());
            }

            if (language != OpenWeatherMapLanguage.EN)
            {
                this.Request.Parameters.Add("lang", language.ToString().ToLowerInvariant());
            }

            if (count.HasValue)
            {
                this.Request.Parameters.Add("cnt", count.Value.ToString(CultureInfo.InvariantCulture));
            }

            if (accuracy.HasValue)
            {
                this.Request.Parameters.Add("type", accuracy.Value.ToString().ToLowerInvariant());
            }

            return this.RunGetRequest<T>();
        }

        /// <summary>
        ///     Gets by coordinates.
        /// </summary>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="coordinates">The coordinates.</param>
        /// <param name="unit">     The metric.</param>
        /// <param name="language">   The language.</param>
        /// <param name="count">      The count.</param>
        /// <param name="accuracy">   The accuracy.</param>
        /// <returns>
        ///     The by coordinates.
        /// </returns>
        internal Task<T> GetByCoordinates<T>(Coordinates coordinates, Units unit, OpenWeatherMapLanguage language, int? count, Accuracy? accuracy)
        {
            Ensure.ArgumentNotNull(unit, "metric");
            Ensure.ArgumentNotNull(language, "language");
            Ensure.ArgumentNotNull(coordinates, "coordinates");
            Ensure.ArgumentNotNull(coordinates.Latitude, "coordinates.Latitude");
            Ensure.ArgumentNotNull(coordinates.Longitude, "coordinates.Longitude");

            this.Request.Parameters.Add("lat", coordinates.Latitude.ToString(CultureInfo.InvariantCulture));
            this.Request.Parameters.Add("lon", coordinates.Longitude.ToString(CultureInfo.InvariantCulture));

            if (unit != Units.Standard)
            {
                this.Request.Parameters.Add("units", unit.ToString().ToLowerInvariant());
            }

            if (language != OpenWeatherMapLanguage.EN)
            {
                this.Request.Parameters.Add("lang", language.ToString().ToLowerInvariant());
            }

            if (count.HasValue)
            {
                this.Request.Parameters.Add("cnt", count.Value.ToString(CultureInfo.InvariantCulture));
            }

            if (accuracy.HasValue)
            {
                this.Request.Parameters.Add("type", accuracy.Value.ToString().ToLowerInvariant());
            }

            return this.RunGetRequest<T>();
        }

        /// <summary>
        ///     Gets by city identifier.
        /// </summary>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="cityId">  Identifier for the city.</param>
        /// <param name="unit">  The metric.</param>
        /// <param name="language">The language.</param>
        /// <param name="count">   The count.</param>
        /// <returns>
        ///     The by city identifier.
        /// </returns>
        internal Task<T> GetByCityId<T>(int cityId, Units unit, OpenWeatherMapLanguage language, int? count)
        {
            Ensure.ArgumentNotNull(unit, "metric");
            Ensure.ArgumentNotNull(language, "language");

            this.Request.Parameters.Add("id", cityId.ToString(CultureInfo.InvariantCulture));

            if (unit != Units.Standard)
            {
                this.Request.Parameters.Add("units", unit.ToString().ToLowerInvariant());
            }

            if (language != OpenWeatherMapLanguage.EN)
            {
                this.Request.Parameters.Add("lang", language.ToString().ToLowerInvariant());
            }

            if (count.HasValue)
            {
                this.Request.Parameters.Add("cnt", count.Value.ToString(CultureInfo.InvariantCulture));
            }

            return this.RunGetRequest<T>();
        }

        /// <summary>
        ///     Executes the get request operation.
        /// </summary>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <returns>
        ///     A Task&lt;T&gt;
        /// </returns>
        Task<T> RunGetRequest<T>()
        {
            this.Request.Parameters.Add("mode", "xml");
            var uri = this.Request.Uri.AddQuery(this.Request.Parameters.ToUrlParameters());
            this.Request.Request = new HttpRequestMessage(HttpMethod.Get, uri);

            return this.Send<T>();
        }

        /// <summary>
        ///     Send this message.
        /// </summary>
        /// <exception cref="OpenWeatherMapException">Thrown when an Open Weather Map error condition
        /// occurs.</exception>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <returns>
        ///     A Task&lt;T&gt;
        /// </returns>
        async Task<T> Send<T>()
        {
            HttpResponseMessage response;
            try
            {
                response = await this.Request.HttpClient.SendAsync(this.Request.Request);
            }
            catch (Exception ex)
            {
                throw new OpenWeatherMapException(ex);
            }

            if (!response.IsSuccessStatusCode)
            {
                throw new OpenWeatherMapException(response);
            }

            var responseString = await response.Content.ReadAsStringAsync();

            // OpenWeatherMap returns errors with json
            if (string.IsNullOrEmpty(responseString) || responseString.StartsWith("{", StringComparison.Ordinal))
            {
                throw new OpenWeatherMapException(response);
            }

            var responseStream = await response.Content.ReadAsStreamAsync();
            var xmlSerializer = new XmlSerializer(typeof(T));
            var xmlReader = XmlReader.Create(responseStream);
            if (xmlSerializer.CanDeserialize(xmlReader))
            {
                return (T)xmlSerializer.Deserialize(xmlReader);
            }

            throw new OpenWeatherMapException(response);
        }
    }
}
