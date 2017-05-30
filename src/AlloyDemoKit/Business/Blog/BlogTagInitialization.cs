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
using AlloyDemoKit.Models.Pages.Initialization;
using EPiServer.DataAbstraction;
using System.Web.Routing;
using EPiServer.Web.Routing;
using EPiServer;
using AlloyDemoKit.Business;

namespace AlloyDemoKit.Models.Pages.Tags
{
    [InitializableModule]
    [ModuleDependency(typeof(EPiServer.Web.InitializationModule))]
    public class BlogTagInitialization : IInitializableModule
    {
        public void Initialize(InitializationEngine context)
        {
            IContentEvents events = ServiceLocator.Current.GetInstance<IContentEvents>();

            events.CreatingContent += CreatingContent;

            var partialRouter = new BlogPartialRouter();

            RouteTable.Routes.RegisterPartialRouter<BlogStartPage, Category>(partialRouter);

        }

        /*
         * When a page gets created lets see if it is a blog post and if so lets create the date page information for it
         */
        private void CreatingContent(object sender, ContentEventArgs e)
        {
            if (this.IsImport() || e.Content == null || !(e.Content is PageData))
            {
                return;
            }

            var page = e.Content as PageData;

            if (string.Equals(page.PageTypeName, typeof(BlogItemPage).GetPageType().Name, StringComparison.OrdinalIgnoreCase))
            {
                DateTime blogDate = page.Created;

                var contentRepository = ServiceLocator.Current.GetInstance<IContentRepository>();

                PageData parentPage = contentRepository.Get<PageData>(page.ParentLink);

                if (parentPage is BlogStartPage)
                {
                    page.ParentLink = GetDatePageRef(parentPage, blogDate, contentRepository);
                }
            }
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

        // in here we know that the page is a blog start page and now we must create the date pages unless they are already created
        public PageReference GetDatePageRef(PageData blogStart, DateTime created, IContentRepository contentRepository)
        {

            foreach (var current in contentRepository.GetChildren<PageData>(blogStart.ContentLink))
            {
                if (current.Name == created.Year.ToString())
                {
                    PageReference result;
                    foreach (PageData current2 in contentRepository.GetChildren<PageData>(current.ContentLink))
                    {
                        if (current2.Name == created.Month.ToString())
                        {
                            result = current2.PageLink;
                            return result;
                        }
                    }
                    result = CreateDatePage(contentRepository, current.PageLink, created.Month.ToString(), new DateTime(created.Year, created.Month, 1));
                    return result;

                }
            }
            PageReference parent = CreateDatePage(contentRepository, blogStart.ContentLink, created.Year.ToString(), new DateTime(created.Year, 1, 1));
            return CreateDatePage(contentRepository, parent, created.Month.ToString(), new DateTime(created.Year, created.Month, 1));
        }

        private PageReference CreateDatePage(IContentRepository contentRepository, ContentReference parent, string name, DateTime created)
        {
            BlogListPage defaultPageData = contentRepository.GetDefault<BlogListPage>(parent, typeof(BlogListPage).GetPageType().ID);
            defaultPageData.PageName = name;
            defaultPageData.Heading = name;
            defaultPageData.StartPublish = created;
            IUrlSegmentCreator urlSegment = ServiceLocator.Current.GetInstance<IUrlSegmentCreator>();
            defaultPageData.URLSegment = urlSegment.Create(defaultPageData);
            return contentRepository.Save(defaultPageData, SaveAction.Publish, AccessLevel.Publish).ToPageReference();
        }

        public void Preload(string[] parameters) { }

        public void Uninitialize(InitializationEngine context)
        {
            IContentEvents events = ServiceLocator.Current.GetInstance<IContentEvents>();

            events.CreatingContent -= CreatingContent;

        }
    }
}
