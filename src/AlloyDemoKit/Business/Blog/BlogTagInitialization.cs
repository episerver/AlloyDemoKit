using AlloyDemoKit.Helpers;
using AlloyDemoKit.Models.Pages.Blog;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAccess;
using EPiServer.Framework;
using EPiServer.Framework.Initialization;
using EPiServer.Logging;
using EPiServer.MarketingAutomationIntegration.Core;
using EPiServer.MarketingAutomationIntegration.Helpers;
using EPiServer.MarketingAutomationIntegration.Marketo.Implementation;
using EPiServer.MarketingAutomationIntegration.Marketo.Services.REST;
using EPiServer.MarketingAutomationIntegration.Marketo.Services.REST.Responses;
using EPiServer.MarketingAutomationIntegration.Marketo.Services.REST.Responses.Results;
using EPiServer.Security;
using EPiServer.ServiceLocation;
using EPiServer.Web;
using EPiServer.Web.Mvc;
using EPiServer.Web.Routing;
using System;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Script.Serialization;
using EPiServer.Framework.Web;
using EPiServer.Globalization;
using AlloyDemoKit.Models.Pages.Controllers;
using EPiServer.Notification;

namespace AlloyDemoKit.Business.Blog
{
    [InitializableModule]
    [ModuleDependency(typeof(EPiServer.Web.InitializationModule),
         typeof(EPiServer.MarketingAutomationIntegration.InitializationModule))]
    public class BlogTagInitialization : IInitializableModule
    {
        private RESTService _restService;
        private MarketoSettings _marketoSettings;
        private readonly JavaScriptSerializer _serializer = new JavaScriptSerializer();
        private IContentRenderer _contentRenderer;
        private ITemplateResolver _templateResolver;
        private IContentRepository _contentRepository;
        private INotifier _notifier;

        public void Initialize(InitializationEngine context)
        {
            
            var partialRouter = new BlogPartialRouter();
            RouteTable.Routes.RegisterPartialRouter(partialRouter);

            var provider = new MarketoProvider();
            var workingContext = new WorkingContext(provider);
            _marketoSettings = workingContext.ActiveProvider.Settings as MarketoSettings;
            _restService = new RESTService(workingContext);
            _contentRenderer =  ServiceLocator.Current.GetInstance<IContentRenderer>();
            _templateResolver = ServiceLocator.Current.GetInstance<ITemplateResolver>();
            _contentRepository = ServiceLocator.Current.GetInstance<IContentRepository>();
            _notifier = ServiceLocator.Current.GetInstance<INotifier>();

            var events = ServiceLocator.Current.GetInstance<IContentEvents>();
            events.CreatingContent += CreatingContent;
            events.PublishedContent += Events_PublishedContent;
        }

        private void Events_PublishedContent(object sender,
            ContentEventArgs e)
        {
            var blog = e.Content as BlogItemPage;
            if (blog == null)
            {
                return;
            }
            SendToMarketo(blog);
            UpdateLanguageBranches(blog);
        }

        private void NotifyEditors()
        {
            //_notifier.PostNotificationAsync(new NotificationMessage
            //{
            //    ChannelName = "blogsubscribed",
            //    Content = "A page has been improved!",
            //    Subject = "Improvement",
            //    Recipients = new[] { new NotificationUser(),  },
            //    Sender sender,
            //    TypeName = "PageChanged"
            //})
        }

        private void UpdateLanguageBranches(BlogItemPage blog)
        {
            foreach (var culture in new [] {"sv", "de"})
            {
                BlogItemPage langContent;
                if (!_contentRepository.TryGet(blog.ContentLink, CultureInfo.GetCultureInfo(culture), out langContent))
                {
                    langContent = _contentRepository.CreateLanguageBranch<BlogItemPage>(blog.ContentLink, CultureInfo.GetCultureInfo(culture));
                }
                langContent.MainBody = blog.MainBody;
                langContent.Name = blog.Name;
                langContent.TeaserText = blog.TeaserText;
                langContent.MetaDescription = blog.MetaDescription;
                langContent.MetaKeywords = blog.MetaKeywords;
                langContent.MetaTitle = blog.MetaTitle;
                _contentRepository.Save(langContent, SaveAction.Default, AccessLevel.NoAccess);
            }
        }
        private void SendToMarketo(BlogItemPage blog)
        {
            var url = SiteDefinition.Current.SiteUrl.ToString();

            var html = GetHtml(blog);
            html = html.Replace("src=\"/", string.Format("src=\"{0}", url));
            html = html.Replace("href=\"/", string.Format("href=\"{0}", url));
            try
            {
                var template = _restService.GetEmailTemplateByName("blogsubscribe").
                    FirstOrDefault();
                _restService.UpdateEmailTemplateContentById(template.Id, html);
                ApproveEmailTemplate(template.Id);
                var emailId = GetEmail("Blog Subscribe");
                if (emailId == 0)
                {
                    return;
                }
                ApproveEmail(emailId);
                var nextPage = "";
                var campaign = _restService.GetMultipleCampaigns(ref nextPage).
                    FirstOrDefault(x => x.Name.Equals("Blog Published"));
                if (campaign == null)
                {
                    return;
                }
                _restService.ScheduleCampaign(campaign.Id, null);
            }
            catch (Exception exception)
            {
                LogManager.GetLogger().
                    Error(exception.Message, exception);
            }
        }

        private string GetHtml(BlogItemPage blogItemPage)
        {
            var model = _templateResolver.Resolve(HttpContext.Current, 
                blogItemPage.GetOriginalType(), 
                TemplateTypeCategories.MvcPartial | TemplateTypeCategories.Mvc,
                new[] {"email"});

            var contentController = ServiceLocator.Current.GetInstance<BlogItemController>() as ControllerBase;
            var routeData = new RouteData();
            routeData.Values.Add("currentContent", blogItemPage);
            routeData.Values.Add("controllerType", typeof(BlogItemController));
            routeData.Values.Add("language", ContentLanguage.PreferredCulture.Name);
            routeData.Values.Add("controller", "BlogItem");
            routeData.Values.Add("action", "Email");
            routeData.Values.Add("node", blogItemPage.ContentLink.ID);

            var viewContext = new ViewContext(
                new ControllerContext(new HttpContextWrapper(HttpContext.Current), routeData, contentController),
                new FakeView(),
                new ViewDataDictionary(),
                new TempDataDictionary(),
                new StringWriter());

            var helper = new HtmlHelper(viewContext, new ViewPage());

            _contentRenderer.Render(helper, new PartialRequest(), blogItemPage, model);

            return viewContext.Writer.ToString();
        }

        private void ApproveEmailTemplate(int id)
        {
            using (var client = new HttpClient
                {
                    BaseAddress = new Uri(_marketoSettings.RESTEndpointUrl),
                    DefaultRequestHeaders = { Authorization = new AuthenticationHeaderValue("Bearer",_restService.GetOAuthToken(false)) }
                })
            {
                var result = _serializer.Deserialize<RESTAPIResponse<EmailTemplateResult>>(client.PostAsync(string.Format("rest/asset/v1/emailTemplate/{0}/approveDraft.json", id),
                    new StringContent(""))
                    .GetAwaiter()
                    .GetResult()
                    .Content
                    .ReadAsStringAsync()
                    .GetAwaiter()
                    .GetResult());
            }

        }

        private void ApproveEmail(int id)
        {
            using (var client = new HttpClient
            {
                BaseAddress = new Uri(_marketoSettings.RESTEndpointUrl),
                DefaultRequestHeaders = { Authorization = new AuthenticationHeaderValue("Bearer", _restService.GetOAuthToken(false)) }
            })
            {
                var result = client.PostAsync(string.Format("rest/asset/v1/email/{0}/approveDraft.json", id),
                    new StringContent("")).GetAwaiter().GetResult();
            }

        }

        private int GetEmail(string name)
        {
            using (var client = new HttpClient
            {
                BaseAddress = new Uri(_marketoSettings.RESTEndpointUrl),
                DefaultRequestHeaders = { Authorization = new AuthenticationHeaderValue("Bearer", _restService.GetOAuthToken(false)) }
            })
            {
                var json = client.GetAsync(string.Format("/rest/asset/v1/email/byName.json?name={0}", name))
                    .GetAwaiter()
                    .GetResult()
                    .Content
                    .ReadAsStringAsync()
                    .GetAwaiter()
                    .GetResult();
                var result = _serializer.Deserialize<RESTAPIResponse<EmailResult>>(json);
                var email = result.Result.FirstOrDefault();
                return email != null ? email.Id : 0;
            }
        }

        
        private void CreatingContent(object sender, ContentEventArgs e)
        {
            if (this.IsImport() || e.Content == null || !(e.Content is PageData))
            {
                return;
            }

            var page = e.Content as PageData;

            if (string.Equals(page.PageTypeName, typeof(BlogItemPage).GetPageType().Name, StringComparison.OrdinalIgnoreCase))
            {
                if (!page.StartPublish.HasValue)
                {
                    return;
                }
                DateTime startPublish = page.StartPublish.Value;

                var contentRepository = ServiceLocator.Current.GetInstance<IContentRepository>();

                PageData parentPage = contentRepository.Get<PageData>(page.ParentLink);

                if (parentPage is BlogUserStartPage)
                {
                    page.ParentLink = GetDatePageRef(parentPage, startPublish, contentRepository);
                }
            }
        }

        //Returns if we are doing an import or mirroring
        public bool IsImport()
        {
            return false;
            // TODO implementation return Context.Current["CurrentITransferContext"] != null;
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
            IUrlSegmentCreator urlSegment = ServiceLocator.Current.GetInstance<IUrlSegmentCreator>();
            defaultPageData.URLSegment = urlSegment.Create(defaultPageData);
            return contentRepository.Save(defaultPageData, SaveAction.Publish, AccessLevel.Publish).ToPageReference();
        }

        public void Preload(string[] parameters) { }

        public void Uninitialize(InitializationEngine context)
        {
            IContentEvents events = ServiceLocator.Current.GetInstance<IContentEvents>();

            events.CreatingContent -= CreatingContent;
            events.PublishingContent -= Events_PublishedContent;
        }

        private class EmailResult
        {
            public int Id { get; set; }
        }

        private class FakeView : IView
        {
            public void Render(ViewContext viewContext, TextWriter writer)
            {
            }
        }
    }
}
