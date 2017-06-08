define([
    // Dojo
    "dojo",
    "dojo/_base/declare",
    "dojo/_base/lang",
    "dojo/html",
    "dojo/on",
    "dojo/topic",
    // Dijit
    "dijit/_TemplatedMixin",
    "dijit/_Widget",
    // CMS
    "epi/dependency",
    "epi/username",
    "epi-cms/ApplicationSettings",
    'xstyle/css!./styles.css'
], function (
    // Dojo
    dojo,
    declare,
    lang,
    html,
    on,
    topic,
    // Dijit
    _TemplatedMixin,
    _Widget,
    // CMS
    dependency,
    username,
    appSettings
) {

        return declare("siteattention/components/SiteAttentionWidget", [_Widget, _TemplatedMixin], {
            // summary: Integration of SiteAttention in EPiServer.

            templateString: '<div id="siteattention_area">\
                            <div data-dojo-attach-point="contentName2" id="SAPL"></div>\
                        </div>',

            _unwatchHandle: null,

            _innerUnwatchHandle: null,

            postCreate: function () {
                
                if (!EPiServerSiteAttentionData.subscriptionActive) {
                    topic.subscribe("siteattention/modelchanged", lang.hitch(this,"_onModelChanged"));
                    EPiServerSiteAttentionData.subscriptionActive = true;
                };
            },

            postMixInProperties: function () {

                var registry = dependency.resolve("epi.storeregistry");
                if (!this.store) {
                    this.store = registry.get("siteattention.siteattentiondata");
                }
                if (!this.metadatastore) {
                    this.metadatastore = registry.get("siteattention.siteattentionmetadata");
                }
            },

            // _renderUserSupportInfoOnWidgets: function () {
            //     dojo.when(this.metadatastore.query(), function (metaData) {
            //         //console.info('Loading SA meta data and render support info on widgets')

            //         var element = document.getElementById('siteattention/components/SiteAttentionWidget_0');
            //         if (element != null && metaData.uninitializedWidgetString != '') {
            //             element.innerHTML = '<div style="margin:10px;">' + metaData.uninitializedWidgetString + '</div>';
            //         }

            //         for (var i = 1; i < 20; i++) {
            //             var element = document.getElementById('siteattention/components/SiteAttentionWidget_' + i.toString());
            //             if (element != null) {
            //                 element.innerHTML = '<div style="margin:10px;">' + metaData.secondWidgetString + '</div>';
            //             }
            //         }

            //     });
            // },
            _loadPageDataAndSAScripts: function (pageInformation, properties) {
                dojo.when(this.store.query(pageInformation), function (siteAttentionData) {

                    // Fill SiteAttentionData
                    EPiServerSiteAttentionData.SiteAttentionSelectors = siteAttentionData.siteAttentionSelectors;
                    EPiServerSiteAttentionData.SiteAttentionUILanguage = siteAttentionData.siteAttentionUILanguage;
                    EPiServerSiteAttentionData.SiteAttentionPageExternalUrl = siteAttentionData.siteAttentionPageExternalUrl;

                    EPiServerSiteAttentionData.iid = siteAttentionData.siteAttentionIid;
                    EPiServerSiteAttentionData.licenseKey = siteAttentionData.siteAttentionLicenseKey;
                    EPiServerSiteAttentionData.PageInformation.externalUrl = siteAttentionData.siteAttentionPageExternalUrl;
                    EPiServerSiteAttentionData.PageInformation.uiLanguage = siteAttentionData.siteAttentionUILanguage;
                    EPiServerSiteAttentionData.PageInformation.username = (username.currentUsername || appSettings.userName);
                    EPiServerSiteAttentionData.onPageChange(pageInformation.pageName);
                });

            },

            _onModelChanged: function (model) {
                SiteAttentionEpiServerWatcher.updateBaseModel(model);

                EPiServerSiteAttentionData.siteAttentionCurrentContentModel = model;

                EPiServerSiteAttentionData.PageInformation =  {};
                EPiServerSiteAttentionData.PageInformation.pageName = model.contentData.properties.icontent_name;
                EPiServerSiteAttentionData.PageInformation.contentLink = model.contentData.contentLink;
                EPiServerSiteAttentionData.PageInformation.contentGuid = model.contentData.contentLink.split('_')[0];//model.contentData.contentId;
                EPiServerSiteAttentionData.PageInformation.languageId = model.contentData.currentLanguageBranch.languageId;
                EPiServerSiteAttentionData.PageInformation.pageTypeName = model.contentData.properties.pageTypeName;
                EPiServerSiteAttentionData.PageInformation.uiLanguage = EPiServerSiteAttentionData.PageInformation.uiLanguage || 'eng'; // Only a default value. Will be poulated when a call is made to the server
                EPiServerSiteAttentionData.PageInformation.externalUrl = EPiServerSiteAttentionData.PageInformation.externalUrl || null; // Will be poulated when a call is made to the server,
                EPiServerSiteAttentionData.PageInformation.published = model.contentData.status === 4; // if status = 4, the page is published


                // Only load once for each page
                if (EPiServerSiteAttentionData.currentPage != model.contentData.contentGuid ||
                    EPiServerSiteAttentionData.currentContentLink != model.contentData.contentLink) {
                    this._loadPageDataAndSAScripts(EPiServerSiteAttentionData.PageInformation, model.contentData.properties);
                    EPiServerSiteAttentionData.currentPage = model.contentData.contentGuid;
                    EPiServerSiteAttentionData.currentContentLink = model.contentData.contentLink;
                }

                // this._renderUserSupportInfoOnWidgets();
            }


        });
    });
