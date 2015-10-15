using AlloyDemoKit.Business.Rendering;
using EPiServer.Core;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AlloyDemoKit.Models.Pages
{
    [SiteContentType(
        GUID = "72406098-8BB0-48F0-9658-871CB58C5841",
        DisplayName = "Employee location",
        Description = "Used to enter possible employee locations", 
        GroupName = Global.GroupNames.Specialized)]
    [SiteImageUrl(Global.StaticGraphicsFolderPath + "page-type-thumbnail-contact.png")]
    public class EmployeeLocationPage : SitePageData, IContainerPage
    {
    }
}