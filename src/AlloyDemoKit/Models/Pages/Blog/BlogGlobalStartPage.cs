using AlloyDemoKit.Business;
using AlloyDemoKit.Models.Pages.Models.Blocks;
using EPiServer.Cms.Shell.UI.ObjectEditing.EditorDescriptors;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using EPiServer.Shell.ObjectEditing;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using AlloyDemoKit.Models.Blocks;

namespace AlloyDemoKit.Models.Pages.Blog
{
    [SiteContentType(DisplayName = "Blog Global Start Page", 
        GUID = "ee4dba27-28b6-4634-b11c-80d75e82da3a", 
        Description = "Start page for all bloggers",
        GroupName = "Blog")]
    [SiteImageUrl(Global.StaticGraphicsFolderPath + "page-type-thumbnail-article.png")]
    [AvailableContentTypes(Availability.Specific,
        Include = new[] { typeof(BlogUserStartPage)})]
    public class BlogGlobalStartPage : StandardPage
    {
        [Display(GroupName = SystemTabNames.Content)]
        public virtual BlogListBlock BlogList { get; set; }

        [Display(GroupName = SystemTabNames.Content)]
        public virtual TagCloudBlock TagCloud { get; set; }

        [Display(GroupName = SystemTabNames.Content)]
        public virtual BlogArchiveBlock Archive { get; set; }

        [Display(GroupName = SystemTabNames.Content)]
        [EditorDescriptor(EditorDescriptorType = typeof(CollectionEditorDescriptor<AuthorList>))]
        public virtual IList<AuthorList> Authors { get; set; }

        public override void SetDefaultValues(ContentType contentType)
        {
            base.SetDefaultValues(contentType);

            BlogList.PageTypeFilter = typeof(BlogItemPage).GetPageType();
            BlogList.Recursive = true;
        }
    }
}