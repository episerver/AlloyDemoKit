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
        GUID = "ed44508d-280e-40e8-9c74-96eab34073d0",
        DisplayName = "Employee expertise type",
        Description = "Used to enter possible employee expertise areas",
        GroupName = Global.GroupNames.Specialized)]
    [SiteImageUrl(Global.StaticGraphicsFolderPath + "page-type-thumbnail-contact.png")]
    public class EmployeeExpertise : SitePageData, IContainerPage
    {
    }
}