using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WeatherService.Models
{
    public class Temperature
    {
        public double Celsius
        {
            get; private set;
        }
        public double Fahrenheit
        {
            get; private set;

        }

        public Temperature()
        {

        }

        public Temperature(double C, double F)
        {
            Celsius = C;
            Fahrenheit = F;
        }

        public void AddCelsius(double c)
        {
            Celsius = c;
            Fahrenheit = ConvertToFahrenheit(c);
        }

        public void AddFahrenheit(double f)
        {
            Fahrenheit = f;
            Celsius = ConvertToCelsius(f);
        }


        public static double ConvertToFahrenheit(double celsius)
        {
            double f = celsius*9/5+32;
            return f;
        }

        public static double ConvertToCelsius(double farenheight)
        {
            double c = (farenheight - 32) * 5 / 9;
            return c;
        }
    }
}
