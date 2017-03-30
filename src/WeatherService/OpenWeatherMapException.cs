using System;
using System.Net;
using System.Net.Http;

namespace WeatherService
{
    /// <summary>
    ///     Class OpenWeatherMapException.
    /// </summary>
    /// <seealso cref="T:System.Exception"/>
    public sealed class OpenWeatherMapException : Exception
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="OpenWeatherMapException"/> class.
        /// </summary>
        /// <param name="status">The status.</param>
        internal OpenWeatherMapException(HttpStatusCode status)
        {
            this.StatusCode = status;
        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="OpenWeatherMapException"/> class.
        /// </summary>
        /// <param name="response">The response.</param>
        internal OpenWeatherMapException(HttpResponseMessage response)
            : this(response.StatusCode)
        {
            this.Response = response;
        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="OpenWeatherMapException"/> class.
        /// </summary>
        /// <param name="ex">The ex.</param>
        internal OpenWeatherMapException(Exception ex)
            : base("OpenWeatherMap : an error occurred", ex)
        {
        }

        /// <summary>
        ///     Gets the response message.
        /// </summary>
        /// <value>
        ///     The response.
        /// </value>
        public HttpResponseMessage Response { get; private set; }

        /// <summary>
        ///     Gets the status code.
        /// </summary>
        /// <value>
        ///     The status code.
        /// </value>
        public HttpStatusCode StatusCode { get; private set; }
    }
}
