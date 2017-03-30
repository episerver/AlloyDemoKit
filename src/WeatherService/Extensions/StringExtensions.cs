using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WeatherService
{
    internal static class StringExtensions
    {
        /// <summary>
        ///     encode string to be URL friendly.
        /// </summary>
        /// <param name="input">The input.</param>
        /// <returns>
        ///     System.String.
        /// </returns>
        //[SuppressMessage("StyleCop.CSharp.DocumentationRules", "SA1630:DocumentationTextMustContainWhitespace", Justification = "Reviewed. Suppression is OK here.")]
        public static string UrlEncode(this string input)
        {
            return Uri.EscapeDataString(input);
        }
    }
}
