<%@ Import Namespace="System.Web.Mvc" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Forms" %>
<%@ Import Namespace="EPiServer.Forms.Core" %>
<%@ Import Namespace="EPiServer.Forms.Core.Models" %>
<%@ Import Namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ Control Language="C#" Inherits="ViewUserControl<FormStepBlock>" %>

<% 
    var isViewModeInvisibleElement = Model is IViewModeInvisibleElement;
    var extraCSSClass = isViewModeInvisibleElement ? Constants.CSS_InvisibleElement : string.Empty;
    var warningMessage = Model.WarningMessage;

    if (EPiServer.Editor.PageEditing.PageIsInEditMode) { %>
        <section class="Form__Element FormStep Form__Element--NonData <%:extraCSSClass %>">
            <h3 class="FormStep__Title  "><%: Model.EditViewFriendlyTitle %></h3>
            <aside class="FormStep__Description"><%: Model.Description %></aside>
            <% if(!string.IsNullOrEmpty(warningMessage)) { %>
                <span class="FormStep__Warning"><%: warningMessage %></span>
            <% } %>
        </section>
<%  } else { %>
        <h3 class="FormStep__Title"><%: Model.Label %></h3>
        <aside class="FormStep__Description"><%: Model.Description %></aside>
<%  } %>
