using AlloyDemoKit.Models.Pages.Blog;

namespace AlloyDemoKit.Models.ViewModels
{
    public class ManageBlogItemViewModel : PageViewModel<BlogManage>
    {
        public ManageBlogItemViewModel()
        {
            
        }
        public ManageBlogItemViewModel(BlogManage currentPage) : base(currentPage)
        {
            
        }
        public string MetaTitle { get; set; }
        public string MetaKeywords { get; set; }
        public string MetaDescription { get; set; }
        public string Title { get; set; }
        public string Post { get; set; }
        public string ContentLink { get; set; }
    }
}