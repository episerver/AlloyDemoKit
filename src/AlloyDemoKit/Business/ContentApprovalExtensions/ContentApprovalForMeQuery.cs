using System.Collections.Generic;
using System.Web;
using EPiServer;
using EPiServer.Approvals;
using EPiServer.Approvals.ContentApprovals;
using EPiServer.Core;
using EPiServer.ServiceLocation;
using EPiServer.Shell.ContentQuery;
using EPiServer.Shell.Rest;

namespace AlloyDemoKit.Business.ContentApprovalExtensions
{
    [ServiceConfiguration(typeof(IContentQuery))]
    public class ContentApprovalForMeQuery : ContentApprovalQueryBase, IContentQuery
    {
        public ContentApprovalForMeQuery(IContentRepository contentRepository,
            IApprovalRepository approvalRepository)
            : base(contentRepository, approvalRepository)
        {
        }

        public QueryRange<IContent> ExecuteQuery(IQueryParameters parameters)
        {
            var query = new ContentApprovalQuery
            {
                OnlyActiveSteps = true,
                Username = HttpContext.Current.User.Identity.Name
            };
            return this.ExecuteQueryInternal(query);
        }

        public string DisplayName => "Awaiting my approval";

        public string Name => "awaitingmapproval";

        public IEnumerable<string> PlugInAreas => new[] { "editortasks" };

        public int SortOrder => 1;
    }
}