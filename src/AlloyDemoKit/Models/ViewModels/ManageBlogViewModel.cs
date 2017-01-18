using AlloyDemoKit.Models.Pages.Blog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AlloyDemoKit.Models.ViewModels
{
    public class ManageBlogViewModel : PageViewModel<BlogManage>
    {
        public ManageBlogViewModel(BlogManage blogManage,
            IEnumerable<BlogItemPage> blogItems) : base(blogManage)
        {
            BlogPosts = blogItems;
        }

        public IEnumerable<BlogItemPage> BlogPosts { get; private set; }
    }
}