using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WeatherService
{
    /// <summary>
    /// Enum Unit formats
    /// </summary>
    public enum Units
    {
        /// <summary>
        /// Kelvin
        /// </summary>
        Standard = 0,
        /// <summary>
        /// Celcius
        /// </summary>
        Metric = 1,
        /// <summary>
        /// Farenheit
        /// </summary>
        Imperial = 2
    }

    /// <summary>
    /// Enum WeatherCondition Codes
    /// </summary>
    public enum ConditionCode
    {
        /// <summary>
        /// THUNDERSTORM
        /// </summary>
        ThunderstormWithLightRain = 200,
        ThunderstormWithRain            = 201,
        ThunderstormWithHeavyRain       = 202,
        LightThunderstorm               = 210,
        Thunderstorm                    = 211,
        HeavyThunderstorm               = 212,
        RaggedThunderstorm              = 221,
        ThunderstormWithLightDrizzle    = 230,
        ThunderstormWithDrizzle         = 231,
        ThunderstormWithHeavyDrizzle    = 232,

        /// <summary>
        /// DRIZZLE
        /// </summary>
        LightIntensityDrizzle = 300,
        Drizzle                         = 301,
        HeavyIntensityDrizzle           = 302,
        LightIntensityDrizzleRain       = 310,
        DrizzleRain                     = 311,
        HeavyIntensityDrizzleRain       = 312,
        ShowerRainAndDrizzle            = 313,
        HeavyShowerRainAndDrizzle       = 314,
        ShowerDrizzle                   = 321,

        /// <summary>
        /// RAIN
        /// </summary>
        LightRain                       = 500,
        ModerateRain                    = 501,
        HeavyIntensityRain              = 502,
        VeryHeavyRain                   = 503,
        ExtremeRain                     = 504,
        FreezingRain                    = 511,
        LightIntensityShowerRain        = 520,
        ShowerRain                      = 521,
        HeavyIntensityShowerRain        = 522,
        RaggedShowerRain                = 531,

        /// <summary>
        /// SNOW
        /// </summary>
        LightSnow                       = 600,
        Snow                            = 601,
        HeavySnow                       = 602,
        Sleet                           = 611,
        ShowerSleet                     = 612,
        LightRainAndSnow                = 615,
        RainAndSnow                     = 616,
        LightShowerSnow                 = 620,
        ShowerSnow                      = 621,
        HeavyShowerSnow                 = 622,

        /// <summary>
        /// ATMOSPHERE
        /// </summary>
        Mist                            = 701,
        Smoke                           = 711,
        Haze                            = 721,
        SandDustWhirls                  = 731,
        Fog                             = 741,
        Sand                            = 751,
        Dust                            = 761,
        VolcanicAsh                     = 762,
        Squalls                         = 771,
        Tornado                         = 781,

        /// <summary>
        /// CLOUDS
        /// </summary>
        ClearSky                        = 800,
        FewClouds                       = 801,
        ScatteredClouds                 = 802,
        BrokenClouds                    = 803,
        OvercastClouds                  = 804,

        /// <summary>
        /// EXTREME
        /// </summary>
        Tornado_Extreme                 = 900,
        TropicalStorm                   = 901,
        Hurricane                       = 902,
        Cold                            = 903,
        Hot                             = 904,
        Windy                           = 905,
        Hail                            = 906,

        /// <summary>
        /// ADDITIONAL
        /// </summary>
        Calm                            = 951,
        LightBreeze                     = 952,
        GentleBreeze                    = 953,
        ModerateBreeze                  = 954,
        FreshBreeze                     = 955,
        StrongBreeze                    = 956,
        HighWindNearGale                = 957,
        Gale                            = 958,
        SevereGale                      = 959,
        Storm                           = 960,
        ViolentStorm                    = 961,
        Hurricane_Additional            = 962
    }

    /// <summary>
    /// Enum OpenWeatherMap Language
    /// </summary>
    public enum Language
    {
        /// <summary>
        /// English
        /// </summary>
        EN,

        /// <summary>
        /// Russian
        /// </summary>
        RU,

        /// <summary>
        /// Italian
        /// </summary>
        IT,

        /// <summary>
        /// Spanish
        /// </summary>
        SP,

        /// <summary>
        /// Ukrainian
        /// </summary>
        UA,

        /// <summary>
        /// German
        /// </summary>
        DE,

        /// <summary>
        /// Portuguese
        /// </summary>
        PT,

        /// <summary>
        /// Romanian
        /// </summary>
        RO,

        /// <summary>
        /// Polish
        /// </summary>
        PL,

        /// <summary>
        /// Finnish
        /// </summary>
        FI,

        /// <summary>
        /// Dutch
        /// </summary>
        NL,

        /// <summary>
        /// French
        /// </summary>
        FR,

        /// <summary>
        /// Bulgarian
        /// </summary>
        BG,

        /// <summary>
        /// Swedish
        /// </summary>
        SE,

        /// <summary>
        /// Chinese Traditional
        /// </summary>
        ZH_TW,

        /// <summary>
        /// Chinese Simplified
        /// </summary>
        ZH_CN,

        /// <summary>
        /// Turkish
        /// </summary>
        TR,

        /// <summary>
        /// Croatian
        /// </summary>
        HR,

        /// <summary>
        /// Catalan
        /// </summary>
        CA
    }

    /// <summary>
    /// Enum Accuracy level
    /// </summary>
    public enum Accuracy
    {
        /// <summary>
        ///     like
        /// </summary>
        Like,

        /// <summary>
        ///     accurate
        /// </summary>
        Accurate
    }
}
