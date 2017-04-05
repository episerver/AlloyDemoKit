using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WeatherService
{
    public struct ApiConstants
    {
        public const string BaseUrl = "http://api.openweathermap.org";

        public const string ImageEndpoint = BaseUrl + "/img";
        public const string W = ImageEndpoint + "/w";

        public const string DataEndpoint = "/data/2.5";

        public const string CurrentWeatherEndpoint =  DataEndpoint + "/weather";
        public const string ForecastEndpoint = DataEndpoint + "/forecast";
    }
}
