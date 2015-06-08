using EPiServer.Editor;
using EPiServer.Shell;
using AlloyDemoKit.Models.Pages;

namespace AlloyDemoKit.Business.UIDescriptors
{
    /// <summary>
    /// Describes how the UI should appear for <see cref="ContainerPage"/> content.
    /// </summary>
    [UIDescriptorRegistration]
    public class ArticlePageUIDescriptor : UIDescriptor<ArticlePage>
    {
        public ArticlePageUIDescriptor()
            : base("epi-icon__article")
        {
            
        }
    }
}
