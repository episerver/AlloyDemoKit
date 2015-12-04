<%@ import namespace="System.Web.Mvc" %>
<%@ import namespace="EPiServer.Core" %>
<%@ import namespace="EPiServer.Web.Mvc.Html" %>
<%@ import namespace="EPiServer.Forms.Core" %>
<%@ import namespace="EPiServer.Forms.Core.Models" %>
<%@ import namespace="EPiServer.Forms.Helpers" %>
<%@ import namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ control language="C#" inherits="ViewUserControl<FormContainerBlock>" %>
/* This view acts as a rendering template to render InitScript(and server-side Form's descriptor) in FormContainerBlock's client-side for Form[<%: Model.Form.FormGuid %>].
TECHNOTE: all serverside (paths, dynamic values) of EPiServerForms will be transfered to client side here in this section. */
(function initializeOnRenderingFormDescriptor() {
    // each workingFormInfo is store inside epi.EPiServer.Forms, lookup by its FormGuid
    var workingFormInfo = epi.EPiServer.Forms["<%: Model.Form.FormGuid %>"] = {
        Id: "<%: Model.Form.FormGuid %>",
        Name: "<%: Model.Form.Name %>",
        // whether this Form can be submitted which relates to the visitor's data (cookie, identity) and Form's settings (AllowAnonymous, AllowXXX)
        SubmittableStatus : <%: @Html.Raw(Model.Form.GetSubmittableStatus(new HttpContextWrapper(HttpContext.Current)).ToJson()) %>,
        ConfirmMessage : "<%: FormsExtensions.Replace(Model.ConfirmationMessage, "[\n\r]", " ") %>",
        ShowProgressBar : <%: Model.ShowProgressBar.ToString().ToLower() %>,
        ShowSummarizedData : <%: Model.ShowSummarizedData.ToString().ToLower() %>,
            
        // Validation info, for executing validating on client side
        ValidationInfo : <%: Html.Raw(Model.GetFormValidationInfo().ToJson()) %>,
        // Steps information for driving multiple-step Forms.
        StepsInfo : {
            Steps: <%: @Html.Raw(Model.GetStepsDescriptor().ToJson()) %>
        },

        FieldsFriendlyName : {
            <% foreach (var element in Model.Form.Steps.SelectMany(step => step.Elements)) { 
                var fe = element as FormElement;
                // this flag will be true if Element is kind of IViewModeInvisibleElement
                var ignore = fe.SourceContent as IViewModeInvisibleElement != null;
                %>

                 "<%: (element as FormElement).Code%>" : "<%: ignore ? "" : (element as FormElement).SourceContent.Name %>",    <%--// <%: Ajax.JavaScriptStringEncode((element as FormElement).SourceContent.Name) %>--%>
            <% }  %>
        }
    };
    
    /// TECHNOTE: Calculation at FormInfo level, and these values will be static input for later processing.
    // -- this FLAG will be true, if Editor does not put any FormStep. Engine will create a virtual step, with empty GUID
    var firstStep = workingFormInfo.StepsInfo.Steps[0];
    if(firstStep){
        workingFormInfo.StepsInfo.FormHasNoStep_VirtualStepCreated = firstStep.guid === "00000000-0000-0000-0000-000000000000";
    }
    else{
        workingFormInfo.StepsInfo.FormHasNothing = true; // no element, no step at all.
    }

    
    // -- this FLAG will be true, if all steps all have contentLink=="" (emptyString)
    workingFormInfo.StepsInfo.AllStepsAreNotLinked = true;   
    for(var i=0; i < workingFormInfo.StepsInfo.Steps.length; i++){
        var step = workingFormInfo.StepsInfo.Steps[i];
        workingFormInfo.StepsInfo.AllStepsAreNotLinked = workingFormInfo.StepsInfo.AllStepsAreNotLinked && !(step.attachedContentLink);
    }

})();