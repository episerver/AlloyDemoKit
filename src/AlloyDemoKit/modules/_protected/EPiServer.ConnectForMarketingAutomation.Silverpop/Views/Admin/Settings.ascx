<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="EPiServer.MarketingAutomationIntegration.Silverpop.Views.Silverpop.Admin.Settings" %>

<%@ Import Namespace="EPiServer.MarketingAutomationIntegration.Core" %>
<%@ Import Namespace="EPiServer.MarketingAutomationIntegration.Helpers" %>
<%@ Import Namespace="EPiServer.MarketingAutomationIntegration.Silverpop.Implementation" %>

<%@ Register Assembly="Episerver.UI" Namespace="EPiServer.UI.WebControls" TagPrefix="EPiServerUI" %>
<%@ Register Assembly="EPiServer.Shell" Namespace="EPiServer.Shell.Web.UI.WebControls" TagPrefix="sc" %>
<%@ Register Assembly="System.Web" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="System.Web" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>


<episerverui:refreshframe visible="False" id="frameUpdater" framename="AdminMenu" selectedtabname="AdminTab" runat="server" />

<div class="epi-contentArea">
    <h1 class="EP-prefix">
        <%= Translate("/episerver/silverpop/admin/displayname")%>
    </h1>

    <p class="EP-systemInfo">
        <%= Translate("/episerver/silverpop/admin/description")%>
    </p>

    <p runat="server" clientidmode="Static" class="EP-systemMessage" id="pStatusMessage" style="display: none">
        <%= Translate("/episerver/silverpop/admin/savesuccessfully") %>
    </p>
    <p runat="server" clientidmode="Static" class="EP-systemMessage" id="pErrorMessage" style="display: none">
    </p>
    <asp:ValidationSummary CssClass="EP-validationSummary" runat="server"/>
</div>


<asp:panel runat="server" id="pnlAllEditControlsForSettings">

    <EPiServerUI:TabStrip runat="server" ID="stripMain" GeneratesPostBack="False" TargetID="pnlTabs">
	    <EPiServerUI:Tab Text="Settings" runat="server" ID="tabSettings" />
	    <EPiServerUI:Tab Text="Tracking" runat="server" ID="tabTracking" />
        <EPiServerUI:Tab Text="Cache" runat="server" ID="tabCache" />
        <EPiServerUI:Tab Text="Mail" runat="server" ID="tabMail" />
    </EPiServerUI:TabStrip>

    <asp:Panel runat="server" ID="pnlTabs">
        <asp:Panel runat="server" CssClass="epi-padding" ID="pnlSettings">
            <div class="epi-formArea" id="divSettings" runat="server">
                <div class="epi-size25">
                    <div>
                        <asp:Label runat="server" AssociatedControlID="ddlEngagePodNumber"><%= Translate("/episerver/silverpop/admin/engagepodnumber") %></asp:Label>
                        <asp:DropDownList runat="server" id="ddlEngagePodNumber" ClientIDMode="Static" >
                            <asp:ListItem Text="Engage Pilot" Value="-1" />
                            <asp:ListItem Text="Engage Pod 0" Value="0" />
                            <asp:ListItem Text="Engage Pod 1" Value="1" />
                            <asp:ListItem Text="Engage Pod 2" Value="2" />
                            <asp:ListItem Text="Engage Pod 3" Value="3" />
                            <asp:ListItem Text="Engage Pod 4" Value="4" />
                            <asp:ListItem Text="Engage Pod 5" Value="5" />
                            <asp:ListItem Text="Engage Pod 6" Value="6" />
                            <asp:ListItem Text="Engage Pod 7" Value="7" />
                            <asp:ListItem Text="Engage Pod 8" Value="8" />
                            <asp:ListItem Text="Engage Pod 9" Value="9" />
                            <asp:ListItem Text="Engage Pod 10" Value="10" />
                            <asp:ListItem Text="Engage Pod 11" Value="11" />
                            <asp:ListItem Text="Engage Pod 12" Value="12" />
                            <asp:ListItem Text="Engage Pod 13" Value="13" />
                            <asp:ListItem Text="Engage Pod 14" Value="14" />
                            <asp:ListItem Text="Engage Pod 15" Value="15" />
                            <asp:ListItem Text="Engage Pod 16" Value="16" />
                            <asp:ListItem Text="Engage Pod 17" Value="17" />
                            <asp:ListItem Text="Engage Pod 18" Value="18" />
                            <asp:ListItem Text="Engage Pod 19" Value="19" />
                        </asp:DropDownList>
                    </div>

                    <div runat="server" visible="false">
                        <asp:Label runat="server" AssociatedControlID="txtClientId"><%= Translate("/episerver/silverpop/admin/clientid") %></asp:Label>
                        <asp:TextBox runat="server" ID="txtClientId" />
                    </div>
                    <div runat="server" visible="false">
                        <asp:Label runat="server" AssociatedControlID="txtClientSecret"><%= Translate("/episerver/silverpop/admin/clientsecret") %></asp:Label>
                        <asp:TextBox runat="server" ID="txtClientSecret" />
                    </div>
                    <div>
                        <asp:Label runat="server" AssociatedControlID="txtoAuthRefreshToken"><%= Translate("/episerver/silverpop/admin/refreshtoken") %></asp:Label>
                        <asp:TextBox runat="server" ID="txtoAuthRefreshToken" ClientIDMode="Static" />
                    </div>
                    <div>
                        <asp:Label runat="server" AssociatedControlID="txtCacheMinutes"><%= Translate("/episerver/silverpop/admin/cacheexiry") %></asp:Label>
                        <asp:TextBox runat="server" ID="txtCacheMinutes" ClientIDMode="Static" />
                    </div>
                    <div>
                        <asp:Label runat="server" AssociatedControlID="ddlTimeZone"><%= Translate("/episerver/silverpop/admin/timezone") %></asp:Label>
                        <select runat="server" id="ddlTimeZone"  ClientIDMode="Static" style="width: 240px;">
                                <option value="-12.00">(GMT -12:00) Eniwetok, Kwajalein</option>
                                <option value="-11.00">(GMT -11:00) Midway Island, Samoa</option>
                                <option value="-10.00">(GMT -10:00) Hawaii</option>
                                <option value="-9.00">(GMT -9:00) Alaska</option>
                                <option value="-8.00">(GMT -8:00) Pacific Time (US &amp; Canada)</option>
                                <option value="-7.00">(GMT -7:00) Mountain Time (US &amp; Canada)</option>
                                <option value="-6.00">(GMT -6:00) Central Time (US &amp; Canada), Mexico City</option>
                                <option value="-5.00">(GMT -5:00) Eastern Time (US &amp; Canada), Bogota, Lima</option>
                                <option value="-4.00">(GMT -4:00) Atlantic Time (Canada), Caracas, La Paz</option>
                                <option value="-3.50">(GMT -3:30) Newfoundland</option>
                                <option value="-3.00">(GMT -3:00) Brazil, Buenos Aires, Georgetown</option>
                                <option value="-2.00">(GMT -2:00) Mid-Atlantic</option>
                                <option value="-1.00">(GMT -1:00 hour) Azores, Cape Verde Islands</option>
                                <option value="0.00">(GMT) Western Europe Time, London, Lisbon, Casablanca</option>
                                <option value="1.00">(GMT +1:00 hour) Brussels, Copenhagen, Madrid, Paris</option>
                                <option value="2.00">(GMT +2:00) Kaliningrad, South Africa</option>
                                <option value="3.00">(GMT +3:00) Baghdad, Riyadh, Moscow, St. Petersburg</option>
                                <option value="3.50">(GMT +3:30) Tehran</option>
                                <option value="4.00">(GMT +4:00) Abu Dhabi, Muscat, Baku, Tbilisi</option>
                                <option value="4.50">(GMT +4:30) Kabul</option>
                                <option value="5.00">(GMT +5:00) Ekaterinburg, Islamabad, Karachi, Tashkent</option>
                                <option value="5.50">(GMT +5:30) Bombay, Calcutta, Madras, New Delhi</option>
                                <option value="5.75">(GMT +5:45) Kathmandu</option>
                                <option value="6.00">(GMT +6:00) Almaty, Dhaka, Colombo</option>
                                <option value="7.00">(GMT +7:00) Bangkok, Hanoi, Jakarta</option>
                                <option value="8.00">(GMT +8:00) Beijing, Perth, Singapore, Hong Kong</option>
                                <option value="9.00">(GMT +9:00) Tokyo, Seoul, Osaka, Sapporo, Yakutsk</option>
                                <option value="9.50">(GMT +9:30) Adelaide, Darwin</option>
                                <option value="10.00">(GMT +10:00) Eastern Australia, Guam, Vladivostok</option>
                                <option value="11.00">(GMT +11:00) Magadan, Solomon Islands, New Caledonia</option>
                                <option value="12.00">(GMT +12:00) Auckland, Wellington, Fiji, Kamchatka</option>
                        </select>

                        <EPiServerUI:ToolButton ID="btnAutoFetch" runat="server" type="button" Text="<%$ Resources: EPiServer, episerver.silverpop.admin.autofetch %>" ToolTip="<%$ Resources: EPiServer, episerver.silverpop.admin.autofetch %>" SkinID="Refresh" />
                        <span id="loadingIndicator" style="font-size: 20px;"></span>
                    </div>
                    <div>
                        <asp:Label runat="server" AssociatedControlID="txtContactListPrefix"><%= Translate("/episerver/silverpop/admin/contactlistprefix") %></asp:Label>
                        <asp:TextBox runat="server" ID="txtContactListPrefix" />
                    </div>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" CssClass="epi-padding" ID="pnlTracking">
            <asp:RadioButtonList id="rbScriptOption" runat="server"></asp:RadioButtonList>
            <br />
            <div class="epi-size25" id="divTrackingScripts" runat="server">
                <asp:TextBox runat="server" ID="txtTracking" Width="99%" TextMode="MultiLine" Rows="10" />
                <asp:CustomValidator runat="server" ID="cvTrackingCode" ControlToValidate="txtTracking" CssClass="error" ValidateEmptyText="true"
                    ClientValidationFunction="validateTrackingCode" OnServerValidate="ValidateTrackingCode" Display="None"></asp:CustomValidator>
                    
            </div>
            <br />
            <strong><%= Translate("/episerver/silverpop/admin/engagewebtrackingrequiredomain") %></strong>
            <br />
        </asp:Panel>

        <asp:Panel runat="server" CssClass="epi-padding" ID="pnlCache">
            <p>
                <strong><%= Translate("/episerver/silverpop/admin/note") %> </strong><%= Translate("/episerver/silverpop/admin/cacheupdatecantakesometime") %><br />
            </p>
            <p>
                <%= Translate("/episerver/silverpop/admin/thisserver") %> <strong><%= CacheService.CacheContents.CurrentServer %></strong><br />
                <%= Translate("/episerver/silverpop/admin/lastupdaterequest") %> <strong><%= CacheService.CacheContents.BroadcastRequest.BroadcastRequestedBy == null ? Translate("/episerver/silverpop/admin/nonecurrentlystored") : CacheService.CacheContents.BroadcastRequest.BroadcastRequestedBy + " " + Translate("/episerver/silverpop/admin/at") + " " + CacheService.CacheContents.BroadcastRequest.BroadcastRequestedAt.ToString()%></strong><br />
                <%= Translate("/episerver/silverpop/admin/lastbroadcast") %> <strong><%= CacheService.CacheContents.BroadcastRequest.BroadcastRequestedBy == null ? Translate("/episerver/silverpop/admin/nonecurrentlystored") : CacheService.CacheContents.BroadcastSentAt.ToString()%></strong>
            </p>
            <EPiServerUI:ToolButton EnableClientConfirm="false" ID="btnRefreshCache" runat="server" Text="<%$ Resources: EPiServer, episerver.silverpop.admin.refreshlist %>" ToolTip="<%$ Resources: EPiServer, episerver.silverpop.admin.refreshlisttooltip %>" SkinID="Refresh" OnClick="RefreshCacheKeys" />
            &nbsp;
            <EPiServerUI:ToolButton EnableClientConfirm="false" ID="btnRequestCacheUpdate" runat="server" Text="<%$ Resources: EPiServer, episerver.silverpop.admin.requestupdate %>" ToolTip="<%$ Resources: EPiServer, episerver.silverpop.admin.requestupdatetooltip %>" SkinID="Refresh" OnClick="RequestCacheUpdate" />
            &nbsp;
            <EPiServerUI:ToolButton EnableClientConfirm="true" ID="btnDirtyCacheContext" runat="server" Text="<%$ Resources: EPiServer, episerver.silverpop.admin.wipecache %>" ToolTip="<%$ Resources: EPiServer, episerver.silverpop.admin.wipecachetooltip %>" SkinID="Delete" OnClick="DirtyCacheContext" />
            <br />
            <br />
            <asp:GridView runat="server" ID="grdCacheServers" AutoGenerateColumns="false">
                <columns>
                    <asp:BoundField HeaderText="<%$ Resources: EPiServer, episerver.silverpop.admin.Server %>" DataField="Server" />
                    <asp:BoundField HeaderText="<%$ Resources: EPiServer, episerver.silverpop.admin.Responded %>" DataField="Created" />
                    <asp:BoundField HeaderText="<%$ Resources: EPiServer, episerver.silverpop.admin.Received %>" DataField="Received" />
                </columns>
            </asp:GridView>
            <br />
            <asp:GridView runat="server" ID="grdCache" AutoGenerateColumns="false">
                <columns>
                    <asp:TemplateField HeaderText="<%$ Resources: EPiServer, episerver.silverpop.admin.cachkey %>">
                        <ItemTemplate>
                            <%# Container.DataItem %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources: EPiServer, episerver.silverpop.admin.action %>">
                        <ItemTemplate>
                            <EPiServerUI:ToolButton EnableClientConfirm="false" ID="btnUpdateCache" runat="server" Text="<%$ Resources: EPiServer, episerver.silverpop.admin.updatenow %>" ToolTip="<%$ Resources: EPiServer, episerver.silverpop.admin.updatecachetooltip %>" SkinID="Refresh" OnClick="UpdateCacheKey" CommandArgument='<%# Container.DataItem %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </columns>
            </asp:GridView>
        </asp:Panel>
        <asp:Panel runat="server" CssClass="epi-padding" ID="pnlMail">
            <div class="epi-formArea" id="divMailSettings" runat="server">
                <div class="epi-size25">
                    <div>
                        <asp:Label runat="server" AssociatedControlID="txtFromName"><%= Translate("/episerver/silverpop/admin/fromname") %></asp:Label>
                        <asp:TextBox runat="server" ID="txtFromName" />
                    </div>
                    <div>
                        <asp:Label runat="server" AssociatedControlID="txtFromAddress"><%= Translate("/episerver/silverpop/admin/fromaddress") %></asp:Label>
                        <asp:TextBox runat="server" ID="txtFromAddress" />
                        <asp:CustomValidator runat="server" ID="cvFromAddress" ControlToValidate="txtFromAddress" CssClass="error" ValidateEmptyText="true"
                            ClientValidationFunction="validateEmailAddress" OnServerValidate="ValidateEmailAddress" Display="None"></asp:CustomValidator>
                    </div>
                    <div>
                        <asp:Label runat="server" AssociatedControlID="txtReplyToAddress"><%= Translate("/episerver/silverpop/admin/replytoaddress") %></asp:Label>
                        <asp:TextBox runat="server" ID="txtReplyToAddress" />
                        <asp:CustomValidator runat="server" ID="cvReplyAddress" ControlToValidate="txtReplyToAddress" CssClass="error" ValidateEmptyText="true"
                            ClientValidationFunction="validateEmailAddress" OnServerValidate="ValidateEmailAddress" Display="None"></asp:CustomValidator>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </asp:Panel>

    <div class="epi-buttonContainer">
        <EPiServerUI:ToolButton ID="btnSave" DisablePageLeaveCheck="true" OnClientClick="ShowSaveMessage();" OnClick="GoSave" runat="server" SkinID="Save" Text="<%$ Resources: EPiServer, button.save %>" ToolTip="<%$ Resources: EPiServer, button.save %>" />
    </div>
    <script type="text/javascript">

        function validateEmailAddress(event, args)
        {
            if (args.Value != "") {
                var regex = new RegExp("<%= EmailRegex %>");
                args.IsValid = regex.test(args.Value);
            }
        }

        function validateTrackingCode(event, args) {
            var container = "#<%= pnlTracking.ClientID %>";
            $("input:checked", container).each(function () {
                if (this.value === "CustomScripts" )
                {
                    args.IsValid = $.trim(args.Value) != "";
                }
            })
        }

        function ShowSaveMessage() {
            if (typeof (Page_ClientValidate) == 'function') {
                Page_ClientValidate();

                if (!Page_IsValid) {
                    $('#pStatusMessage').hide();
                }
            }
        }

        $(document).ready(function () {

            var $btnAutoFetchTimeZone = $('#<%= btnAutoFetch.ClientID %>'),
                $buttonBlock = $btnAutoFetchTimeZone.parent(".epi-cmsButton"),
                $pErrorMessage = $("#pErrorMessage"),
                $loadingIndicator = $("#loadingIndicator"),
                $pStatusMessage = $("#pStatusMessage"),
                handler;

            function FetchTimeZone() {
                /// <summary>Auto fetch user's configured time zone.</summary>

                $pErrorMessage.hide();
                $pStatusMessage.hide();

                var maxCacheMinutes = <%= MaxCacheMinutes %>;
                var cacheMinutes = $("#txtCacheMinutes").val();
                if (parseInt(cacheMinutes) != cacheMinutes
                    || cacheMinutes < 0
                    || cacheMinutes > maxCacheMinutes) {

                    $pErrorMessage.html('<%= Translate("/episerver/silverpop/admin/cacheminutesmustbegreaterthanorequaltozero") %>').show();
                    return;
                }
                   
                handler = setInterval(showLoadingIndicator, 500);
                $loadingIndicator.show();
                $buttonBlock.hide();
                $.getJSON('<%= ModuleHelper.ToResource(typeof(EPiServer.MarketingAutomationIntegration.Silverpop.Views.Silverpop.Admin.Settings), "TimeZone/GetTimeZone") %>',
                    {
                        apiMode: $("#ddlEngagePodNumber").val(),
                        refreshToken: $("#txtoAuthRefreshToken").val(),
                        cacheExpire: $("#txtCacheMinutes").val()
                    },

                    function (data) {
                        clearInterval(handler);
                        $loadingIndicator.hide();

                        if (data.IsError) {
                            $pErrorMessage.html(data.Message).show();
                            $buttonBlock.show();

                            return;
                        }

                        $("#ddlTimeZone").val(data.Value);  // switch the combobox selected value to autofetch timezone
                    }
                );
            }

            $btnAutoFetchTimeZone.bind('click', function (e) {
                FetchTimeZone();
                e.preventDefault();
            });

            function showLoadingIndicator() {
                /// <summary>Show loading indicator during fetching time zone from Silverpop</summary>

                var text = $loadingIndicator.html();
                text = text == "..." ? "" : text;
                $loadingIndicator.html(text + ".");
            };

            var container = "#<%= pnlTracking.ClientID %>";
            $("input:radio", container).click(function () {
                var useCustomScript = this.value === "CustomScripts";
                $("#<%= divTrackingScripts.ClientID %>", container).css("display", useCustomScript ? "" : "none");
            })

        });

    </script>

</asp:panel>
<%--pnlAllEditControlsForSettings--%>