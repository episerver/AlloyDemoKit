<%@ Page Language="c#" Codebehind="SiteAttentionPlugIn.aspx.cs" AutoEventWireup="true" Inherits="EPiServer.modules.SiteAttentionModule.SiteAttentionPlugIn, SiteAttentionModule"  Title="SiteAttentionPlugIn" %>
<%@ Import Namespace="EPiServer.modules.SiteAttentionModule.Data" %>
<asp:Content ContentPlaceHolderID="FullRegion" runat="server">

<script type="text/javascript">
    (function (exports) { function Promise() { this._callbacks = [] } Promise.prototype.then = function (func, context) { var p; if (this._isdone) { p = func.apply(context, this.result) } else { p = new Promise(); this._callbacks.push(function () { var res = func.apply(context, arguments); if (res && typeof res.then === 'function') res.then(p.done, p) }) } return p }; Promise.prototype.done = function () { this.result = arguments; this._isdone = true; for (var i = 0; i < this._callbacks.length; i++) { this._callbacks[i].apply(null, arguments) } this._callbacks = [] }; function join(promises) { var p = new Promise(); var results = []; if (!promises || !promises.length) { p.done(results); return p } var numdone = 0; var total = promises.length; function notifier(i) { return function () { numdone += 1; results[i] = Array.prototype.slice.call(arguments); if (numdone === total) { p.done(results) } } } for (var i = 0; i < total; i++) { promises[i].then(notifier(i)) } return p } function chain(funcs, args) { var p = new Promise(); if (funcs.length === 0) { p.done.apply(p, args) } else { funcs[0].apply(null, args).then(function () { funcs.splice(0, 1); chain(funcs, arguments).then(function () { p.done.apply(p, arguments) }) }) } return p } function ajax(method, url, data, headers) { let p = new Promise(), xhr, payload; if (typeof url === 'object') { headers = data; data = url; url = promise.url } let i = url.match(/\/\/(.+?)\//), cors = i && (i[1] ? i[1] != location.host : false); try { xhr = _xhr(cors); xhr.onprogress = function () { } } catch (e) { p.done(promise.ENOXHR, e); return p } data = typeof data === 'undefined' ? promise.data : data; headers = typeof headers === 'undefined' ? promise.headers : headers; for (let d in promise.data) { if (promise.data.hasOwnProperty(d)) { data[d] = promise.data[d] } } payload = _encode(data); if (method === 'GET' && payload) { url += '?' + payload; payload = null } xhr.open(method, url); let content_type = promise.isjson ? 'application/json' : 'application/x-www-form-urlencoded'; for (let h in headers) { if (headers.hasOwnProperty(h)) { if (h.toLowerCase() === 'content-type') content_type = headers[h]; else xhr.setRequestHeader(h, headers[h]) } } xhr.setRequestHeader('Content-type', content_type); function onTimeout() { xhr.abort(); p.done(promise.ETIMEOUT, "", xhr) } let timeout = promise.ajaxTimeout; if (timeout) { var tid = setTimeout(onTimeout, timeout) } xhr.onreadystatechange = function () { if (timeout) { clearTimeout(tid) } if (xhr.readyState === 4) { let response = xhr.responseText, err = (!xhr.status || (xhr.status < 200 || xhr.status >= 300) && xhr.status !== 304); p.done(err, response, xhr) } }; xhr.send(payload); return p } function _xhr(cors) { var xhr; if (window.XMLHttpRequest) { xhr = new XMLHttpRequest() } else if (window.ActiveXObject) { try { xhr = new ActiveXObject("Msxml2.XMLHTTP") } catch (e) { xhr = new ActiveXObject("Microsoft.XMLHTTP") } } if (cors && !('withCredentials' in xhr) && window.XDomainRequest) { xhr = new XDomainRequest() } return xhr } function _ajaxer(method) { return function (url, data, headers) { return ajax(method, url, data, headers) } } function _encode(data) { var payload = ""; if (promise.isjson && typeof data === 'object') { payload = JSON.stringify(data) } else if (typeof data === "string") { payload = data } else { var e = encodeURIComponent; var params = []; for (var k in data) { if (data.hasOwnProperty(k)) { params.push(e(k) + '=' + e(data[k])) } } payload = params.join('&') } return payload } var promise = { Promise: Promise, join: join, chain: chain, ajax: ajax, get: _ajaxer('GET'), post: _ajaxer('POST'), put: _ajaxer('PUT'), del: _ajaxer('DELETE'), ENOXHR: 1, ETIMEOUT: 2, ajaxTimeout: 0, url: undefined, data: {}, headers: {}, isjson: false, }; promise.json = (function () { promise.isjson = true; return _ajaxer('POST') })(); if (typeof define === 'function' && define.amd) { define(function () { return promise }) } else { exports.promise = promise } })(this)
</script>
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function (event) {
        
        window.lockedStatus = '<%=Locked%>';
        window.antiToken = '<%=AntiForgeryToken%>';
        window.cmsPath = '<%=CmsPath%>';

        if (window.lockedStatus.toLocaleLowerCase() === 'true') {
            try {
                document.getElementById("btnSaveInstanceName").disabled = true;
                document.getElementById('tbInstanceName').disabled = true;
                document.getElementById('tbInstanceId').disabled = true;
                document.getElementById('btnSaveIid').disabled = true;
            } catch (ex) {

            }
        }

        var ctr = document.getElementById("tbLicenseKey");
        if (ctr) {
            var licenseKey = document.getElementById("tbLicenseKey").value;
            if (licenseKey) {

                // get infromation of this license key
                promise.post('https://api.siteattention.com/' + licenseKey,
                    { "func": "sync" },
                    { "Content-type": "application/json", "X-SiteAttention": licenseKey }).then(
                    function (error, data, xhr) {
                        if (error) {
                            return;
                        }
                        var result = JSON.parse(data);
                        document.getElementById('td_name').innerHTML = result.api.first + " " + result.api.last;
                        document.getElementById('td_email').innerHTML = result.api.email;
                        document.getElementById('td_company').innerHTML = result.api.company;
                        document.getElementById('td_license').innerHTML = result.api.key;
                        document.getElementById('td_pages').innerHTML = result.api.docs_total + " / " + result.api.docs_limit;
                        document.getElementById('td_updated').innerHTML = result.api.upgraded;
                        document.getElementById('td_expires').innerHTML = result.api.expires;
                    });

                // get name of instance for this license key
                if (!document.getElementById('tbInstanceName').value) {
                    promise.post('https://api.siteattention.com/' + licenseKey,
                        { "func": "instance" },
                        { "Content-type": "application/json", "X-SiteAttention": licenseKey }).then(
                        function (error, data, xhr) {
                            if (error) {
                                return;
                            }
                            var result = JSON.parse(data);

                            document.getElementById('tbLicenseKey').value = licenseKey;
                            document.getElementById('tbInstanceId').value = result.instance.iid;
                            document.getElementById('tbInstanceName').value = result.instance.name;

                            // save name into local db
                            promise
                                .post(getServiceUrl(),
                                { "licenseKey": licenseKey, "instanceName": result.instance.name, "iid": result.instance.iid, "locked": window.lockedStatus },
                                { "X-EPiContentLanguage": "en", "X-Requested-With": "XMLHttpRequest", "X-EpiRestAntiForgeryToken": window.antiToken, "Content-type": "application/json" }).then(
                                function (error, data, xhr) {
                                    if (error) {
                                        return;
                                    }
                                }
                                );

                        });
                }
            }
        }
    });

    // save instance name into SA server and local db
    function updateIntanceName() {
        var licenseKey = document.getElementById("tbLicenseKey").value;
        var iid = document.getElementById("tbInstanceId").value;
        var newName = document.getElementById("tbInstanceName").value;
        if (licenseKey && iid && newName) {
            // save into SA server
            promise.post('https://api.siteattention.com/' + licenseKey,
                { "func": "iname", "iid": iid, "name": newName },
                { "Content-type": "application/json", "X-SiteAttention": licenseKey }).then(
                function (error, data, xhr) {
                    if (error) {
                        return;
                    }

                    // save into local server
                    promise
                        .post(getServiceUrl(),
                        { "licenseKey": licenseKey, "instanceName": newName, "iid": iid, "locked": window.lockedStatus },
                        { "X-EPiContentLanguage": "en", "X-Requested-With": "XMLHttpRequest", "X-EpiRestAntiForgeryToken": window.antiToken, "Content-type": "application/json" }).then(
                        function (error, data, xhr) {
                            if (error) {
                                alert('ERROR : update has been failed');
                                return;
                            }
                            alert('Saved');
                        }
                        );

                });
        }
    }

    function getServiceUrl() {
        var serviceUrl = window.location.protocol +
            '//' +
            window.location.host +
            '/' +
            window.cmsPath +
            '/siteattentionmodule/Stores/siteattentiondata/%7Bid%7D';
        return serviceUrl;

    }
</script>
    
<div class="epi-contentContainer epi-padding">
<div class="epi-contentArea">
    <h1 class="EP-prefix"><EPiServer:Translate runat="server" LocalizedText="/admin/siteattention/heading" /></h1>
    <p><EPiServer:Translate runat="server" LocalizedText="/admin/siteattention/description" /></p>
</div>
<div class="epi-formArea">
<asp:Panel id="panelPageTypes" runat="server" Visible="true">
    <div class="epi-buttonDefault">
        <span class="epi-cmsButton">
            <asp:Button id="btnLicenseInfo" runat="server" cssclass="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-File" OnClick="btnLicenseInfo_Click"  Text="<%$ Resources: EPiServer, admin.siteattention.licenseinfobutton %>" />
        </span>
        <span class="epi-cmsButton">
            <asp:Button id="btnGenericSettings" runat="server" cssclass="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-File" OnClick="btnGenericSettings_Click"  Text="<%$ Resources: EPiServer, admin.siteattention.genericsettingsbutton %>" />
        </span>
    </div>


    <asp:Repeater id="repPageTypes" runat="server">
        <HeaderTemplate>
            <table class="epi-default " cellspacing="0" border="0" style="border-style: none; border-collapse: collapse;">
            <tr>
                <th scope="col"><EPiServer:Translate runat="server" LocalizedText="/admin/siteattention/nameheader" /></th>
                <th scope="col"><EPiServer:Translate runat="server" class="aligncentermiddle" LocalizedText="/admin/siteattention/customheader" /></th>
                <th scope="col"><EPiServer:Translate ID="Translate1" runat="server" LocalizedText="/admin/siteattention/descriptionheader" /></th>
            </tr>

        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td class="nowrap">

                        
                    <asp:LinkButton id="btnName" runat="server" OnCommand='btnPageType_Click' CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>' >
                        <%# HttpUtility.HtmlEncode(DataBinder.Eval(Container.DataItem, "LocalizedName   ").ToString())%></asp:LinkButton></td>
                <td  class="aligncentermiddle"><%# ((bool)DataBinder.Eval(Container.DataItem, "Custom")) ? "*" : "" %></td>
                <td><%# HttpUtility.HtmlEncode(DataBinder.Eval(Container.DataItem, "Description").ToString()) %></td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
</asp:Panel>

<asp:Panel id="panelGenericSettings" runat="server" Visible="False">
    <div class="epi-formArea">
        <div class="epi-size25 epi-paddingVertical-small">
            <div>
                <asp:Label AssociatedControlId="tbSEOUrl" runat="server" Text="<%$ Resources: EPiServer, admin.siteattention.seourlproperties %>"></asp:Label>
                <asp:TextBox id="tbSEOUrl" runat="server" cssclass="episize400" value=""></asp:TextBox>
            </div>
            <div>
                <asp:Label AssociatedControlId="tbSEOTitles" runat="server" Text="<%$ Resources: EPiServer, admin.siteattention.seotitleproperties %>"></asp:Label>
                <asp:TextBox id="tbSEOTitles" runat="server" cssclass="episize400" value=""></asp:TextBox>            
            </div>
            <div>
                <asp:Label AssociatedControlId="tbSEODescription" runat="server" Text="<%$ Resources: EPiServer, admin.siteattention.seometadescriptionproperties %>"></asp:Label>
                <asp:TextBox id="tbSEODescription" runat="server" cssclass="episize400" value=""></asp:TextBox>
            </div>
           <%-- <div>
                <asp:Label AssociatedControlId="tbSEOKeywords" runat="server" Text="<%$ Resources: EPiServer, admin.siteattention.seokeywordsproperties %>"></asp:Label>
                <asp:TextBox id="tbSEOKeywords" runat="server" cssclass="episize300" value=""></asp:TextBox>
            </div>--%>
            <%--<div>
                <asp:Label AssociatedControlId="tbSEOContent" runat="server" Text="<%$ Resources: EPiServer, admin.siteattention.seocontentproperties %>"></asp:Label>
                <asp:TextBox id="tbSEOContent" runat="server" cssclass="episize300" value=""></asp:TextBox>
            </div>--%>
            <div>
                <asp:Label AssociatedControlId="tbSEORichContent" runat="server" Text="<%$ Resources: EPiServer, admin.siteattention.seorichcontentproperties %>"></asp:Label>
                <asp:TextBox id="tbSEORichContent" runat="server" cssclass="episize400" value="" TextMode="MultiLine" ></asp:TextBox>
            </div>
            <%--<div>
                <asp:Label AssociatedControlId="tbSEOHeaderH1" runat="server" Text="<%$ Resources: EPiServer, admin.siteattention.seoheaderh1properties %>"></asp:Label>
                <asp:TextBox id="tbSEOHeaderH1" runat="server" cssclass="episize300" value=""></asp:TextBox>
            </div>
            <div>
                <asp:Label AssociatedControlId="tbSEOHeaderH2" runat="server" Text="<%$ Resources: EPiServer, admin.siteattention.seoheaderh2properties %>"></asp:Label>
                <asp:TextBox id="tbSEOHeaderH2" runat="server" cssclass="episize300" value=""></asp:TextBox>
            </div>
            <div>
                <asp:Label AssociatedControlId="tbSEOHeaderH3" runat="server" Text="<%$ Resources: EPiServer, admin.siteattention.seoheaderh3properties %>"></asp:Label>
                <asp:TextBox id="tbSEOHeaderH3" runat="server" cssclass="episize300" value=""></asp:TextBox>
            </div>--%>

                    

            <br />
            <div class="epi-buttonContainer">
                <span class="epi-cmsButton">
                    <asp:Button id="btnSaveGenericSettings" runat="server" cssclass="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Save" OnClick="btnGenericSettingsSave_Click" Text="<%$ Resources: EPiServer, button.save %>" />
                </span>
                <span class="epi-cmsButton">
                    <asp:Button id="btnCancelGenericSettings" runat="server" cssclass="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Cancel" OnClick="btnCancel_Click" Text="<%$ Resources: EPiServer, button.cancel %>" />
                </span>
            </div>
        </div>
    </div>
</asp:Panel>
                
<asp:Panel id="panelLicenseInfo" runat="server" Visible="False">
    <div class="epi-formArea">
        <div class="epi-size10 epi-paddingVertical-small">
           <%-- <div>
                <asp:Label AssociatedControlId="tbLicenseKey" runat="server" Text="<%$ Resources: EPiServer, admin.siteattention.licensekey %>"></asp:Label>
                <asp:TextBox id="tbLicenseKey" ClientIDMode="Static" runat="server" cssclass="episize300" value=""></asp:TextBox> 
                <asp:Label id="lblDemoButton" runat="server" cssClass="buttonright epi-cmsButton">
                    <asp:Button id="btnDemo" runat="server" cssclass="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-File" OnClick="btnDemoLicense_Click"  Text="<%$ Resources: EPiServer, admin.siteattention.demolicensebutton %>" />        
                </asp:Label>
                <asp:Label id="lblPremiumLink" runat="server" cssClass="buttonright">
                    <a href="https://www.siteattention.com/products/getsiteattention" target="_blank" ><asp:Label runat="server" Text="<%$ Resources: EPiServer, admin.siteattention.upgradetopremiumbutton %>"></asp:Label></a>          
                </asp:Label>
            </div>--%>
            <br />
            <div class="row">
                <div class="col col-half col-right-space">
                    <table class="table-infor block-border col__content">
                        <tr>
                            <td>Name: </td>
                            <td id="td_name"></td>
                        </tr>
                        <tr>
                            <td>Email: </td>
                            <td id="td_email"></td>
                        </tr>
                        <tr>
                            <td>Company: </td>
                            <td id="td_company"></td>
                        </tr>
                        <tr>
                            <td>License: </td>
                            <td id="td_license"></td>
                        </tr>
                        <tr>
                            <td>Pages: </td>
                            <td id="td_pages"></td>
                        </tr>
                        <tr>
                            <td>Updated: </td>
                            <td id="td_updated"></td>
                        </tr>
                        <tr>
                            <td>Expires: </td>
                            <td id="td_expires"></td>
                        </tr>
                    </table>
                </div>
                <div class="col col-half col-left-space">
                    <div class="block-border col__content site-infor">
                        <img class="site-logo" src="//cdn.shopify.com/s/files/1/1532/4977/t/5/assets/logo_80.png"/>
                        <a class="site-link" href="http://siteattention.com/">http://siteattention.com/</a>
                        <a class="site-link" href="mailto:info@siteattention.com">info@siteattention.com</a>
                    </div>
                </div>
            </div>
            <div class="row row-normal block-border row-padding">
                <div class="col col-normal col-40">
                    <div class="cell-row">
                        <span>License key</span>
                        <asp:Button id="btnSaveLicense" runat="server" CssClass="button-right" OnClick="btnSaveLicense_OnClick" Text="<%$ Resources: EPiServer, button.save %>" />
                    </div>
                    <asp:TextBox id="tbLicenseKey" ClientIDMode="Static" runat="server" CssClass="input-full-width" value=""></asp:TextBox> 
                </div>
                <div class="col col-normal col-40">
                    <div class="cell-row">
                        <span>Instance name</span>
                        <%--<asp:Button id="btnSaveInstanceName" ClientIDMode="Static" runat="server" CssClass="button-right" OnClientClick="updateIntanceName()" OnClick="btnSaveInstanceName_OnClick" Text="<%$ Resources: EPiServer, button.save %>" />--%>
                        <button id="btnSaveInstanceName" class="button-right" onclick="updateIntanceName()" type="button">Save</button>
                    </div>
                    <asp:TextBox id="tbInstanceName" ClientIDMode="Static" runat="server" CssClass="input-full-width" value=""></asp:TextBox>
                </div>
                <div class="col col-normal col-20">
                    <div class="cell-row">
                        <span>Instance ID</span>
                        <button id="btnSaveIid" class="button-right" onclick="updateIntanceName()" type="button">Save</button>
                    </div>
                    <asp:TextBox id="tbInstanceId" ClientIDMode="Static" runat="server" CssClass="input-full-width" value="" ></asp:TextBox>
                </div>
            </div>
                   
            <div class="epi-buttonContainer">
                <span class="epi-cmsButton">
                    <asp:Button id="btnCancelLicenseInfo" runat="server" cssclass="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Cancel" OnClick="btnCancel_Click" Text="Back" />
                </span>
            </div>
                    
        </div>
    </div>
</asp:Panel>
        
<asp:Panel id="panelPageType" runat="server" Visible="False">
    <div class="epi-formArea">
        <div class="checkboxarea">
            <h2><asp:Literal id="litName" runat="server" text="" /></h2>     
            <asp:CheckBox id="cbCustomPageTypeSettings" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbCustomPageTypeSettings_Click" Text="<%$ Resources: EPiServer, admin.siteattention.custompagetypesettings %>" ></asp:CheckBox>
        </div>
    </div>
                   
    <div class="epi-formArea">
        <asp:Panel id="panelPageTypeForm" runat="server" Visable="False">
            <div class="epi-paddingVertical-small">
                <div class="epi-contentArea">
                        
                    <p class="EP-systemInfo">
                        <asp:Label runat="server" Text="<%$ Resources: EPiServer, admin.siteattention.pagetypedescription %>"></asp:Label>
                    </p>
                </div>
                <div class="checkboxarea">       
                    <asp:CheckBox id="cbOnlySelectedBuiltIn" runat="server" AutoPostBack="True" Checked="False" OnCheckedChanged="cbOnlySelectedBuiltIn_Click" Text="<%$ Resources: EPiServer, admin.siteattention.onlyselectedbuiltin %>" ></asp:CheckBox>
                    <asp:CheckBox id="cbOnlyString" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbOnlyString_Click" Text="<%$ Resources: EPiServer, admin.siteattention.onlystring %>" ></asp:CheckBox>
                </div>
                <asp:Repeater id="repPageDefinitions" runat="server">
                    <HeaderTemplate>
                        <table class="epi-default " cellspacing="0" border="0" style="border-style: none; border-collapse: collapse;">
                        <tr>
                            <th scope="col"><EPiServer:Translate ID="Translate2" runat="server" LocalizedText="/admin/siteattention/nameheader" /></th>
                            <th scope="col" class=""><EPiServer:Translate ID="Translate3" runat="server" LocalizedText="/admin/siteattention/typeheader" /></th>
                            <th scope="col" class=""><EPiServer:Translate ID="Translate11" runat="server" LocalizedText="/admin/siteattention/contentfieldtype" /></th>
                        </tr>

                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="nowrap" title="<%# HttpUtility.HtmlEncode(DataBinder.Eval(Container.DataItem, "Description").ToString()) %>">                    
                                <%# (bool)DataBinder.Eval(Container.DataItem, "BuiltIn") ? "<i>" : ""%>
                                <%# HttpUtility.HtmlEncode(DataBinder.Eval(Container.DataItem, "PropertyName").ToString()) %></td>
                            <%# (bool)DataBinder.Eval(Container.DataItem, "BuiltIn") ? "</i>" : ""%>
                            <td class="checkboxpadding"><%# HttpUtility.HtmlEncode(DataBinder.Eval(Container.DataItem, "TypeName").ToString())%></td>
                            <td class="checkboxpadding">
                                <asp:DropDownList id="ddContentFieldType" DataValueField='<%# HttpUtility.HtmlEncode(DataBinder.Eval(Container.DataItem, "PropertyName").ToString()) %>' SelectedValue='<%# DataBinder.Eval(Container.DataItem, "PropertySettingType").ToString() %>' runat="server" >
                                    <asp:ListItem value="None" selected="True">
                                        -
                                    </asp:ListItem>
                                    <asp:ListItem value="Url" Text="<%$ Resources: EPiServer, admin.siteattention.dropurl %>" selected="False" />
                                    <asp:ListItem value="PageTitle" Text="<%$ Resources: EPiServer, admin.siteattention.droptitle %>" selected="False" />
                                    <asp:ListItem value="PageDescription" Text="<%$ Resources: EPiServer, admin.siteattention.dropdescription %>" selected="False" />
                                    <%--<asp:ListItem value="Keywords" Text="<%$ Resources: EPiServer, admin.siteattention.dropkeywords %>" selected="False" />
                                    <asp:ListItem value="PlainContent" Text="<%$ Resources: EPiServer, admin.siteattention.dropcontent %>" selected="False" />--%>
                                    <asp:ListItem value="RichContent" Text="<%$ Resources: EPiServer, admin.siteattention.droprichcontent %>" selected="False" />
                                    <%--<asp:ListItem value="HeaderH1" Text="<%$ Resources: EPiServer, admin.siteattention.dropheadersh1 %>" selected="False" />
                                    <asp:ListItem value="HeaderH2" Text="<%$ Resources: EPiServer, admin.siteattention.dropheadersh2 %>" selected="False" />
                                    <asp:ListItem value="HeaderH3" Text="<%$ Resources: EPiServer, admin.siteattention.dropheadersh3 %>" selected="False" />--%>

                                </asp:DropDownList>                    
                            </td>

                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </asp:Panel>
        <div class="epi-buttonContainer">                
            <asp:Label id="lblSavePageTypeSettings" runat="server" cssclass="epi-cmsButton">
                <asp:Button id="btnSavePageTypeSettings" runat="server" cssclass="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Save" OnClick="btnPageTypeSettingsSave_Click" Text="<%$ Resources: EPiServer, button.save %>" />
            </asp:Label>
            <span class="epi-cmsButton">
                <asp:Button id="btnCancelPageTypeSettings" runat="server" cssclass="epi-cmsButton-text epi-cmsButton-tools epi-cmsButton-Cancel" OnClick="btnCancel_Click" Text="<%$ Resources: EPiServer, button.cancel %>" />
            </span>
        </div>
    </div>
</asp:Panel>

</div>
</div>

</asp:Content>
