using HttpClientHelpers;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace WeatherService
{
    public class OpenWeatherMapClient : IOpenWeatherMapClient
    {
        private IOpenWeatherMapSettings _settings;

        public OpenWeatherMapClient(IOpenWeatherMapSettings settings)
        {
            _settings = settings;
        }

        public async Task<CurrentWeather> GetWeather(string query, Units unit = Units.Imperial)
        {
            return await GetRequest<CurrentWeather>("weather", QueryHelper.BuildQueryString(new { q = query, units = unit.ToString().ToLower() }));
        }

        public async Task<CurrentWeather> GetWeather(int id, Units unit = Units.Imperial)
        {
            return await GetRequest<CurrentWeather>("weather", QueryHelper.BuildQueryString(new { id = id, units = unit.ToString().ToLower() }));
        }

        public async Task<CurrentWeather> GetWeather(double lat, double lon, Units unit = Units.Imperial)
        {
            return await GetRequest<CurrentWeather>("weather", QueryHelper.BuildQueryString(new { lat = lat, lon = lon, units = unit.ToString().ToLower() }));
        }

        private async Task<T> GetRequest<T>(string endpoint, string queryString)
        {
            var cli = new HttpClient();
            //cli.DefaultRequestHeaders.Add("x-api-key", _settings.ApiKey);
            var data = await cli.GetAsync(QueryHelper.BuildRequestUrl(ApiConstants.BaseUrl, endpoint, queryString));
            data.EnsureSuccessStatusCode();
            var weatherJson = await data.Content.ReadAsStringAsync();
            return JsonConvert.DeserializeObject<T>(weatherJson);
        }
    }
}
