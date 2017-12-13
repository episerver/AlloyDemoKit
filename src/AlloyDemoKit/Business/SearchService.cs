using System.Collections.Generic;
using System.Web;
using EPiServer.Core;
using EPiServer.Search;
using EPiServer.Search.Queries;
using EPiServer.Search.Queries.Lucene;
using EPiServer.Security;
using EPiServer;

namespace AlloyDemoKit.Business
{
    public class SearchService
    {
        private readonly SearchHandler _searchHandler;
        private readonly IContentLoader _contentLoader;

        public SearchService(SearchHandler searchHandler, IContentLoader contentLoader)
        {
            _searchHandler = searchHandler;
            _contentLoader = contentLoader;
        }

        public virtual bool IsActive
        {
            get { return ServiceLocator.Current.GetInstance<SearchOptions>().Active; }
        }

        public virtual SearchResults Search(string searchText, IEnumerable<ContentReference> searchRoots, HttpContextBase context, string languageBranch, int maxResults)
        {
            var query = CreateQuery(searchText, searchRoots, context, languageBranch);
            return _searchHandler.GetSearchResults(query, 1, maxResults);
        }

        private IQueryExpression CreateQuery(string searchText, IEnumerable<ContentReference> searchRoots, HttpContextBase context, string languageBranch)
        {
            //Main query which groups other queries. Each query added
            //must match in order for a page or file to be returned.
            var query = new GroupQuery(LuceneOperator.AND);

            //Add free text query to the main query
            query.QueryExpressions.Add(new FieldQuery(searchText));

            //Search for pages using the provided language
            var pageTypeQuery = new GroupQuery(LuceneOperator.AND);
            pageTypeQuery.QueryExpressions.Add(new ContentQuery<PageData>());
            pageTypeQuery.QueryExpressions.Add(new FieldQuery(languageBranch, Field.Culture));

            //Search for media without languages
            var contentTypeQuery = new GroupQuery(LuceneOperator.OR);
            contentTypeQuery.QueryExpressions.Add(new ContentQuery<MediaData>());
            contentTypeQuery.QueryExpressions.Add(pageTypeQuery);

            query.QueryExpressions.Add(contentTypeQuery);

            //Create and add query which groups type conditions using OR
            var typeQueries = new GroupQuery(LuceneOperator.OR);
            query.QueryExpressions.Add(typeQueries);

            foreach (var root in searchRoots)
            {
                var contentRootQuery = new VirtualPathQuery();
                contentRootQuery.AddContentNodes(root);
                typeQueries.QueryExpressions.Add(contentRootQuery);
            }

            var accessRightsQuery = new AccessControlListQuery();
            accessRightsQuery.AddAclForUser(PrincipalInfo.Current, context);
            query.QueryExpressions.Add(accessRightsQuery);

            return query;
        }
    }
}
