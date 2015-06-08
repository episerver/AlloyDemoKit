using EPiServer.Editor;
using EPiServer.Shell;
using AlloyDemoKit.Models.Pages;
using AlloyDemoKit.Models.Pages.Models.Pages;

namespace AlloyDemoKit.Business.UIDescriptors
{
    /// <summary>
    /// Describes how the UI should appear for <see cref="ContainerPage"/> content.
    /// </summary>
    [UIDescriptorRegistration]
    public class BlogPageUIDescriptor : UIDescriptor<BlogItemPage>
    {
        public BlogPageUIDescriptor()
            : base("epi-icon__blog")
        {
            
        }
    }
}
