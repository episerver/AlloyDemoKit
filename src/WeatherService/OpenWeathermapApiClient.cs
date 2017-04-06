using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace WeatherService
{
    public class OpenWeatherMapApiClient
    {
        HttpClient client;

        private string url;
        private string apiKey;
        private Units units;
        private Language language;

        public OpenWeatherMapApiClient(string apiKey, string url = ApiConstants.BaseUrl, Units units = Units.Metric, Language language = Language.EN)
        {
            this.url = url;
            this.apiKey = apiKey;
            this.units = units;
            this.language = language;

            this.Initialize();
        }

        private void Initialize()
        {
            client = new HttpClient()
            {
                BaseAddress = new Uri(url)
            };
            if (!string.IsNullOrWhiteSpace(apiKey))
            {
                client.DefaultRequestHeaders.Add("x-api-key", apiKey);
            }
        }

        //Seaching by city name api.openweathermap.org/data/2.5/weather?q=London,uk

        public async Task<CurrentWeatherData> GetWeaterByCityNameAsync(string cityName, string countryName="")
        {
            string url = string.Format($"{ApiConstants.CurrentWeatherEndpoint}?q={cityName},{countryName}&units={units.ToString().ToLowerInvariant()}");
            url = this.AddLanguage(url);
            var result = client.GetAsync(url).Result;
            return await GetWeatherInfo(result);
        }

        public async Task<CurrentWeatherData> GetWeatherByLocationAsync(double longitude, double latitude)
        {
            //Seaching by geographic coordinats api.openweathermap.org/data/2.5/weather?lat=35&lon=139
            string url = string.Format($"{ApiConstants.CurrentWeatherEndpoint}?lat={latitude}&long={longitude}&units={units.ToString().ToLowerInvariant()}");
            url = this.AddLanguage(url);
            var result = client.GetAsync(url).Result;
            return await GetWeatherInfo(result);
        }

        public async Task<CurrentWeatherData> GetWeatherByCityIdAsync(int cityId)
        {
            //Seaching by city ID api.openweathermap.org/data/2.5/weather?id=2172797
            string url = string.Format($"{ApiConstants.CurrentWeatherEndpoint}?id={cityId}&units={units.ToString().ToLowerInvariant()}");
            url = this.AddLanguage(url);
            var result = client.GetAsync(url).Result;
            return await GetWeatherInfo(result);
        }

        public async Task<CurrentWeatherData> GetWeatherByZipcode(string zipCode, string countryCode)
        {
            string url = string.Format($"{ApiConstants.CurrentWeatherEndpoint}?zip={zipCode},{countryCode}&units={units.ToString().ToLowerInvariant()}");
            url = this.AddLanguage(url);
            var result = client.GetAsync(url).Result;
            return await GetWeatherInfo(result);
        }

        public async Task<ForecastWeatherData> GetForecastByCityAsync(string city, int? days = null)
        {
            string url = string.Format($"{ApiConstants.ForecastEndpoint}?q={city}&units={units.ToString().ToLowerInvariant()}");
            if (days.HasValue)
            {
                url = string.Format($"{url}&cnt={days.Value}");
            }
            url = this.AddLanguage(url);
            var result = client.GetAsync(url).Result;
            return await GetForecastInfo(result);
        }

        public async Task<ForecastWeatherData> GetForecastByCityIdAsync(int cityId, int? days = null)
        {
            string url = string.Format($"{ApiConstants.ForecastEndpoint}?id={cityId}&units={units.ToString().ToLowerInvariant()}");
            if (days.HasValue)
            {
                url = string.Format("${url}&cnt={days.Value}");
            }
            url = this.AddLanguage(url);
            var result = await client.GetAsync(url);
            return await GetForecastInfo(result);
        }

        public async Task<ForecastWeatherData> GetForecastByLocationAsync(double latitude, double longitude, int? days = null)
        {
            string url = string.Format($"{ApiConstants.ForecastEndpoint}?lat={latitude}&long={longitude}&units={units.ToString().ToLowerInvariant()}");
            if (days.HasValue)
            {
                url = string.Format("${url}&cnt={days.Value}");
            }
            url = this.AddLanguage(url);
            var result = await client.GetAsync(url);
            return await GetForecastInfo(result);
        }

        public async Task<ForecastWeatherData> GetForecastByZipcode(string zipCode, string countryCode)
        {
            string url = string.Format($"{ApiConstants.ForecastEndpoint}?zip={zipCode},{countryCode}&units={units.ToString().ToLowerInvariant()}");
            url = this.AddLanguage(url);
            var result = await client.GetAsync(url);
            return await GetForecastInfo(result);
        }

        private string AddLanguage(string url)
        {
            if (this.language != Language.EN)
            {
                return string.Format($"{url}&lang={language}");
            }
            else
            {
                return url;
            }
        }

        private static async Task<CurrentWeatherData> GetWeatherInfo(HttpResponseMessage result)
        {
            if (result.IsSuccessStatusCode)
            {
                var json = await result.Content.ReadAsStringAsync();
                JsonSerializerSettings settings = new JsonSerializerSettings()
                {
                    Culture = new System.Globalization.CultureInfo("en-us")
                };
                return JsonConvert.DeserializeObject<CurrentWeatherData>(json, settings);
            }
            else
            {
                return null;
            }
        }

        private async Task<ForecastWeatherData> GetForecastInfo(HttpResponseMessage result)
        {
            if (result.IsSuccessStatusCode)
            {
                var json = await result.Content.ReadAsStringAsync();
                JsonSerializerSettings settings = new JsonSerializerSettings()
                {
                    Culture = new System.Globalization.CultureInfo("en-us")
                };
                return JsonConvert.DeserializeObject<ForecastWeatherData>(json, settings);
            }
            else
            {
                return null;
            }
        }
    }
}
