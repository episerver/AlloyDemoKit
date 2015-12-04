<%@ Import Namespace="System.Web.Mvc" %>
<%@ Import Namespace="EPiServer.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Forms.Core.Models" %>
<%@ Import Namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ Control Language="C#" Inherits="ViewUserControl<SubmitButtonElementBlock>" %>

<%  var formElement = Model.FormElement; 
    var buttonText = Model.Label; %>   

<button name="<%: formElement.Code %>" id="<%: formElement.Guid %>" type="submit" 
    class="Form__Element FormSubmitButton" 
    <%= formElement.AttributesString %> >
    <%: buttonText %>
</button>
