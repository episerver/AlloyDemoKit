<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PersonalizationEdit.ascx.cs" Inherits="EPiServer.MarketingAutomationIntegration.Views.Edit.DynamicContent.PersonalizationEdit, EPiServer.MarketingAutomationIntegration" %>

<style type="text/css">
    body {
        font-family: sans-serif;
        font-size: 11pt;
    }
    .draggableHolder {
        padding-left: 10px;
    }
    .draggable {
        min-width: 125px;
        height: 15px;
        background-color: #e6eaff;
        border: 2px solid #3399cc;
        margin: 0 0 2px 2px;
        padding: 2px;
        cursor: default;
        float: left;
    }
    .active {
        border: 2px solid #6699ff;
    }
    #droppable {
        font-size: 14pt;
        width: 500px;
    }
    .droppableHolder {
        padding-left: 10px;
    }
    .clear {
        clear: left;
    }
    .error {
        color: Red;
    }
</style>

<script type="text/javascript">
    function initialize() {
        $(".draggable").draggable({
            revert: true,
            helper: 'clone',
            start: function (event, ui) {
                $(this).fadeTo('fast', 0.5);
            },
            stop: function (event, ui) {
                $(this).fadeTo(0, 1);
            }
        });

        $("#<%=txtDroppable.ClientID %>").droppable({
            hoverClass: 'active',
            drop: function (event, ui) {
                var space = " ";
                if (this.value.substr(-1) === " " || this.value === "") {
                    space = "";
                }
                this.value += space + "%%" +$(ui.draggable).text() + "%%";
            }
        });
    }

    $(initialize);
</script>

<asp:Panel ID="Data" runat="server">
    <asp:Panel runat="server" CssClass="epirowcontainer">
        <asp:Label ID="lblDatabase" CssClass="epiindent" runat="server" Text="<%$Resources: EPiServer, episerver.edit.dynamiccontent.marketingautomationcontent.marketingautomationdatabase %>" />
        <asp:DropDownList ID="ddlDatabase" runat="server" AutoPostBack="true"></asp:DropDownList>
        <div class="clear"></div>
    </asp:Panel>
    <asp:Panel runat="server" CssClass="epirowcontainer">
        <asp:Label ID="lblDraggable" CssClass="epiindent" runat="server" Text="<%$Resources: EPiServer, episerver.edit.dynamiccontent.marketingautomationcontent.marketingautomationfields %>" />
        <asp:Panel ID="pnlDraggable" runat="server" CssClass="draggableHolder"></asp:Panel>
        <div class="clear"></div>
    </asp:Panel>
    <asp:Panel runat="server" CssClass="epirowcontainer">
        <asp:Label ID="lblSystem" CssClass="epiindent" runat="server" Text="<%$Resources: EPiServer, episerver.edit.dynamiccontent.marketingautomationcontent.environmentvariables %>" />
        <div class="draggableHolder">
            <div class="draggable"><%= Translate("/episerver/edit/dynamiccontent/marketingautomationcontent/newline") %></div>
        </div>
        <div class="clear"></div>
    </asp:Panel>
    <asp:Panel runat="server" CssClass="epirowcontainer">
        <asp:Label ID="lblDroppable" CssClass="epiindent" runat="server" Text="<%$Resources: EPiServer, episerver.edit.dynamiccontent.marketingautomationcontent.dropfieldshere %>" />
        <div class="droppableHolder">
            <textarea id="txtDroppable" runat="server" rows="5" cols="50"></textarea>
        </div>
    </asp:Panel>
</asp:Panel>
<asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="error">
    <%= Translate("/episerver/edit/dynamiccontent/marketingautomationcontent/featurenotavailable") %>
</asp:Panel>