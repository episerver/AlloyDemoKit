<%@ Import Namespace="System.Web.Mvc" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Forms" %>
<%@ Import Namespace="EPiServer.Forms.Core" %>
<%@ Import Namespace="EPiServer.Forms.Core.Models" %>
<%@ Import Namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ Control Language="C#" Inherits="ViewUserControl<PredefinedHiddenElementBlock>" %>

<%  var isViewModeInvisibleElement = Model is IViewModeInvisibleElement;
    var extraCSSClass = isViewModeInvisibleElement ? Constants.CSS_InvisibleElement : string.Empty;
    var formElement = Model.FormElement;

    if (EPiServer.Editor.PageEditing.PageIsInEditMode) { %>
<span class="Form__Element FormHidden <%:extraCSSClass %> "><%: Model.EditViewFriendlyTitle %></span>
<% } else { %>

<input name="<%: formElement.ElementName %>" id="<%: formElement.Guid %>" type="hidden"
    value="<%: Model.GetDefaultValue() %>"
    class="Form__Element FormHidden FormHideInSummarized" <%: Html.Raw(Model.AttributesString) %> />
<% } %>
