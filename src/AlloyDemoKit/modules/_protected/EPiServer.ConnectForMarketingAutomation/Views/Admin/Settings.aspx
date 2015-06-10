<%@ Page Language="C#" AutoEventWireup="false" CodeBehind="Settings.aspx.cs" Inherits="EPiServer.MarketingAutomationIntegration.Views.Admin.Settings" %>

<asp:content runat="server" contentplaceholderid="FullRegion">
    <div class="epi-contentContainer epi-padding">
        <div id="statusMessage" runat="server" class="EP-systemMessage EP-systemMessage-Warning" visible="false"></div>
        <asp:PlaceHolder ID="SettingsPlaceHolder" runat="server" />
    </div>
</asp:content>
