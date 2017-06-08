/* The Command Provider*/
define([
    "dojo/Stateful",
    "epi/dependency",
    "dojo/_base/declare",
    "dojo/_base/lang",
    "dojo/topic",
    "dojo/_base/xhr",
    "epi/shell/XhrWrapper",
    "epi-cms/core/ContentReference",
    "epi/shell/command/_CommandProviderMixin"],

    function (Stateful, dependency, declare, lang, topic, xhr, XhrWrapper, ContentReference, _CommandProviderMixin) {
        return declare([_CommandProviderMixin], {

            _propertyEditedHandle: null,
            _someArray: null,

            someData: null,
            _xhrHandler: null,
            //  The current profile.
            _profile: null,

            constructor: function () {
                if (!this._xhrHandler) {
                    this._xhrHandler = new XhrWrapper();
                }
                this._profile = this._profile || dependency.resolve("epi.shell.Profile");
            },


            _refreshDataModel: function () {
                if (this._model.metadata) {
                    for (var propName in this._model.contentData.properties) {
                        if (this._model.contentData.properties.hasOwnProperty(propName)) {
                            this._refreshDataModelProperty(propName, this._model.contentData.properties[propName]);
                        }
                    }
                }

                // Because of updateDataModel only be called when the content context change,
                // so we need to watch content model change incase editor update property value.
                if (this._propertyEditedHandle) {
                    this._propertyEditedHandle.remove();
                }

                this._propertyEditedHandle = this._model.contentModel.watch(lang.hitch(this, function (name, oldValue, newValue) {
                    this._refreshDataModelProperty(name, newValue);
                }));
            },
            _findPropertyByName: function (name) {
                return function (pro) {
                    return pro.name.toLowerCase() === name.toLowerCase();
                };
            },

            _startsWith: function (inputString, searchString, position) {
                position = position || 0;
                return inputString.indexOf(searchString, position) === position;
            },
            _evaluateForContentArea: function (name, value, pro) {
                var reference = ContentReference.toContentReference(this._model.contentLink);
                var postData = {
                    propertyName: name,
                    newPropertyValue: JSON.stringify(value),
                    id: reference.toString(),
                    epslanguage: this._profile ? this._profile.contentLanguage : ""
                    // The default model binder in MVC needs the id to be part of the posted data.
                };

                var url = "/SaPropertyRender/Render/";
                this._xhrHandler.xhrPost({
                    url: url,
                    handleAs: "json",
                    content: postData
                }).then(function (data) {
                    SiteAttentionEpiServerWatcher.updateValue(name, !data.value ? '' : data.value, '');
                },
                    function (err) {    
                    });
            },

            _evaluateForRouteSegment: function (name, value, pro) {
                var pageStatusIsPublished = this._model.contentData.status === 4;
                var publicUrl = '';
                if (this._model.contentData.publicUrl === '/') {
                    publicUrl = this._model.contentData.publicUrl + "/" + value;
                } else {
                    var segmentsUrl = this._model.contentData.publicUrl.split('/');
                    var lastSegment = '';
                    for (var i = segmentsUrl.length - 1; i--; i >= 0) {
                        if (segmentsUrl[i] !== '') {
                            lastSegment = segmentsUrl[i];
                            break;
                        }
                    }
                    var newUrl = this._model.contentData.publicUrl.replace(lastSegment, value);
                    publicUrl = window.location.protocol +
                        '//' +
                        window.location.host +
                        (this._startsWith(newUrl, "/") ? "" : "/") +
                        newUrl;
                }
                SiteAttentionEpiServerWatcher.updateValue(name, publicUrl, '');
                // POST to SA after the page's url changed
                if (window.SA) {
                    SA.lib.promise.post('https://api.siteattention.com/' + EPiServerSiteAttentionData.licenseKey,
                        {
                            'func': 'publish',
                            'published': pageStatusIsPublished.toString().toLocaleLowerCase(),
                            'url': publicUrl,
                            'pid': EPiServerSiteAttentionData.PageInformation.contentGuid,
                            'lang': EPiServerSiteAttentionData.PageInformation.languageId,
                            'iid': EPiServerSiteAttentionData.iid
                        },
                        { "Content-type": "application/json", "X-SiteAttention": EPiServerSiteAttentionData.licenseKey }).then(
                        function (error, data, xhr) {
                        });
                }
            },

            _evaluateForOtherProperty: function (name, value, pro) {
                this._xhrHandler.xhrGet({
                    url: this._model.contentData.editablePreviewUrl
                }).then(function (data) {
                    var doc = document.implementation.createHTMLDocument('tmp');
                    doc.documentElement.innerHTML = data;
                    if (pro) {
                        if (name === 'icontent_name') {
                            var tag = doc.querySelector('[data-epi-property-name="' + "PageName" + '"]');
                        } else {
                            var tag = doc.querySelector('[data-epi-property-name="' + pro.name + '"]');
                        }
                        if (tag) {
                            SiteAttentionEpiServerWatcher.updateValue(name,
                                value,
                                tag.outerHTML);
                        } else {
                            SiteAttentionEpiServerWatcher.updateValue(name, value, '');
                        }
                    } 
                });
            },
            _refreshDataModelProperty: function (name, value) {
                if (name) {
                    var pro = this._model.metadata.properties.find(this._findPropertyByName(name));
                    if (pro && (pro.modelType === "EPiServer.Core.ContentArea")) {
                        this._evaluateForOtherProperty(name, value, pro);

                    } else if (pro && (name === 'iroutable_routesegment')) {
                        this._evaluateForRouteSegment(name, value, pro);

                    } else {
                        this._evaluateForOtherProperty(name, value, pro);
                    }
                }
            },

            updateCommandModel: function (model) {
                // summary:
                //      Updates the model for the commands.
                // tags:
                //      public

                this.inherited(arguments);


                this._model = model;
                this._refreshDataModel();

                // Keep track also of widgets change becaus the model watch will not cover all changes
                // require(["dojo/ready", "dojo/topic", "dojo/_base/array"], function (ready, topic, array) {
                //     ready(function () {
                //         EPiServerSiteAttentionData.initializeWidgetWatch();
                //         EPiServerSiteAttentionData.waitForAllWidgets();
                //     })
                // });
                topic.publish("siteattention/modelchanged", model);
            }

        });
    });
