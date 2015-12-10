using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using WeatherService.GlobalWeather;
using WeatherService.Models;

namespace WeatherService
{
    public class Client
    {
        public WeatherData GetWeather(string city, string country)
        {
            GlobalWeatherSoapClient soapClient = new GlobalWeatherSoapClient();
            string result = soapClient.GetWeather(city, country);

            XmlSerializer serializer = new XmlSerializer(typeof(CurrentWeather));
            MemoryStream reader = new MemoryStream(Encoding.Unicode.GetBytes(result));

            CurrentWeather weatherResult = (CurrentWeather)serializer.Deserialize(reader);

            var data = new WeatherData()
            {
                LocationName = weatherResult.Location,
                Conditions = weatherResult.SkyConditions
            };
            
            string timeStamp = weatherResult.Time.Substring(weatherResult.Time.IndexOf("/") + 1)
                                                 .Replace('.', '-')
                                                 .Replace("UTC", "")
                                                 .TrimEnd();
            string formattedTime = timeStamp.Substring(0, timeStamp.Length - 2) + ":" + timeStamp.Substring(timeStamp.Length - 2);
            data.CurrentTime = Convert.ToDateTime(formattedTime);

            int length = weatherResult.Temperature.Length;
            string celsius = weatherResult.Temperature.Substring(weatherResult.Temperature.IndexOf("(") + 1, length - (weatherResult.Temperature.IndexOf(")") - 1));
            data.Temp.AddCelsius(Convert.ToDouble(celsius));

            return data;
        }
    }
}
