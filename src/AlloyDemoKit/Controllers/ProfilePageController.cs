using System.Web;
using System.Web.Mvc;
using EPiServer.Core;
using EPiServer.Framework.Web;
using EPiServer.Search;
using AlloyDemoKit.Business;
using AlloyDemoKit.Models.ViewModels;
using AlloyDemoKit.Models.Pages;
using EPiServer.Web;
using EPiServer.Web.Hosting;
using EPiServer.Web.Mvc.Html;
using EPiServer.Web.Routing;
using EPiServer.Personalization;

namespace AlloyDemoKit.Controllers
{
    public class ProfilePageController : PageControllerBase<ProfilePage>
    {
        [HttpPost]
        [ValidateInput(false)]
        public ViewResult Save(ProfilePage currentPage, ProfilePageViewModel model2)
        {
            model2.Profile.Save();

            var model = new ProfilePageViewModel(currentPage)
            {
                Profile = EPiServerProfile.Current,
                //Impersonating = false
            };

            //List<string> users = new List<string>();

            //users.Add("Jacob");
            //users.Add("Rik");
            //users.Add("Dean");

            //ViewData["users"] = new SelectList(users);

            return View("~/Views/ProfilePage/Index.cshtml", model);
        }

        public ViewResult Save(ProfilePage currentPage)
        {

            //model2.Profile.Save();

            var model = new ProfilePageViewModel(currentPage)
            {
                Profile = EPiServerProfile.Current,
                //Impersonating = false
            };
            return View("~/Views/ProfilePage/Index.cshtml", model);

        }

        public ViewResult Index(ProfilePage currentPage)
        {

            var model = new ProfilePageViewModel(currentPage)
            {
                Profile = EPiServerProfile.Current,
                //Impersonating = false
            };

            //List<string> users = new List<string>();

            //users.Add("Jacob");
            //users.Add("Rik");
            //users.Add("Dean");

            //ViewData["users"] = new SelectList(users);

            return View(model);
        }

        //public ViewResult Impersonate(ProfilePage currentPage, string users)
        //{
        //    EPiServerProfile ImpersonatedUser = EPiServerProfile.Get(users);


        //    var model = new ProfilePageViewModel(currentPage)
        //    {
        //        Profile = ImpersonatedUser,
        //        //Impersonating = true
        //    };

        //    List<string> users2 = new List<string>();

        //    users2.Add("Jacob");
        //    users2.Add("Rik");
        //    users2.Add("Dean");

        //    ViewData["users"] = new SelectList(users2);

        //    return View("~/Views/ProfilePage/Index.cshtml", model);
        //}

    }
}

