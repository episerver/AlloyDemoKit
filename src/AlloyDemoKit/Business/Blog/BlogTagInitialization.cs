using System;
using System.Linq;
using EPiServer.Framework;
using EPiServer.Framework.Initialization;
using EPiServer.BaseLibrary;
using AlloyDemoKit.Models.Pages.Models.Pages;
using EPiServer.Core;
using EPiServer.ServiceLocation;
using EPiServer.Web;
using EPiServer.DataAccess;
using EPiServer.Security;
using AlloyDemoKit.Models.Pages.Business.Initialization;
using EPiServer.DataAbstraction;
using System.Web.Routing;
using EPiServer.Web.Routing;
using EPiServer;
using AlloyDemoKit.Business;

namespace AlloyDemoKit.Models.Pages.Business.Tags
{
    [InitializableModule]
    [ModuleDependency(typeof(EPiServer.Web.InitializationModule))]
    public class BlogTagInitialization : IInitializableModule
    {
        public void Initialize(InitializationEngine context)
        {
            DataFactory.Instance.CreatingPage +=Instance_CreatingPage;

            var partialRouter = new BlogPartialRouter();

            RouteTable.Routes.RegisterPartialRouter<BlogStartPage, Category>(partialRouter);

        }

        void Instance_PublishingPage(object sender, PageEventArgs e)
        {
            
        }

        void Instance_CreatedPage(object sender, PageEventArgs e)
        {
           
        }

        //Returns if we are doing an import or mirroring
        public bool IsImport()
        {
            return false;
            // TODO implementation return Context.Current["CurrentITransferContext"] != null;
        }

        /*
         * When a page gets created lets see if it is a blog post and if so lets create the date page information for it
         */
        void Instance_CreatingPage(object sender, PageEventArgs e)
        {
            if (this.IsImport() || e.Page == null)
            {
                return;
            }
            if (string.Equals(e.Page.PageTypeName, typeof(BlogItemPage).GetPageType().Name, StringComparison.OrdinalIgnoreCase))
            {
                DateTime startPublish = e.Page.StartPublish;
               
                var contentRepository = ServiceLocator.Current.GetInstance<IContentRepository>();

                PageData page = contentRepository.Get<PageData>(e.Page.ParentLink);

                if (page is BlogStartPage)
                {
                    e.Page.ParentLink = GetDatePageRef(page, startPublish, contentRepository);
                }
            }
        }

        // in here we know that the page is a blog start page and now we must create the date pages unless they are already created
        public PageReference GetDatePageRef(PageData blogStart, DateTime published, IContentRepository contentRepository)
        {

            foreach (var current in contentRepository.GetChildren<PageData>(blogStart.ContentLink))
            {
                if (current.Name == published.Year.ToString())
                {
                    PageReference result;
                foreach (PageData current2 in contentRepository.GetChildren<PageData>(current.ContentLink))
                {
                    if (current2.Name == published.Month.ToString())
                    {
                        result = current2.PageLink;
                        return result;
                    }
                }
                result = CreateDatePage(contentRepository, current.PageLink, published.Month.ToString(), new DateTime(published.Year, published.Month, 1));
                return result;
            
                }
            }
            PageReference parent = CreateDatePage(contentRepository, blogStart.ContentLink, published.Year.ToString(), new DateTime(published.Year, 1, 1));
            return CreateDatePage(contentRepository, parent, published.Month.ToString(), new DateTime(published.Year, published.Month, 1));     
        }

        private PageReference CreateDatePage(IContentRepository contentRepository, ContentReference parent, string name, DateTime startPublish)
        {
            BlogListPage defaultPageData = contentRepository.GetDefault<BlogListPage>(parent, typeof(BlogListPage).GetPageType().ID);
            defaultPageData.PageName = name;
            defaultPageData.Heading = name;
            defaultPageData.StartPublish = startPublish;
            defaultPageData.URLSegment = UrlSegment.CreateUrlSegment(defaultPageData);
            return contentRepository.Save(defaultPageData, SaveAction.Publish, AccessLevel.Publish).ToPageReference();
        }

        public void Preload(string[] parameters) { }

        public void Uninitialize(InitializationEngine context)
        {
            DataFactory.Instance.CreatingPage -= Instance_CreatingPage;
    
        }
    }
}