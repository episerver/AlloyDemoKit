using EPiServer.Shell;
using AlloyDemoKit.Models.Blocks;

namespace AlloyDemoKit.Business.UIDescriptors
{
    /// <summary>
    /// Describes how the UI should appear for <see cref="WeatherBlock"/> content.
    /// </summary>
    [UIDescriptorRegistration]
    public class WeatherBlockUIDescriptor : UIDescriptor<WeatherBlock>
    {
        public WeatherBlockUIDescriptor()
            : base(ContentTypeCssClassNames.SharedBlock)
        {
            DefaultView = CmsViewNames.AllPropertiesView;
        }
    }
}
