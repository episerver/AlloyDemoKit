<%@ import namespace="System.Web.Mvc" %>
<%@ import namespace="EPiServer.Web.Mvc.Html" %>
<%@ import namespace="EPiServer.Forms.Core.Models" %>
<%@ import namespace="EPiServer.Forms.Helpers" %>
<%@ import namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ control language="C#" inherits="ViewUserControl<FileUploadElementBlock>" %>

<%  var formElement = Model.FormElement; 
    var labelText = Model.Label;

%>

<div class="Form__Element FormFileUpload <%: Model.GetValidationCssClasses() %>" data-epiforms-element-name="<%: formElement.ElementName %>" >
    <label for="<%: formElement.Guid %>" class="Form__Element__Caption"><%: labelText %></label>
    <input name="<%: formElement.ElementName %>" id="<%: formElement.Guid %>" type="file" class="FormFileUpload__Input"
        accept="<%= string.IsNullOrEmpty(Model.FileExtensions) ? "" : Model.FileExtensions %>"        
        <%= Model.AttributesString %> />
    <div class="FormFileUpload__PostedFile"></div>
    <div data-epiforms-linked-name="<%: formElement.ElementName %>" class="Form__Element__ValidationError" style="display: none;">*</div>
</div>
