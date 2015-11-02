using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using EPiServer.Shell.ViewComposition;
using EPiServer.Core;
using EPiServer.Shell.WebForms;
using AlloyDemoKit.Models.Pages;

namespace EPiServer.Templates.Alloy.AddOns.Core
{
    [IFrameComponent(Url = "~/AddOns/Core/SearchAndReplace.aspx",
        ReloadOnContextChange = false,
        PlugInAreas = "Assets",
        Title = "Search and Replace",
        Categories = "cms,dashboard", SortOrder = 10)]
    public partial class SearchAndReplace1 : ContentWebFormsBase
    {          
        protected void Page_Load(object sender, EventArgs e)
        {
            BindResults();
        }

        public void SearchButton_Click(object sender, EventArgs e)
        {
            BindResults();
        }

        public string SiteUrl(object dataItem)
        {
            PageData page = (PageData)dataItem;

            string siteUrl = EPiServer.Web.SiteDefinition.Current.SiteUrl.ToString();
            string uiUrl = EPiServer.Configuration.Settings.Instance.UIUrl.ToString().Remove(0, 2);

            return string.Format("{0}{1}Home#context=epi.cms.contentdata:///{2}", siteUrl, uiUrl, page.ContentLink.ID);
        }

        private void BindResults()
        {
            string searchQuery = SearchQuery.Text;

            if (!string.IsNullOrEmpty(searchQuery))
            {
                List<PageData> results = FindPagesContainSearchQuery(searchQuery);
    
                /*ResultsRepeater.DataSource = results;
                ResultsRepeater.DataBind();*/

                PagedResults.DataSource = results;
                PagedResults.DataBind();

                ReplaceLabel.Text = string.Format("Replace \"{0}\" with", searchQuery); 
            }
        }

        public void ReplaceButton_Click(object sender, EventArgs e)
        {
            string searchQuery = SearchQuery.Text;
            string replaceText = ReplaceTextBox.Text;

            if (!string.IsNullOrEmpty(searchQuery) && !string.IsNullOrEmpty(replaceText))
            {
                List<PageData> results = FindPagesContainSearchQuery(searchQuery);

                foreach (PageData result in results)
                {
                    SitePageData writablePage = (SitePageData)result.CreateWritableClone();
                    XhtmlStringConverter converter = new XhtmlStringConverter();
                 
                    if (writablePage["MainBody"] != null) { 
                    string mainBody = writablePage["MainBody"].ToString();
                    mainBody = mainBody.Replace(searchQuery, replaceText);
                    writablePage["MainBody"] = (XhtmlString) converter.ConvertFromString(mainBody);
                }
                    string name = writablePage.Name;
                    name = name.Replace(searchQuery, replaceText);
                    writablePage.Name = name;

                    string descr = writablePage.MetaDescription;

                    if (descr != null) { 
                    descr = descr.Replace(searchQuery, replaceText);
                    writablePage.MetaDescription = descr;
                    }
                   
                    DataFactory.Instance.Save(writablePage, DataAccess.SaveAction.Publish, Security.AccessLevel.Create);
                }
            }
            ResultsLiteral.Text = string.Format("Replaced {0} with {1}", searchQuery, replaceText);
        }

        public void ResultsRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Literal checkBoxLiteral = (Literal) e.Item.FindControl("CheckBoxLiteral");
                PageData currentPage = (PageData) e.Item.DataItem;

                if(checkBoxLiteral != null && currentPage != null)
                {
                    checkBoxLiteral.Text = string.Format("<input type=\"checkbox\" runat=\"server\" id=\"CheckBox_{0}\" value=\"{0}\" name=\"CheckBox_{0}\" />",
                                                         currentPage.ContentLink.ID);
                }
            }
        }

        private List<PageData> FindPagesContainSearchQuery(string searchQuery)
        {
            PropertyCriteriaCollection propertyCriteriaCollection = new PropertyCriteriaCollection();

            PropertyCriteria propertyCriteria = new PropertyCriteria()
            {
                Name = "PageName",
                Type = PropertyDataType.String,
                Condition = Filters.CompareCondition.Contained,
                Required = true,
                Value = searchQuery
            };

            propertyCriteriaCollection.Add(propertyCriteria);

            List<PageData> results =
                DataFactory.Instance.FindPagesWithCriteria(PageReference.StartPage, propertyCriteriaCollection).ToList<PageData>();

            return results;
        }
    }
}