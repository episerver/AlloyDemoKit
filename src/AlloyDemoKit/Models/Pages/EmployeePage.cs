using EPiServer.Core;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using EPiServer.Shell.ObjectEditing;
using AlloyDemoKit.Business.Employee;

namespace AlloyDemoKit.Models.Pages
{
    [SiteContentType(
        GUID = "C8B24A4E-8D19-42FA-86DD-C03E5BF09ECE",
        DisplayName = "Employee",
        Description = "Used to enter employee contact records", 
        GroupName = Global.GroupNames.Specialized)]
    [SiteImageUrl(Global.StaticGraphicsFolderPath + "page-type-thumbnail-contact.png")]
    public class EmployeePage : SitePageData
    {
        [Display(GroupName = Global.GroupNames.Contact, Name = "Employee ID", Order = 0)]
        public virtual string EmployeeID { get; set; }

        [Display(GroupName = Global.GroupNames.Contact, Name = "First Name", Order = 1)]
        public virtual string FirstName { get; set; }

        [Display(GroupName = Global.GroupNames.Contact, Name = "Last Name", Order = 2)]
        public virtual string LastName { get; set; }

        [Display(GroupName = Global.GroupNames.Contact, Name = "Job title", Order = 3)]
        public virtual string JobTitle { get; set; }

        [Display(GroupName = Global.GroupNames.Contact, Name = "Profile Image", Order = 4)]
        public virtual string ImageUrl { get; set; }

        [Display(GroupName = Global.GroupNames.Contact, Name = "Telephone", Order = 5)]
        public virtual string Phone { get; set; }

        [Display(GroupName = Global.GroupNames.Contact, Name = "Email address", Order = 6)]
        public virtual string Email { get; set; }

        [Display(GroupName = Global.GroupNames.Contact, Name = "Location", Order = 7)]
        [UIHint(UIHintsEmployee.EmployeeLocation)]
        public virtual string EmployeeLocation { get; set; }

        [Display(GroupName = Global.GroupNames.Contact, Name = "Areas of expertise", Order = 8)]
        [SelectMany(SelectionFactoryType = typeof(EmployeeExpertiseSelectionFactory))]
        public virtual string EmployeeExpertise { get; set; }

        [Display(GroupName = Global.GroupNames.Contact, Name = "Description", Order = 9)]
        public virtual XhtmlString Description { get; set; }

        public virtual List<string> EmployeeExpertiseList
        {
            get
            {
                if (!string.IsNullOrWhiteSpace(this.EmployeeExpertise))
                {
                    return new List<string>(this.EmployeeExpertise.Split(",".ToCharArray()));
                }
                else
                {
                    return new List<string>();
                }
            }
        }
    }
}