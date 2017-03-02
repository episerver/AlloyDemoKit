using System.Collections.Generic;
using System.Web;
using System.Web.Mvc;
using MenuPin.Attributes;

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
            var view = result?.View as WebFormView;
            return view != null 
                && (view.ViewPath.Equals("/EPiServer/CMS/Views/VisitorGroups/Index.aspx") || view.ViewPath.Equals("/EPiServer/CMS/Views/VisitorGroups/Edit.aspx"));
        }
    }
}