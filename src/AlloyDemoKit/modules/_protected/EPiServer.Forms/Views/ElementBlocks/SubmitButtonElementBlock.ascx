<%@ Import Namespace="System.Web.Mvc" %>
<%@ Import Namespace="EPiServer.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Forms" %>
<%@ Import Namespace="EPiServer.Forms.Core.Models" %>
<%@ Import Namespace="EPiServer.Forms.Helpers" %>
<%@ Import Namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ Control Language="C#" Inherits="ViewUserControl<SubmitButtonElementBlock>" %>

<%
    var formElement = Model.FormElement;
    var buttonText = Model.Label;

    var buttonDisableState = Model.GetElementDisableState(ViewContext.Controller.ControllerContext.HttpContext);
%>

<button id="<%: formElement.Guid %>" name="submit" type="submit" value="<%: SubmitButtonType.Submit.ToString() %>"
    class="Form__Element FormSubmitButton"
    <%= formElement.AttributesString %> <%: buttonDisableState %>>
    <%: buttonText %>
</button>
