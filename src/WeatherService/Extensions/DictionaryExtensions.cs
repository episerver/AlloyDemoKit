using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WeatherService
{
    internal static class DictionnaryExtensions
    {
        /// <summary>
        ///     Transform the dictionnary into URL parameters.
        /// </summary>
        /// <param name="parameters">The parameters.</param>
        /// <returns>
        ///     System.String.
        /// </returns>
        //[SuppressMessage("StyleCop.CSharp.DocumentationRules", "SA1630:DocumentationTextMustContainWhitespace", Justification = "Reviewed. Suppression is OK here.")]
        public static string ToUrlParameters(this IEnumerable<KeyValuePair<string, string>> parameters)
        {
            var array = parameters.Select(x => string.Format("{0}={1}", Uri.EscapeUriString(x.Key), Uri.EscapeUriString(x.Value))).ToArray();
            return string.Join("&", array);
        }
    }
}
