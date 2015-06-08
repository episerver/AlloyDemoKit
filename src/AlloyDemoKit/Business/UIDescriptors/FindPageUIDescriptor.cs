using EPiServer.Editor;
using EPiServer.Shell;
using AlloyDemoKit.Models.Pages;

namespace AlloyDemoKit.Business.UIDescriptors
{
    /// <summary>
    /// Describes how the UI should appear for <see cref="ContainerPage"/> content.
    /// </summary>
    [UIDescriptorRegistration]
    public class FindPageUIDescriptor : UIDescriptor<FindPage>
    {
        public FindPageUIDescriptor()
            : base("epi-icon__search")
        {
            
        }
    }
}
