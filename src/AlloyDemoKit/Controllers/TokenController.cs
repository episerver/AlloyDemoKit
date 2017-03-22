using AlloyDemoKit.Helpers;
using AlloyDemoKit.Models.Pages;
using EPiServer;
using EPiServer.Core;
using EPiServer.Web;
using System;
using System.Linq;
using System.Web.Http;

namespace AlloyDemoKit.Controllers
{
    [RoutePrefix("token")]
    public class TokenController : ApiController
    {
        private readonly IContentLoader _contentLoader;

        public TokenController(IContentLoader contentLoader)
        {
            _contentLoader = contentLoader;
        }

        [Route("get/{tokenId}", Name = "GetContent")]
        [HttpGet]
        [AcceptVerbs("GET")]
        public string Get(string tokenId)
        {
            var start = _contentLoader.Get<StartPage>(SiteDefinition.Current.StartPage);
            if (start == null || ContentReference.IsNullOrEmpty(start.SnippetReference))
            {
                return null;
            }

            var model = _contentLoader.GetChildren<IContent>(start.SnippetReference).
                Select(x => x.GetSnippet()).
                FirstOrDefault(x => !string.IsNullOrEmpty(x.TokenId) && 
                    x.TokenId.Equals(tokenId, StringComparison.InvariantCultureIgnoreCase));

            return model == null ? null : model.RawHtml;
        }
        
    }
}