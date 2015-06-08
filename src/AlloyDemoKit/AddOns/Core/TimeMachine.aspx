<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TimeMachine.aspx.cs" Inherits="EPiServer.Templates.Alloy.AddOns.Core.TimeMachine" %>

<asp:Content ContentPlaceHolderID="MainRegion" runat="server">
       
        <div style="padding-top:5px; float:left;">
           <episerver:inputdate runat="server" ID="InputDateBox" />
        </div>
            <br />
            <br />
        <div style="float:left;">
            <asp:Button ID="SearchButton" runat="server" Width="100px" Height="30px" CssClass="btn btn-primary" Text="Search" OnClick="SearchButton_Click" />
        </div>
      <br />
            <br />
    <br />
     <div>
            <asp:Literal ID="ResultsLiteral" runat="server" />
        </div>
         <div style="float:left;">
            <asp:Button ID="ReplaceButton" Enabled="false" runat="server" Width="100px" Height="30px" CssClass="btn btn-primary" Text="Revert Back" OnClick="ReplaceButton_Click" />
        </div>
        <div style="padding-top: 50px;">
            <asp:repeater runat="server" ID="PagedResults">
                <ItemTemplate>
                    <a href="<%#SiteUrl(Container.DataItem) %>" target="_top">
                        <%#((EPiServer.Core.IContent)Container.DataItem).Name %>
                    </a>
                    <hr />
                </ItemTemplate>
            </asp:repeater>
        </div>
   </asp:Content>
