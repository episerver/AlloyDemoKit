using System;
using System.Web.Mvc;

namespace AlloyDemoKit.Business.VisitorGroupUIStyling
{
    public class OverrideVisitorGroupCssAttribute : OutputProcessorActionFilterAttribute
    {
        protected override string Process(string data)
        {
            return data
                .Replace("</head", "<link href=\"/Static/css/VisitorGroupUIOverrides.css\" rel=\"stylesheet\"></link></head");
        }

        protected override bool ShouldProcess(ResultExecutedContext filterContext)
        {
            var result = filterContext.Result as ViewResultBase;
            return result?.View is WebFormView view
                && (view.ViewPath.Equals("/EPiServer/CMS/Views/VisitorGroups/Index.aspx", StringComparison.InvariantCultureIgnoreCase) || view.ViewPath.Equals("/EPiServer/CMS/Views/VisitorGroups/Edit.aspx", StringComparison.InvariantCultureIgnoreCase));
        }
    }
}