using EPiServer.DataAnnotations;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace AlloyDemoKit
{

    public class Global
    {
        /// <summary>
        /// Group names for content types and properties
        /// </summary>
        [GroupDefinitions()]
        public static class GroupNames
        {
            [Display(Name = "Contact", Order = 1)]
            public const string Contact = "Contact";

            [Display(Name = "Default", Order = 2)]
            public const string Default = "Default";

            [Display(Name = "Metadata", Order = 3)]
            public const string MetaData = "Metadata";

            [Display(Name = "News", Order = 4)]
            public const string News = "News";

            [Display(Name = "Products", Order = 5)]
            public const string Products = "Products";

            [Display(Name = "SiteSettings", Order = 6)]
            public const string SiteSettings = "SiteSettings";

            [Display(Name = "Specialized", Order = 7)]
            public const string Specialized = "Specialized";

            [Display(Name = "Location", Order = 8)]
            public const string Location = "Location";

            [Display(Name = "Review", Order = 9)]
            public const string Review = "Review";

            [Display(Name = "Styles", Order = 10)]
            public const string Styles = "Styles";

            [Display(Name = "Scripts", Order = 11)]
            public const string Scripts = "Scripts";
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
        }

        /// <summary>
        /// Virtual path to folder with static graphics, such as "~/Static/gfx/"
        /// </summary>
        public const string StaticGraphicsFolderPath = "~/Static/gfx/";
    }
}

