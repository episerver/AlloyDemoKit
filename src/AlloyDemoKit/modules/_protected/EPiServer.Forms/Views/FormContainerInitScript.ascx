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
        ShowNavigationBar : <%: Model.ShowNavigationBar.ToString().ToLower() %>,
        ShowSummarizedData : <%: Model.ShowSummarizedData.ToString().ToLower() %>,
            
        // Validation info, for executing validating on client side
        ValidationInfo : <%: Html.Raw(Model.GetFormValidationInfo().ToJson()) %>,
        // Steps information for driving multiple-step Forms.
        StepsInfo : {
            Steps: <%: @Html.Raw(Model.GetStepsDescriptor().ToJson()) %>
        },
        FieldsExcludedInSubmissionSummary: <%: Html.Raw(Model.Form.GetFieldsExcludedInSubmissionSummary().ToJson()) %>,
        ElementsInfo: <%: Html.Raw(Model.GetElementsDescriptor().ToJson()) %>
    };
    
    /// TECHNOTE: Calculation at FormInfo level, and these values will be static input for later processing.
    workingFormInfo.StepsInfo.FormHasNoStep_VirtualStepCreated = <%: ViewBag.FormHasNoStep_VirtualStepCreated.ToString().ToLower() %>;  // this FLAG will be true, if Editor does not put any FormStep. Engine will create a virtual step, with empty GUID
    workingFormInfo.StepsInfo.FormHasNothing = <%: ViewBag.FormHasNothing.ToString().ToLower() %>;  // this FLAG will be true if FormContainer has no element at all
    workingFormInfo.StepsInfo.AllStepsAreNotLinked = <%: ViewBag.AllStepsAreNotLinked.ToString().ToLower() %>;  // this FLAG will be true, if all steps all have contentLink=="" (emptyString)
})();