using System.Collections.Generic;
using EPiServer;
using EPiServer.Approvals;
using EPiServer.Approvals.ContentApprovals;
using EPiServer.Core;
using EPiServer.Shell.Rest;
using EPiServer.Shell.Services.Rest;

namespace AlloyDemoKit.Business.ContentApprovalExtensions
{
    public class ContentApprovalQueryBase
    {
        private readonly IContentRepository _contentRepository;
        private readonly IApprovalRepository _approvalRepository;

        public ContentApprovalQueryBase(IContentRepository contentRepository, IApprovalRepository approvalRepository)
        {
            _contentRepository = contentRepository;
            _approvalRepository = approvalRepository;
        }

        public QueryRange<IContent> ExecuteQueryInternal(ApprovalQuery query)
        {
            var itemsToBeApproved = _approvalRepository.ListAsync(query);
            var contentItemsToBeApproved = new List<IContent>();
            var result = itemsToBeApproved.Result;
            foreach (ContentApproval approval in result)
            {
                contentItemsToBeApproved.Add(_contentRepository.Get<IContent>(approval.ContentLink));
            }
            var items = new QueryRange<IContent>(contentItemsToBeApproved, new ItemRange());
            return items;
        }

        public bool CanHandleQuery(IQueryParameters parameters) => true;

        public int Rank { get; set; }
        public bool VersionSpecific { get; set; }
    }
}