using System;
using System.Linq;
using System.Web.Routing;
using AlloyDemoKit.Models.Pages.Initialization;
using AlloyDemoKit.Models.Pages.Models.Pages;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAccess;
using EPiServer.Framework;
using EPiServer.Framework.Initialization;
using EPiServer.Web.Routing;

namespace AlloyDemoKit.Models.Pages.Tags
{
    [InitializableModule]
    [ModuleDependency(typeof(EPiServer.Web.InitializationModule))]
    public class BlogTagInitialization : IInitializableModule
    {
        private IContentRepository contentRepository { get; set; }
        private IContentEvents events { get; set; }

        public void Initialize(InitializationEngine context)
        {
            contentRepository = context.Locate.Advanced.GetInstance<IContentRepository>();

            events = context.Locate.Advanced.GetInstance<IContentEvents>();
            events.CreatingContent += CreatingContent;

            var partialRouter = new BlogPartialRouter();

            RouteTable.Routes.RegisterPartialRouter<BlogStartPage, Category>(partialRouter);
        }

        // When a page gets created lets see if it is a blog post and if so lets create the date page information for it
        private void CreatingContent(object sender, ContentEventArgs e)
        {
            if (e.Content == null || !(e.Content is PageData))
            {
                return;
            }

            var page = e.Content as PageData;
            if (page is BlogItemPage)
            {
                DateTime blogDate = page.Created;
                PageData parentPage = contentRepository.Get<PageData>(page.ParentLink);

                var blogroot = parentPage.ContentLink.ToReferenceWithoutVersion();

                if (parentPage is BlogStartPage)
                {
                    // Handle Year
                    var yearpage = contentRepository.GetChildren<BlogListPage>(blogroot).Where(lp => lp.Name == DateTime.Now.Year.ToString()).Select(lp => lp.ContentLink).FirstOrDefault();

                    if (yearpage == null)
                    {
                        var p = contentRepository.GetDefault<BlogListPage>(blogroot);
                        p.Name = DateTime.Now.Year.ToString();
                        yearpage = contentRepository.Save(p, SaveAction.Publish);
                    }

                    //Handle Month
                    var monthpage = contentRepository.GetChildren<BlogListPage>(yearpage).Where(lp => lp.Name == DateTime.Now.Month.ToString()).Select(lp => lp.ContentLink).FirstOrDefault();

                    if (monthpage == null)
                    {
                        var p = contentRepository.GetDefault<BlogListPage>(yearpage);
                        p.Name = DateTime.Now.Month.ToString();
                        monthpage = contentRepository.Save(p, SaveAction.Publish);
                    }
                    page.ParentLink = (PageReference)monthpage;
                }
            }
        }

        void Instance_PublishingPage(object sender, PageEventArgs e)
        {

        }

        void Instance_CreatedPage(object sender, PageEventArgs e)
        {

        }

        public void Preload(string[] parameters) { }

        public void Uninitialize(InitializationEngine context)
        {
            events.CreatingContent -= CreatingContent;
        }
    }
}
