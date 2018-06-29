using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.Shell.ViewComposition;
using EPiServer.Shell.WebForms;

namespace EPiServer.Templates.Alloy.AddOns.Core
{
    [IFrameComponent(Url = "~/AddOns/Core/TimeMachine.aspx",
        ReloadOnContextChange = false,
        PlugInAreas = "Assets",
        Title = "Time Machine", Description = "Revert back all content from a specific date",
        Categories = "cms,dashboard", SortOrder = 10)]
    public partial class TimeMachine : ContentWebFormsBase
    {

        protected override void OnLoad(EventArgs e)
        {
            SystemMessageContainer.Heading = "Time Machine";
            SystemMessageContainer.Description = "Revert back to previous version based on date for entire site";
            base.OnLoad(e);
        }

        public void SearchButton_Click(object sender, EventArgs e)
        {
            SearchContent();
            ReplaceButton.Enabled = true;
        }

        public string SiteUrl(object dataItem)
        {
            IContent page = (IContent)dataItem;

            string siteUrl = EPiServer.Web.SiteDefinition.Current.SiteUrl.ToString();
            string uiUrl = EPiServer.Configuration.Settings.Instance.UIUrl.ToString().Remove(0, 2);

            return string.Format("{0}{1}Home#context=epi.cms.contentdata:///{2}", siteUrl, uiUrl, page.ContentLink.ID);
        }

        public void BindResults(List<ContentVersion> Pages, List<ContentVersion> Blocks)
        {
            var contentRepository = EPiServer.ServiceLocation.ServiceLocator.Current.GetInstance<IContentRepository>();
            List<IContent> content = new List<IContent>();
            content.AddRange(Pages.ToList().Select(x => contentRepository.Get<IContent>(x.ContentLink)));
            content.AddRange(Blocks.ToList().Select(x => contentRepository.Get<IContent>(x.ContentLink)));
            PagedResults.DataSource = content;
            PagedResults.DataBind();
        }

        private void SearchContent()
        {
            if (InputDateBox.Value != null)
            {
                DateTime date = InputDateBox.Value;

                var contentRepository = EPiServer.ServiceLocation.ServiceLocator.Current.GetInstance<IContentRepository>();
                var versionRepository = EPiServer.ServiceLocation.ServiceLocator.Current.GetInstance<IContentVersionRepository>();

                List<ContentReference> listpages = new List<ContentReference>(contentRepository.GetDescendents(ContentReference.StartPage))
                {
                    ContentReference.StartPage
                };

                List<ContentVersion> Pages = new List<ContentVersion>();
                //find page version that we are going to revert
                FindVersionsToRevert(listpages, date, Pages);


                List<ContentReference> listblocks = new List<ContentReference>(contentRepository.GetDescendents(ContentReference.GlobalBlockFolder));
                 List<ContentVersion> Blocks = new List<ContentVersion>();
                FindVersionsToRevert(listblocks, date, Blocks);

                ResultsLiteral.Text = string.Format("{0} pages and {1} blocks found", Pages.Count, Blocks.Count);

                BindResults(Pages, Blocks);
            }
        }

        public void FindVersionsToRevert(List<ContentReference> listpages, DateTime date, List<ContentVersion> listToChange)
        {
            var versionRepository = EPiServer.ServiceLocation.ServiceLocator.Current.GetInstance<IContentVersionRepository>();

            //lets go through all the content
            foreach (var pageRefs in listpages)
            {
                //the one we will revert to
                ContentVersion contentVersion = versionRepository.LoadPublished(pageRefs);

                //lets go through all the versions
                foreach (var version in versionRepository.List(pageRefs))
                {
                    if (date > version.Saved)
                    {
                        contentVersion = version;
                    }
                    else
                    {
                        break;
                    }
                }

                //should we revert it
                if (contentVersion != null && contentVersion != versionRepository.LoadPublished(pageRefs))
                {
                    listToChange.Add(contentVersion);
                }
            }
        }

        public void ReplaceButton_Click(object sender, EventArgs e)
        {
            var contentRepository = EPiServer.ServiceLocation.ServiceLocator.Current.GetInstance<IContentRepository>();
            var versionRepository = EPiServer.ServiceLocation.ServiceLocator.Current.GetInstance<IContentVersionRepository>();

            DateTime date = InputDateBox.Value;

            List<ContentReference> listpages = new List<ContentReference>(contentRepository.GetDescendents(ContentReference.StartPage))
            {
                ContentReference.StartPage
            };

            List<ContentVersion> Pages = new List<ContentVersion>();
            //find page version that we are going to revert
            FindVersionsToRevert(listpages, date, Pages);


            List<ContentReference> listblocks = new List<ContentReference>(contentRepository.GetDescendents(ContentReference.GlobalBlockFolder));
            List<ContentVersion> Blocks = new List<ContentVersion>();
            FindVersionsToRevert(listblocks, date, Blocks);
            try
            {
                foreach (var pdRef in Pages)
                {
                    var pd = contentRepository.Get<PageData>(pdRef.ContentLink);
                    contentRepository.Save(pd.CreateWritableClone(), EPiServer.DataAccess.SaveAction.Publish);
                }

                foreach (var bdRef in Blocks)
                {
                    var bd = contentRepository.Get<BlockData>(bdRef.ContentLink);
                    contentRepository.Save((IContent)bd.CreateWritableClone(), EPiServer.DataAccess.SaveAction.Publish);
                }
            }
            catch { }

            ResultsLiteral.Text = string.Format("{0} pages and {1} blocks changed", Pages.Count, Blocks.Count);
        }


    }
}