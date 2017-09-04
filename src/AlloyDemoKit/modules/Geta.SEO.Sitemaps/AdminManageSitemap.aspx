<%@ Page Language="C#" AutoEventWireup="False" CodeBehind="AdminManageSitemap.aspx.cs" EnableViewState="true" Inherits="Geta.SEO.Sitemaps.Modules.Geta.SEO.Sitemaps.AdminManageSitemap" %>

<%@ Register TagPrefix="EPiServerUI" Namespace="EPiServer.UI.WebControls" Assembly="EPiServer.UI" %>

<%@ Import Namespace="Geta.SEO.Sitemaps.Entities" %>

<asp:content contentplaceholderid="FullRegion" runat="server">
    <div class="epi-contentContainer epi-padding">
    <div class="epi-contentArea">
        <EPiServerUI:SystemPrefix id="SystemPrefixControl" runat="server" />
        <asp:ValidationSummary ID="ValidationSummary" runat="server" CssClass="EP-validationSummary" ForeColor="Black" />
        <%= System.Web.Helpers.AntiForgery.GetHtml() %>
    </div>
    <style type="text/css">
        a.add-button {
            color: black;
        }

        table.sitemaps th {
            padding: 4px;
        }

        table.sitemaps td {
            padding: 7px;
        }

            table.sitemaps td input[type=text] {
                width: 100%;
            }

            table.sitemaps td.sitemap-name input[type=text] {
                width: 50%;
            }

        div.help {
            padding-top: 20px;
            padding-bottom: 10px;
        }

        div.toolbar {
            padding-bottom: 10px;
            height: 30px;
        }

        div.bottom-text {
            padding-top: 15px;
        }

        span.nb-text {
            font-weight: bold;
        }
    </style>

    <div>List of sitemap configurations:</div>
    
    <div class="help">
        <div>
            <span class="nb-text">Host:</span>
            The host name to access the sitemap
        </div>
        <div>
            <span class="nb-text">Include alternate languages:</span>
            If your site targets users in many languages and you can provide Google with rel="alternate" hreflang="x". These attributes help Google serve the correct language or regional URL to searchers.
        </div>
        <div>
            <span class="nb-text">Path to include:</span>
            Sitemap will contain only pages from this virtual directory url. Separate multiple with ";".
        </div>
        <div>
            <span class="nb-text">Path to avoid:</span>
            Sitemap will not contain pages from this virtual directory url (works only if "Directory to include" left blank). Separate multiple with ";".
        </div>
        <div>
            <span class="nb-text">Root page ID:</span>
            Sitemap will contain entries for descendant pages of the specified page (-1 means root page).
        </div>
        <div>
            <span class="nb-text">Debug info:</span>
            Check this to include data about each page entry as an xml comment
        </div>
        <div>
            <span class="nb-text">Format:</span>
            Standard/Mobile/Commerce/Standard and commere
        </div>
    </div>
    
    <div class="toolbar">
        <asp:PlaceHolder runat="server" ID="phNewButton">
            <div class="epi-buttonDefault">
                <span class="epi-cmsButton">
                    <asp:Button ID="btnNew" runat="server" Text="New sitemap" OnClick="btnNew_Click" 
                                    CssClass="add-button epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Add">
                    </asp:Button>
                </span>
            </div>
        </asp:PlaceHolder>
    </div>

    <asp:ListView runat="server" ID="lvwSitemapData" ItemPlaceholderID="ItemPlaceHolder" DataKeyNames="Id"
                OnItemCommand="lvwSitemapData_ItemCommand" 
                OnItemUpdating="lvwSitemapData_ItemUpdating"
                OnItemInserting="lvwSitemapData_ItemInserting" 
                OnItemEditing="lvwSitemapData_ItemEditing"
                OnItemDeleting="lvwSitemapData_ItemDeleting"
                OnItemCanceling="lvwSitemapData_ItemCanceling"
                OnItemDataBound="lvwSitemapData_ItemDataBound">
        <LayoutTemplate >
            <table class="epi-default sitemaps">
                <tr>
                    <th>Host</th>
                    <th>Path to include</th>
                    <th>Path to avoid</th>
                    <th>Root page ID</th>
                    <th>Debug info</th>
                    <th>Format</th>
                    <th></th>
                </tr>
                <asp:PlaceHolder runat="server" ID="ItemPlaceHolder" />
            </table>
            <div class="bottom-text">
                <span class="nb-text">NB!</span> To generate the actual sitemaps please run the scheduled task "Generate xml sitemaps".
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <%# GetSiteUrl(CurrentSitemapData.SiteUrl) %><%# GetLanguage(CurrentSitemapData.Language) %><%# CurrentSitemapData.Host %>
                </td>
                <td><%# GetDirectoriesString(CurrentSitemapData.PathsToInclude) %></td>
                <td><%# GetDirectoriesString(CurrentSitemapData.PathsToAvoid) %></td>
                <td><%# CurrentSitemapData.RootPageId %></td>
                <td><%# CurrentSitemapData.IncludeDebugInfo %></td>
                <td><%# CurrentSitemapData.SitemapFormat %></td>
                
                <td>
                    <asp:LinkButton ID="btnEdit" CommandName="Edit" runat="server" Text="Edit" OnClientClick="aspnetForm.target ='_self';" />
                    <asp:LinkButton ID="btnDelete" CommandName="Delete" CommandArgument='<%# Eval("Id")%>' runat="server" Text="Delete" OnClientClick="aspnetForm.target ='_self';" />
                    <asp:LinkButton ID="btnView" CommandName="ViewSitemap" CommandArgument='<%# Eval("Id")%>' Visible='<%# Eval("Data") != null %>' runat="server" Text="View" OnClientClick="aspnetForm.target ='_blank';"/>
                </td>

            </tr>
        </ItemTemplate>
        <EditItemTemplate>
            <tr>
                <td class="sitemap-name">
                    <asp:Label runat="server" ID="lblHostUrl" Visible="False" />
                    <asp:DropDownList runat="server" ID="ddlHostUrls" Visible="False" />

                    <asp:TextBox runat="server" ID="txtHost" Text='<%# GetHostNameEditPart(CurrentSitemapData.Host) %>' /><%= SitemapHostPostfix %>
                    <asp:PlaceHolder runat="server" Visible="<%# ShowLanguageDropDown %>">
                        <br/>
                        Language: 
                        <asp:DropDownList ID="ddlLanguage" DataSource="<%# LanguageBranches %>" DataTextField="DisplayName" DataValueField="Language" runat="server" /><br/><br/>
                        Language fallback: <asp:CheckBox ID="cbEnableLanguageFallback" runat="server" Checked="<%# CurrentSitemapData.EnableLanguageFallback %>"/>
                    </asp:PlaceHolder>
                    <br/><br/>
                    Include alternate language pages:
                    <asp:CheckBox runat="server" ID="cbIncludeAlternateLanguagePages" Checked='<%# CurrentSitemapData.IncludeAlternateLanguagePages %>'/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtDirectoriesToInclude" Text='<%# GetDirectoriesString(CurrentSitemapData.PathsToInclude) %>' />
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtDirectoriesToAvoid" Text='<%# GetDirectoriesString(CurrentSitemapData.PathsToAvoid) %>' />
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtRootPageId" Text='<%# CurrentSitemapData.RootPageId %>' />
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="cbIncludeDebugInfo" Checked='<%# CurrentSitemapData.IncludeDebugInfo %>' />
                </td>
                <td>
                    <div>
                        <asp:RadioButton runat="server" ID="rbStandard" GroupName="grSitemapFormat" Text="Standard" Checked='<%# CurrentSitemapData.SitemapFormat == SitemapFormat.Standard %>' />
                    </div>
                    <div>
                        <asp:RadioButton runat="server" ID="rbMobile" GroupName="grSitemapFormat" Text="Mobile" Checked='<%# CurrentSitemapData.SitemapFormat == SitemapFormat.Mobile %>' />
                    </div>
                    <div>
                        <asp:RadioButton runat="server" ID="rbCommerce" GroupName="grSitemapFormat" Text="Commerce" Checked='<%# CurrentSitemapData.SitemapFormat == SitemapFormat.Commerce %>' />
                    </div>
                    <div>
                        <asp:RadioButton runat="server" ID="rbStandardAndCommerce" GroupName="grSitemapFormat" Text="Standard and commerce" Checked='<%# CurrentSitemapData.SitemapFormat == SitemapFormat.StandardAndCommerce %>' />
                    </div>
                </td>
                <td>
                    <asp:LinkButton ID="btnUpdate" CommandName="Update" CommandArgument='<%# CurrentSitemapData.Id %>' runat="server" Text="Update"></asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" CommandName="Cancel" runat="server" Text="Cancel"></asp:LinkButton>
                </td>
            </tr>
        </EditItemTemplate>
        <InsertItemTemplate>
            <tr>
                <td class="sitemap-name">
                    <asp:Label runat="server" ID="lblHostUrl" Visible="False" />
                    <asp:DropDownList runat="server" ID="ddlHostUrls" Visible="False" />

                    <asp:TextBox runat="server" ID="txtHost" /><%# SitemapHostPostfix %>
                    
                    <asp:PlaceHolder runat="server" Visible="<%# ShowLanguageDropDown %>">
                        <br/>
                        Language: 
                        <asp:DropDownList ID="ddlLanguage" DataSource="<%# LanguageBranches %>" DataTextField="DisplayName" DataValueField="Language" runat="server" /><br/><br/>
                        Language fallback: <asp:CheckBox ID="cbEnableLanguageFallback" runat="server" />
                    </asp:PlaceHolder>
                    <br/><br/>
                    Include alternate language pages:
                    <asp:CheckBox runat="server" ID="cbIncludeAlternateLanguagePages" Checked="false"/>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtDirectoriesToInclude" />
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtDirectoriesToAvoid" />
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtRootPageId" Text="-1" />
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="cbIncludeDebugInfo" />
                </td>
                <td>
                    <div>
                        <asp:RadioButton runat="server" ID="rbStandard" GroupName="grSitemapFormat" Text="Standard" />
                    </div>
                    <div>
                        <asp:RadioButton runat="server" ID="rbMobile" GroupName="grSitemapFormat" Text="Mobile" />
                    </div>
                    <div>
                        <asp:RadioButton runat="server" ID="rbCommerce" GroupName="grSitemapFormat" Text="Commerce" />
                    </div>
                    <div>
                        <asp:RadioButton runat="server" ID="rbStandardAndCommerce" GroupName="grSitemapFormat" Text="Standard and commerce" />
                    </div>
                </td>
                <td>
                    <asp:LinkButton ID="btnInsert" CommandName="Insert" runat="server" Text="Save"></asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" CommandName="Cancel" runat="server" Text="Cancel"></asp:LinkButton>
                </td>
            </tr>
        </InsertItemTemplate>
    </asp:ListView>
</div>
</asp:content>