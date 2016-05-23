<%@ Import Namespace="System.Web.Mvc" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Forms.Core" %>
<%@ Import Namespace="EPiServer.Forms.Core.Models" %>
<%@ Import Namespace="EPiServer.Forms.Helpers" %>
<%@ Import Namespace="EPiServer.Forms.Implementation.Elements" %>

<%@ Control Language="C#" Inherits="ViewUserControl<RangeElementBlock>" %>

<%
    var formElement = Model.FormElement;
    var labelText = Model.Label;
%>

<div class="Form__Element FormRange" data-epiforms-element-name="<%: formElement.Code %>">
    <label for="<%: formElement.Guid %>" class="Form__Element__Caption"><%:labelText %></label>
    <span>
        <span class="FormRange__Min"><%: Model.Min %></span>
        <input name="<%: formElement.Code %>" id="<%: formElement.Guid %>" type="range" class="FormRange__Input"
               value="<%: Model.GetRangeValue() %>"
               min="<%: Model.Min %>" max="<%: Model.Max %>" step="<%: Model.Step %>" <%: Html.Raw(Model.AttributesString) %> />
        <span class="FormRange__Max"><%: Model.Max %></span>
    </span>
    <span data-epiforms-linked-name="<%: formElement.Code %>" class="Form__Element__ValidationError" style="display: none;">*</span>
</div>