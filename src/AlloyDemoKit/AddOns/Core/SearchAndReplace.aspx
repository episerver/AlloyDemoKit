<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchAndReplace.aspx.cs" Inherits="EPiServer.Templates.Alloy.AddOns.Core.SearchAndReplace1" %>
<asp:Content runat="server" ContentPlaceHolderID="HeaderContentRegion">

     <h3 style="padding-top:10px;">
            Search and Replace
        </h3>
</asp:Content>
<asp:Content ContentPlaceHolderID="MainRegion" runat="server">
       
        <div style="padding-top:5px; float:left;">
            <asp:TextBox ID="SearchQuery" runat="server" /> 
        </div>
        <div style="float:left;">
            <asp:Button ID="SearchButton" runat="server" Width="100px" Height="30px" CssClass="btn btn-primary" Text="Search" OnClick="SearchButton_Click" />
        </div>
        <div style="padding-top: 50px;">
            <EPiServer:PageList runat="server" ID="PagedResults" Paging="true" PagesPerPagingItem="5">
                <ItemTemplate>
                    <a href="<%#SiteUrl(Container.DataItem) %>" target="_top">
                        <%#((EPiServer.Core.PageData)Container.DataItem).Name %>
                    </a>
                    <p style="font-size:0.9em;"><%#((AlloyDemoKit.Models.Pages.SitePageData)Container.DataItem).MetaDescription %></p>
                    <asp:Literal ID="CheckBoxLiteral" runat="server" />
                    <hr />
                </ItemTemplate>
            </EPiServer:PageList>
        </div>
         <div style="padding-top:10px; font-size:0.8em;">
            <asp:Label ID="ReplaceLabel" Text="Replace term with" runat="server" />
        </div>
        <div style="float:left;">
            <asp:TextBox ID="ReplaceTextBox" runat="server" />
        </div>
         <div style="float:left;">
            <asp:Button ID="ReplaceButton" runat="server" Width="100px" Height="30px" CssClass="btn btn-primary" Text="Replace" OnClick="ReplaceButton_Click" />
        </div>
        <div>
            <asp:Literal ID="ResultsLiteral" runat="server" />
        </div>
   </asp:Content>
