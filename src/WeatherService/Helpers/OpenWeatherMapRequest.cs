using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace WeatherService
{
    /// <summary>
    ///     Class OpenWeatherMapRequest.
    /// </summary>
    /// <seealso cref="T:OpenWeatherMap.IOpenWeatherMapRequest"/>
    internal sealed class OpenWeatherMapRequest : IOpenWeatherMapRequest
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="OpenWeatherMapRequest"/> class.
        /// </summary>
        /// <param name="uri">       The URI.</param>
        /// <param name="httpClient">The HTTP client.</param>
        /// <param name="apiKey">     The application identifier.</param>
        public OpenWeatherMapRequest(Uri uri, HttpClient httpClient, string apiKey)
        {
            Ensure.ArgumentNotNull(uri, "uri");
            Ensure.ArgumentNotNull(httpClient, "httpClient");

            this.Uri = uri;
            this.HttpClient = httpClient;
            this.Parameters = new Dictionary<string, string>();
            if (!string.IsNullOrEmpty(apiKey))
            {
                this.ApiKey = apiKey;
                this.Parameters.Add("APPID", apiKey);
            }
        }

        /// <summary>
        ///     Gets or sets the URI.
        /// </summary>
        /// <value>
        ///     The URI.
        /// </value>
        /// <seealso cref="P:OpenWeatherMap.IOpenWeatherMapRequest.Uri"/>
        public Uri Uri { get; set; }

        /// <summary>
        ///     Gets or sets the application identifier.
        /// </summary>
        /// <value>
        ///     The application identifier.
        /// </value>
        /// <seealso cref="P:OpenWeatherMap.IOpenWeatherMapRequest.AppId"/>
        public string ApiKey { get; set; }

        /// <summary>
        ///     Gets or sets the querystring parameters.
        /// </summary>
        /// <value>
        ///     The parameters.
        /// </value>
        /// <seealso cref="P:OpenWeatherMap.IOpenWeatherMapRequest.Parameters"/>
        public IDictionary<string, string> Parameters { get; set; }

        /// <summary>
        ///     Gets or sets the HTTP client.
        /// </summary>
        /// <value>
        ///     The HTTP client.
        /// </value>
        /// <seealso cref="P:OpenWeatherMap.IOpenWeatherMapRequest.HttpClient"/>
        public HttpClient HttpClient { get; set; }

        /// <summary>
        ///     Gets or sets the request.
        /// </summary>
        /// <value>
        ///     The request.
        /// </value>
        /// <seealso cref="P:OpenWeatherMap.IOpenWeatherMapRequest.Request"/>
        public HttpRequestMessage Request { get; set; }
    }
}
