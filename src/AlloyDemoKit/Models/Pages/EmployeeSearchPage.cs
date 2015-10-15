using System;
using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;
using EPiServer.SpecializedProperties;
using AlloyDemoKit.Business.Rendering;

namespace AlloyDemoKit.Models.Pages
{
    [SiteContentType(
        GUID = "48E693F7-0C4E-4C3F-9A67-819BDA0EC89B",
        DisplayName = "Employee search page",
        Description = "Used to allow user search",
        GroupName = Global.GroupNames.Specialized)]
    [SiteImageUrl(Global.StaticGraphicsFolderPath + "page-type-thumbnail-contact.png")]
    public class EmployeeSearchPage : SitePageData, IContainerPage
    {
    }
}