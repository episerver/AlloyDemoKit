define([
// Dojo
    "dojo",
    "dojo/_base/declare",
    "dojo/_base/lang",
    "dojo/html",
    "dojo/on",

// Dijit
    "dijit/_TemplatedMixin",
    "dijit/_Widget",
// CMS
    "epi/dependency"

], function (
// Dojo
    dojo,
    declare,
    lang,
    html,
    on,

// Dijit
    _TemplatedMixin,
    _Widget,
// CMS
    dependency
) {

    return declare("siteattention/components/SiteAttentionWidget", [_Widget, _TemplatedMixin], {
        // summary: Integration of SiteAttention in EPiServer.

        templateString: '<div id="siteattention_area">\
                            <div data-dojo-attach-point="contentName2"></div>\
                        </div>',

        _unwatchHandle: null,

        _innerUnwatchHandle: null,

        postCreate: function () {
            if (!EPiServerSiteAttentionData.subscriptionActive) {
                //console.info('subscribe');
                this.subscribe("siteattention/modelchanged", "_onModelChanged");
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

        _renderUserSupportInfoOnWidgets: function () {
            dojo.when(this.metadatastore.query(), function (metaData) {
                //console.info('Loading SA meta data and render support info on widgets')

                var element = document.getElementById('siteattention/components/SiteAttentionWidget_0');
                if (element != null && metaData.uninitializedWidgetString != '') {
                    element.innerHTML = '<div style="margin:10px;">' + metaData.uninitializedWidgetString + '</div>';
                }

                for (var i = 1; i < 20; i++) {
                    var element = document.getElementById('siteattention/components/SiteAttentionWidget_' + i.toString());
                    if (element != null) {
                        element.innerHTML = '<div style="margin:10px;">' + metaData.secondWidgetString + '</div>';
                    }
                }

            });
        },
        _loadPageDataAndSAScripts: function (pageInformation, properties) {
            dojo.when(this.store.query(pageInformation), function (siteAttentionData) {
                //console.info('Loading SA data')

                // Fill SiteAttentionData
                SiteAttentionSelectors = siteAttentionData.siteAttentionSelectors;
                SiteAttentionUILanguage = siteAttentionData.siteAttentionUILanguage;
                SiteAttentionPageExternalUrl = siteAttentionData.siteAttentionPageExternalUrl;

                EPiServerSiteAttentionData.licenseKey = siteAttentionData.siteAttentionLicenseKey;
                EPiServerSiteAttentionData.PageInformation.externalUrl = siteAttentionData.siteAttentionPageExternalUrl;
                EPiServerSiteAttentionData.PageInformation.uiLanguage = siteAttentionData.siteAttentionUILanguage;

                // Create the base content 
                EPiServerSiteAttentionData.fields = {};
                EPiServerSiteAttentionData.properties = [];

                // Clear current events
                EPiServerSiteAttentionData.clearHandlers();

                // Create the fields
                for (var key in siteAttentionData.siteAttentionSelectors) {
                    var selector = siteAttentionData.siteAttentionSelectors[key].selector;
                    var contentId = siteAttentionData.siteAttentionSelectors[key].contentId;
                    var wrapperTag = siteAttentionData.siteAttentionSelectors[key].wrapperTag;

                    if (EPiServerSiteAttentionData.properties[contentId] == null) {
                        if (properties[contentId] != null) {
                            EPiServerSiteAttentionData.properties[contentId] = properties[contentId].toString();
                        }
                        else {
                            EPiServerSiteAttentionData.properties[contentId] = '';
                        }
                    }

                    EPiServerSiteAttentionData.fields[selector] = {
                        selector: selector,
                        contentId: contentId,
                        wrapperTag: wrapperTag,
                        focus: function () {
                            //console.info(' focus("' + this.contentId + '")');
                            EPiServerSiteAttentionData.focus(this.contentId);
                        },
                        onContentChange: new function () {
                            this.selector = selector;
                            this.contentId = contentId;
                            this.add = function (func) {
                                //console.info('... add ' + this.selector);
                                EPiServerSiteAttentionData.onContentChange.add(func, this.selector, this.contentId);
                            }
                        },
                        getHtml: function () {
                            //console.info('getHtml(): this.contentId:' + this.contentId);
                            var html = '';
                            if (EPiServerSiteAttentionData != null && EPiServerSiteAttentionData.properties[this.contentId] != undefined
                                && EPiServerSiteAttentionData.properties[this.contentId] != null) {
                                html = EPiServerSiteAttentionData.properties[this.contentId];
                            }
                            //console.info('html: ' + html);
                            if (this.wrapperTag != '') {
                                html = '<' + this.wrapperTag + '>' + html + '</' + this.wrapperTag + '>';
                            }

                            return html;
                        }
                    };
                }


                // Find the Widget tag and the heading tag
                EPiServerSiteAttentionData.siteAttentionWidgetTag = document.getElementById('siteattention/components/SiteAttentionWidget_0');
                if (EPiServerSiteAttentionData.siteAttentionWidgetTag == null) {
                    // Check for alternative id
                    EPiServerSiteAttentionData.siteAttentionWidgetTag = document.getElementById('siteattention-widget-content');
                }

                var spanCandidates = document.getElementsByTagName("span");
                for (var index in spanCandidates) {
                    if (EPiServerSiteAttentionData.siteAttentionHeadingTag == null &&
                                    spanCandidates[index].innerHTML != null &&
                                    spanCandidates[index].innerHTML.indexOf('SiteAttention') == 0) {
                        EPiServerSiteAttentionData.siteAttentionHeadingTag = spanCandidates[index];
                    }
                }


                var topCandidateTag = null;
                if (EPiServerSiteAttentionData.siteAttentionWidgetTag != null) {
                    topCandidateTag = EPiServerSiteAttentionData.siteAttentionWidgetTag;
                    while (topCandidateTag.id.indexOf('epi_shell_widget_layout') != 0 && topCandidateTag.parentElement != null) {
                        topCandidateTag = topCandidateTag.parentElement;
                    }
                }

                if (topCandidateTag != null && topCandidateTag.id.indexOf('epi_shell_widget_layout') == 0) {
                    EPiServerSiteAttentionData.siteAttentionHeadingTag = EPiServerSiteAttentionData._findLabelElement(topCandidateTag);
                }


                // Only load SiteAttention once
                if (!EPiServerSiteAttentionData.siteAttentionLoaded) {
                    var siteAttention = document.createElement('script');
                    siteAttention.type = 'text/javascript';
                    siteAttention.async = true;
                    siteAttention.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'plugin.siteattention.com/?' + EPiServerSiteAttentionData.licenseKey + '&display_language=' + EPiServerSiteAttentionData.PageInformation.uiLanguage;
                    var s = document.getElementsByTagName('script')[0];
                    s.parentNode.insertBefore(siteAttention, s);

                    EPiServerSiteAttentionData.siteAttentionLoaded = true;
                }

                EPiServerSiteAttentionData.onPageChange.raise(pageInformation.pageName);
            });

        },

        _onModelChanged: function (model) {

            EPiServerSiteAttentionData.siteAttentionCurrentContentModel = model;
            EPiServerSiteAttentionData.PageInformation = {
                'pageName': model.contentData.properties.icontent_name,
                'contentLink': model.contentData.contentLink,
                'contentGuid': model.contentData.contentGuid,
                'languageId': model.contentData.currentLanguageBranch.languageId,
                'pageTypeName': model.contentData.properties.pageTypeName,
                'uiLanguage': 'eng', // Only a default value. Will be poulated when a call is made to the server
                'externalUrl': null // Will be poulated when a call is made to the server
            };

            // Only load once for each page
            if (EPiServerSiteAttentionData.currentPage != model.contentData.contentGuid ||
                EPiServerSiteAttentionData.currentContentLink != model.contentData.contentLink) {
                this._loadPageDataAndSAScripts(EPiServerSiteAttentionData.PageInformation, model.contentData.properties);
                EPiServerSiteAttentionData.currentPage = model.contentData.contentGuid;
                EPiServerSiteAttentionData.currentContentLink = model.contentData.contentLink;
            }

            this._renderUserSupportInfoOnWidgets();
        }


    });
});
