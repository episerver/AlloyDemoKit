using EPiServer.Core;

namespace AlloyDemoKit.Models.Pages
{
    public interface IHasRelatedContent
    {
        ContentArea RelatedContentArea { get; }
    }
}
