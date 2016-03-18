<%@ import namespace="System.Web.Mvc" %>
<%@ import namespace="EPiServer.Web.Mvc.Html" %>
<%@ import namespace="EPiServer.Forms" %>
<%@ import namespace="EPiServer.Forms.Core.Models" %>
<%@ import namespace="EPiServer.Forms.Helpers" %>
<%@ import namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ control language="C#" inherits="ViewUserControl<NumberElementBlock>" %>

<%  var formElement = Model.FormElement; 
    var labelText = Model.Label;
%>

<div class="Form__Element FormTextbox FormTextbox--Number <%: Model.GetValidationCssClasses() %>" data-epiforms-element-name="<%: formElement.Code %>" >
    <label for="<%: formElement.Guid %>" class="Form__Element__Caption"><%: labelText %></label>
    <input name="<%: formElement.Code %>" id="<%: formElement.Guid %>" type="text" placeholder="<%: Model.PlaceHolder %>"
        class="FormTextbox__Input"
        <%: Html.Raw(formElement.AttributesString) %>
        value="<%: Model.PredefinedValue %>" />
    <span data-epiforms-linked-name="<%: formElement.Code %>" class="Form__Element__ValidationError" style="display: none;">*</span>
</div>
