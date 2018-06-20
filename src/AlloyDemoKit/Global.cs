using EPiServer.DataAnnotations;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace AlloyDemoKit
{

    public class Global
    {
        public static readonly string LoginPath = "/util/login.aspx";
        public static readonly string AppRelativeLoginPath = string.Format("~{0}", LoginPath);

        /// <summary>
        /// Group names for content types and properties
        /// </summary>
        [GroupDefinitions()]
        public static class GroupNames
        {

            [Display(Name = "Default", Order = 11)]
            public const string Default = "Default";

            [Display(Name = "Contact", Order = 13)]
            public const string Contact = "Contact";

            [Display(Name = "News", Order = 13)]
            public const string News = "News";

            [Display(Name = "Products", Order = 13)]
            public const string Products = "Products";

            [Display(Name = "Specialized", Order = 13)]
            public const string Specialized = "Specialized";

            [Display(Name = "Location", Order = 13)]
            public const string Location = "Location";

            [Display(Name = "Metadata", Order = 14)]
            public const string MetaData = "Metadata";

            [Display(Name = "Review", Order = 15)]
            public const string Review = "Review";

            [Display(Name = "Styles", Order = 16)]
            public const string Styles = "Styles";

            [Display(Name = "Scripts", Order = 17)]
            public const string Scripts = "Scripts";

            [Display(Name = "SiteSettings", Order = 18)]
            public const string SiteSettings = "Sitesettings";
        }

        /// <summary>
        /// Tags to use for the main widths used in the Bootstrap HTML framework
        /// </summary>
        public static class ContentAreaTags
        {
            public const string FullWidth = "span12";
            public const string TwoThirdsWidth = "span8";
            public const string HalfWidth = "span6";
            public const string OneThirdWidth = "span4";
            public const string NoRenderer = "norenderer";
        }

        /// <summary>
        /// Main widths used in the Bootstrap HTML framework
        /// </summary>
        public static class ContentAreaWidths
        {
            public const int FullWidth = 12;
            public const int TwoThirdsWidth = 8;
            public const int HalfWidth = 6;
            public const int OneThirdWidth = 4;
        }

        public static Dictionary<string, int> ContentAreaTagWidths = new Dictionary<string, int>
            {
                { ContentAreaTags.FullWidth, ContentAreaWidths.FullWidth },
                { ContentAreaTags.TwoThirdsWidth, ContentAreaWidths.TwoThirdsWidth },
                { ContentAreaTags.HalfWidth, ContentAreaWidths.HalfWidth },
                { ContentAreaTags.OneThirdWidth, ContentAreaWidths.OneThirdWidth }
            };

        /// <summary>
        /// Names used for UIHint attributes to map specific rendering controls to page properties
        /// </summary>
        public static class SiteUIHints
        {
            public const string Contact = "contact";
            public const string Strings = "StringList";
            public const string StringsCollection = "StringsCollection";
            public const string Parking = "parking";
        }

        /// <summary>
        /// Virtual path to folder with static graphics, such as "~/Static/gfx/"
        /// </summary>
        public const string StaticGraphicsFolderPath = "~/Static/gfx/";
    }
}

