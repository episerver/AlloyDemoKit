using AlloyDemoKit.Models;
using EPiServer.Core;
using EPiServer.ServiceLocation;
using EPiServer.Shell.Security;
using EPiServer.Web.Routing;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using EPiServer.Security;
using EPiServer.DataAbstraction;

namespace AlloyDemoKit.Controllers
{
    /// <summary>
    /// Used to register a user for first time
    /// </summary>
    public class RegisterController : Controller
    {
        const string AdminRoleName = "WebAdmins";
        const string WebEditorsRoleName = "WebEditors";
        const string NewsEditorsRoleName = "NewsEditors";
        const string ProductEditorsRoleName = "ProductEditors";
        const string DefaultPassword = "3p!Pass";

        public const string ErrorKey = "CreateError";
        private readonly IContentSecurityRepository securityRepository;

        public RegisterController(IContentSecurityRepository securityRepository)
        {

            this.securityRepository = securityRepository;
        }

        public ActionResult Index()
        {

            IEnumerable<string> errors = Enumerable.Empty<string>();

            UIRoleProvider.CreateRole(WebEditorsRoleName);

            IUIUser result = null;

            //Create News Editor
            result = UIUserProvider.CreateUser("nancy", DefaultPassword, "nancy@alloy.com", null, null, true, out UIUserCreateStatus status, out errors);
            if (status == UIUserCreateStatus.Success)
            {
                UIRoleProvider.CreateRole(NewsEditorsRoleName);
                UIRoleProvider.AddUserToRoles(result.Username, new string[] { NewsEditorsRoleName, WebEditorsRoleName });
                SetAccessForNewsEditors(NewsEditorsRoleName);
            }

            //Create Product editor
            result = UIUserProvider.CreateUser("peter", DefaultPassword, "peter@alloy.com", null, null, true, out status, out errors);
            if (status == UIUserCreateStatus.Success)
            {
                UIRoleProvider.CreateRole(ProductEditorsRoleName);
                UIRoleProvider.AddUserToRoles(result.Username, new string[] { ProductEditorsRoleName, WebEditorsRoleName });
                SetAccessForProductEditors(ProductEditorsRoleName);
            }

            //Create Admin
            result = UIUserProvider.CreateUser("epiadmin", DefaultPassword, "epiadmin@alloy.com", null, null, true, out status, out errors);
            if (status == UIUserCreateStatus.Success)
            {
                UIRoleProvider.CreateRole(AdminRoleName);
                UIRoleProvider.AddUserToRoles(result.Username, new string[] { AdminRoleName, WebEditorsRoleName });
                SetupAdminAndUsersPage.IsEnabled = false;
                SetAccessForWebAdmin(AdminRoleName);
                var resFromSignIn = UISignInManager.SignIn(UIUserProvider.Name, "epiadmin", DefaultPassword);
                if (resFromSignIn)
                {
                    return Redirect(UrlResolver.Current.GetUrl(ContentReference.StartPage));
                }
            }
            AddErrors(errors);
            return Content($"<p>Default users have been created! Please see the 'Alloy Demo Site' document in the 'Release Notes' folder for login details</p><p>Errors:{errors.ToString()}");
        }



        private void SetAccessForWebAdmin(string roleName)
        {
            SetSecurity(ContentReference.RootPage, roleName, AccessLevel.FullAccess);
        }


        private void SetAccessForNewsEditors(string roleName)
        {
            SetSecurity(ContentReference.Parse("17"), roleName, AccessLevel.Read | AccessLevel.Create | AccessLevel.Edit);
            SetSecurity(ContentReference.Parse("205"), roleName, AccessLevel.Read | AccessLevel.Create | AccessLevel.Edit);
            SetSecurity(ContentReference.Parse("199"), roleName, AccessLevel.Read | AccessLevel.Create | AccessLevel.Edit);
        }

        private void SetAccessForProductEditors(string roleName)
        {
            SetSecurity(ContentReference.Parse("6"), roleName, AccessLevel.Read | AccessLevel.Create | AccessLevel.Edit | AccessLevel.Delete);
            SetSecurity(ContentReference.Parse("9"), roleName, AccessLevel.Read | AccessLevel.Create | AccessLevel.Edit | AccessLevel.Delete);
            SetSecurity(ContentReference.Parse("13"), roleName, AccessLevel.Read | AccessLevel.Create | AccessLevel.Edit | AccessLevel.Delete);
        }

        private void SetSecurity(ContentReference reference, string role, AccessLevel level)
        {
            IContentSecurityDescriptor permissions = securityRepository.Get(reference).CreateWritableClone() as IContentSecurityDescriptor;

            permissions.AddEntry(new AccessControlEntry(role, level));
            securityRepository.Save(reference, permissions, SecuritySaveType.Replace);
        }


        private void AddErrors(IEnumerable<string> errors)
        {
            foreach (var error in errors)
            {
                ModelState.AddModelError(ErrorKey, error);
            }
        }

        protected override void OnAuthorization(AuthorizationContext filterContext)
        {
            if (!SetupAdminAndUsersPage.IsEnabled)
            {
                filterContext.Result = new HttpNotFoundResult();
                return;
            }
            base.OnAuthorization(filterContext);
        }

        UIUserProvider UIUserProvider
        {
            get
            {
                return ServiceLocator.Current.GetInstance<UIUserProvider>();
            }
        }
        UIRoleProvider UIRoleProvider
        {
            get
            {
                return ServiceLocator.Current.GetInstance<UIRoleProvider>();
            }
        }
        UISignInManager UISignInManager
        {
            get
            {
                return ServiceLocator.Current.GetInstance<UISignInManager>();
            }
        }

    }
}