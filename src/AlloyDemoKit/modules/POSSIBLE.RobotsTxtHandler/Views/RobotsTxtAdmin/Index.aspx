<%@ Page Title="" Language="C#" MasterPageFile="../Shared/AdminPlugin.Master" Inherits="System.Web.Mvc.ViewPage<POSSIBLE.RobotsTxtHandler.UI.Models.RobotsTxtViewModel>" %>
<%@ Import Namespace="EPiServer.Cms.Shell" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <style type="text/css">
        table.epi-default tr td.unavailable { background-color: #eee;}     
    </style>
    
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
           
            $("#SiteId").change(function () {
                var selected = $("#SiteId option:selected").val();
                var path = "<%=Model.KeyActionPath %>" + "RobotsTxtAdmin/KeyChange";
                
                $.post(path, { key: selected }).done(function (data) {
                    $("#RobotsContent").html(data);
                });
            });    
        });
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
	<h1 class="epi-prefix">Manage robots.txt</h1>  
    
    <% if (Model.HasSaved) { %>
    <div class="EP-systemMessage EP-systemMessage-None"><%= Model.SuccessMessage %></div>
    <% } %>

    <% using (Html.BeginForm("Edit", "RobotsTxtAdmin")) %>
    <% { %>
    
    <div>Select your site and host to edit the robots.txt file: <%= Html.DropDownListFor(m => m.SiteId, Model.SiteList) %> </div>
    
    <br />
    <div style="min-width: 300px; max-width: 770px;">
        <textarea class="episize240" style="height:400px;width:100%;" id="RobotsContent" name="RobotsContent"><%=Model.RobotsContent %></textarea>
    </div>

    <br />
    <div class="epi-buttonContainer">
    <span class="epi-cmsButton">
        <input class="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Save" ID="btnSave" value="Save" type="submit" onmouseover="EPi.ToolButton.MouseDownHandler(this)" onmouseout="EPi.ToolButton.ResetMouseDownHandler(this)" />    
    </span>
    </div>
    
    <% } %>

</asp:Content>
