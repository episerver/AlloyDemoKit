<%@ import namespace="System.Web.Mvc" %>
<%@ import namespace="EPiServer.Web.Mvc.Html" %>
<%@ import namespace="EPiServer.Forms.Core.Models" %>
<%@ import namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ control language="C#" inherits="ViewUserControl<CaptchaElementBlock>" %>

<%  var formElement = Model.FormElement; 
    var labelText = Model.Label; %>

<div class="Form__Element FormCaptcha" data-epiforms-element-name="<%: formElement.Code %>" >
    <label class="Form__Element__Caption" for="<%: formElement.Guid %>">
        <%: labelText %>
        <a data-epiforms-captcha-image-handler="<%: formElement.Guid %>" class="FormCaptcha__Refresh" href=""><%: Html.Translate("/episerver/forms/viewmode/refreshcaptcha")%></a>
    </label>
    <img src="<%: Model.CaptchaImageHandler %>" class="FormCaptcha__Image" />
    <input id="<%: formElement.Guid %>" name="<%: formElement.Code %>" type="text" class="FormTextbox__Input FormCaptcha__Input FormHideInSummarized" />
    
    <span data-epiforms-linked-name="<%: formElement.Code %>" class="Form__Element__ValidationError" style="display: none;">*</span>
</div>
