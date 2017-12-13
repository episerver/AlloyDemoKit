using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using AlloyDemoKit.Business.Rendering;
using EPiServer.Web;
using EPiServer.Shell.ObjectEditing;
using System.Collections.Generic;
using EPiServer;
using EPiServer.ServiceLocation;
using EPiServer.SpecializedProperties;
using AlloyDemoKit.Business.EditorDescriptors;

namespace AlloyDemoKit.Models.Pages
{
    /// <summary>
    /// Base class for all page types
    /// </summary>
    public abstract class SitePageData : PageData, ICustomCssInContentArea
    {
        [Display(
            GroupName = Global.GroupNames.MetaData,
            Order = 100)]
        [CultureSpecific]
        public virtual string MetaTitle
        {
            get
            {
                var metaTitle = this.GetPropertyValue(p => p.MetaTitle);

                // Use explicitly set meta title, otherwise fall back to page name
                return !string.IsNullOrWhiteSpace(metaTitle)
                       ? metaTitle
                       : PageName;
            }
            set { this.SetPropertyValue(p => p.MetaTitle, value); }
        }

        [Display(
            GroupName = Global.GroupNames.MetaData,
            Order = 200)]
        [CultureSpecific]
        [BackingType(typeof(PropertyStringList))]
        [UIHint(Global.SiteUIHints.Strings)]
        public virtual IList<string> MetaKeywords { get; set; }

        [Display(
            GroupName = Global.GroupNames.MetaData,
            Order = 300)]
        [CultureSpecific]
        [UIHint(UIHint.Textarea)]
        public virtual string MetaDescription { get; set; }

        [Display(
            GroupName = Global.GroupNames.MetaData,
            Order = 400)]
        [CultureSpecific]
        public virtual bool DisableIndexing { get; set; }

        [Display(
            GroupName = SystemTabNames.Content,
            Order = 100)]
        [UIHint(UIHint.Image)]
        public virtual ContentReference PageImage { get; set; }

        [Display(
            GroupName = SystemTabNames.Content,
            Order = 200)]
        [CultureSpecific]
        [UIHint(UIHint.Textarea)]
        public virtual string TeaserText
        {
            get
            {
                var teaserText = this.GetPropertyValue(p => p.TeaserText);

                // Use explicitly set teaser text, otherwise fall back to description
                return !string.IsNullOrWhiteSpace(teaserText)
                       ? teaserText
                       : MetaDescription;
            }
            set { this.SetPropertyValue(p => p.TeaserText, value); }
        }

        [Display(
            GroupName = SystemTabNames.Settings,
            Order = 200)]
        [CultureSpecific]
        public virtual bool HideSiteHeader { get; set; }

        [Display(
            GroupName = SystemTabNames.Settings,
            Order = 300)]
        [CultureSpecific]
        public virtual bool HideSiteFooter { get; set; }

        [Display(
            Name = "Page is navigation root",
            Description = "When checked this page becomes the root for the navigation elements",
            GroupName = SystemTabNames.Settings,
            Order = 500)]
        [CultureSpecific]
        public virtual bool PageIsNavigationRoot { get; set; }

        public ContentReference NavigationRoot
        {
            get
            {
                var loader = ServiceLocator.Current.GetInstance<IContentLoader>();
                return FindEffectiveStartPage(this.ContentLink, loader);
            }
        }

        private ContentReference FindEffectiveStartPage(ContentReference currentPageRef, IContentLoader loader)
        {
            if (ContentReference.IsNullOrEmpty(currentPageRef))
            {
                return SiteDefinition.Current.StartPage;
            }
            if (SiteDefinition.Current.StartPage == currentPageRef)
            {
                return currentPageRef;
            }
            else
            {
                var currentPage = loader.Get<IContent>(currentPageRef) as SitePageData;
                if (currentPage != null && currentPage.PageIsNavigationRoot)
                {
                    return currentPageRef;
                }
                else
                {
                    if (currentPage == null)
                    {
                        return SiteDefinition.Current.StartPage;
                    }
                    else
                    {
                        var parentPage = loader.Get<IContent>(currentPage.ParentLink);
                        return FindEffectiveStartPage(parentPage.ContentLink, loader);
                    }
                }
            }
        }

        public string ContentAreaCssClass
        {
            get { return "teaserblock"; } //Page partials should be style like teasers
        }


        [Display(
           Name = "Google Font",
           GroupName = Global.GroupNames.Styles,
           Order = 75)]
        [SelectOne(SelectionFactoryType = typeof(FontSelectionFactory))]
        public virtual string GoogleFont { get; set; }

        [Display(
        Name = "CSS Files",
        GroupName = Global.GroupNames.Styles,
        Order = 100)]
        public virtual LinkItemCollection CSSFiles { get; set; }

        [Display(
            GroupName = Global.GroupNames.Styles,
            Order = 110)]
        [UIHint(UIHint.Textarea)]
        public virtual string CSS { get; set; }


        [Display(
        Name = "Script Files",
        GroupName = Global.GroupNames.Scripts,
        Order = 100)]
        public virtual LinkItemCollection ScriptFiles { get; set; }

        [Display(
            GroupName = Global.GroupNames.Scripts,
            Order = 110)]
        [UIHint(UIHint.Textarea)]
        public virtual string Scripts { get; set; }

        [Display(
          GroupName = Global.GroupNames.Review, Name = "Review In",
          Order = 110)]
        public virtual string ReviewIn { get; set; }

        [Display(
          GroupName = Global.GroupNames.Review, Name = "Amount of time",
          Order = 120)]
        [SelectOne(SelectionFactoryType = typeof(DaysSelectionFactory))]
        public virtual string AmountOfTime { get; set; }

    }

    public class DaysSelectionFactory : ISelectionFactory
    {

        public IEnumerable<ISelectItem> GetSelections(ExtendedMetadata metadata)
        {
            return new ISelectItem[] { new SelectItem() { Text = "Days", Value = "Days" }, new SelectItem() { Text = "Weeks", Value = "Weeks" }
            , new SelectItem() { Text = "Months", Value = "Months" }
            , new SelectItem() { Text = "Year", Value = "Year" }};

        }
    }
}
