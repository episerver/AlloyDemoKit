using System;
using System.Collections.Generic;
using System.Net.Http;

namespace WeatherService
{
    /// <summary>
    ///     Interface IOpenWeatherMapRequest.
    /// </summary>
    internal interface IOpenWeatherMapRequest
    {
        /// <summary>
        ///     Gets or sets the URI.
        /// </summary>
        /// <value>
        ///     The URI.
        /// </value>
        Uri Uri { get; set; }

        /// <summary>
        ///     Gets or sets the application identifier.
        /// </summary>
        /// <value>
        ///     The application identifier.
        /// </value>
        string ApiKey { get; set; }

        /// <summary>
        ///     Gets or sets the query string parameters.
        /// </summary>
        /// <value>
        ///     The parameters.
        /// </value>
        IDictionary<string, string> Parameters { get; set; }

        /// <summary>
        ///     Gets or sets the HTTP client.
        /// </summary>
        /// <value>
        ///     The HTTP client.
        /// </value>
        HttpClient HttpClient { get; set; }

        /// <summary>
        ///     Gets or sets the request.
        /// </summary>
        /// <value>
        ///     The request.
        /// </value>
        HttpRequestMessage Request { get; set; }
    }
}
