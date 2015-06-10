<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.MarketingAutomationIntegration.UI.Plugins.VisitorGroups.Criteria.ScoringRank.ScoringRankModel>" %>

<%@ Assembly Name="EPiServer.MarketingAutomationIntegration" %>
<%@ Assembly Name="EPiServer.CMS.Shell.UI" %>
<%@ Import Namespace="EPiServer.Personalization.VisitorGroups.Criteria" %>
<%@ Import Namespace="EPiServer.Personalization.VisitorGroups" %>

<div>
    <div class="epi-critera-block">
        <span class="epi-criteria-inlineblock">
            <%= Html.LabelFor(model => model.Model, new { @class = "episize200" })%>
        </span>
        <span class="epi-criteria-inlineblock">
            <%= Html.DojoEditorFor(model => model.Model)%>
        </span>
    </div>
    <div class="epi-critera-block">
        <span class="epi-criteria-inlineblock">
            <%= Html.LabelFor(model => model.Rank, new { @class = "episize200" })%>
        </span>
        <span class="epi-criteria-inlineblock">
            <%= Html.DojoEditorFor(model => model.Rank)%>
        </span>
    </div>
</div>