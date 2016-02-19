<%@ Import Namespace="System.Web.Mvc" %>
<%@ Import Namespace="EPiServer.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Forms.Core.Models" %>
<%@ Import Namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ Control Language="C#" Inherits="ViewUserControl<ResetButtonElementBlock>" %>

<%  var formElement = Model.FormElement; 
    var buttonText = Model.Label; %>

<input  
    <%--name="<%: formElement.Code %>" id="<%: formElement.Guid %>" --%>
    type="reset" form="<%: Model.FormElement.Form.FormGuid %>"
    class="Form__Element FormResetButton" <%: Html.Raw(formElement.AttributesString) %> 
    value="<%: buttonText %>" >