define([
// Dojo
    "dojo",
    "dojo/_base/declare",
//CMS
    "epi/_Module",
    "epi/dependency",
    "epi/routes",
//Custom code
    "siteattention/commandproviders/SiteAttentionCommandProvider",
    "siteattention/content"
], function (
// Dojo
    dojo,
    declare,
//CMS
    _Module,
    dependency,
    routes,
//Custom code
    SiteAttentionCommandProvider,
    Content
) {

    return declare("siteattention.DefaultModule", [_Module], {
        // summary: Module initializer for the default module.

        initialize: function () {
            //console.info('In siteattention.DefaultModule - initialize');
            this.inherited(arguments);

            var content = new Content();
            content.initialize();

            //Register the store
            var registry = this.resolveDependency("epi.storeregistry");
            //console.info('Past registry...');
            registry.create("siteattention.siteattentiondata", this._getRestPath("siteattentiondata"));
            registry.create("siteattention.siteattentionmetadata", this._getRestPath("siteattentionmetadata"));
            //console.info('stores created');

            // Register the Command Provider
            var saCommandProvider = new SiteAttentionCommandProvider();
            var commandregistry = dependency.resolve("epi.globalcommandregistry");
            //console.info('dependency.resolve("epi.globalcommandregistry")');
            commandregistry.registerProvider("epi.cms.publishmenu", saCommandProvider);
            //console.info('In siteattention.DefaultModule - initialize - End');
        },

        _getRestPath: function (name) {
            return routes.getRestPath({ moduleArea: "siteattentionmodule", storeName: name });
        }

    });
});

// SiteAttention data
var SiteAttentionSelectors = [];
//var SiteAttentionLicenseKey;

var SiteAttentionPageExternalUrl;
var SiteAttentionUILanguage;


// The Data Helper object
var EPiServerSiteAttentionData = new function () {
    this.fields = {};
    this.properties = {};
    this.licenseKey = null;
    this.PageInformation = {};
    this.siteAttentionCurrentContentModel = null;
    this.siteAttentionLoaded = false;
    this.currentPage = '';
    this.currentContentLink = '';
    this.subscriptionActive = false;
    this.siteAttentionWidgetTag = null;
    this.siteAttentionHeadingTag = null;
    this.regExp = new RegExp('dijit_form_ToggleButton_.*_label');
    this.regExpAlt = new RegExp('siteattention-widget-header');
    this.previousWidgetHeight = '';
    this.previousWidgetWidth = '';
    this.model = null;
    this.watchTimerActive = false;

    this.widgetsReady = false
    this.widgetsMaxCount = 20;
    this.$widgetsResult = null;
    this.lastWidgetValue = {}

    this.focusWhenReady = null;

    this.initializeWidgetWatch = function () {
        EPiServerSiteAttentionData.widgetsReady = false;
        EPiServerSiteAttentionData.widgetsMaxCount = 20;
        EPiServerSiteAttentionData.$widgetsResult = null;
        EPiServerSiteAttentionData.lastWidgetValue = {};
    };

    this.waitForAllWidgets = function () {
        require(["dijit/registry", "dojo/_base/array"], function (registry, array) {

            EPiServerSiteAttentionData.$widgetsResult = $.grep(registry.toArray(), function (e) {
                return e.name != null && e.editMode != null && !e._destroyed;
            });

            // Prepare defaultValues
            for (var index in EPiServerSiteAttentionData.$widgetsResult) {
                var widget = EPiServerSiteAttentionData.$widgetsResult[index];
                EPiServerSiteAttentionData.lastWidgetValue[widget.id] = widget.displayedValue ? widget.displayedValue : widget.labelValue;
            }

            // We need to wait for a known built-in widget to be shown
            var result = $.grep(EPiServerSiteAttentionData.$widgetsResult, function (e) { return e.name == 'iversionable_startpublish'; });
            if (result.length > 0) {
                EPiServerSiteAttentionData.widgetsReady = true;

                // Manage indirect focus
                if (EPiServerSiteAttentionData.focusWhenReady) {
                    var widgetToEdit = $.grep(EPiServerSiteAttentionData.$widgetsResult, function (e) { return e.name == EPiServerSiteAttentionData.focusWhenReady && !e._destroyed; });
                    if (widgetToEdit.length > 0 && widgetToEdit[widgetToEdit.length - 1].changeNode) {
                        widgetToEdit[widgetToEdit.length - 1].changeNode.click();
                    }

                    EPiServerSiteAttentionData.siteAttentionCurrentContentModel.setActiveProperty(EPiServerSiteAttentionData.focusWhenReady)
                    EPiServerSiteAttentionData.focusWhenReady = null;
                }

                setTimeout(function () { EPiServerSiteAttentionData.widgetWatch() }, 800);
            }

            if (!EPiServerSiteAttentionData.widgetsReady && EPiServerSiteAttentionData.widgetsMaxCount-- > 0) {
                // All widgets have been loaded, start watching
                setTimeout(function () { EPiServerSiteAttentionData.waitForAllWidgets() }, 800);
            }
        });
    };

    this.widgetWatch = function () {
        var diff = "";
        if (EPiServerSiteAttentionData.$widgetsResult != null) {
            EPiServerSiteAttentionData.$widgetsResult.forEach(function (item) {
                var propValue = EPiServerSiteAttentionData.properties[item.name];
                if (propValue != null) {

                    // We might have several widgets showing the same property - need to watch them all
                    var result = $.grep(EPiServerSiteAttentionData.$widgetsResult, function (e) { return e.name == item.name; });
                    for (var index in result) {
                        var widget = result[index];

                        var lastValue = EPiServerSiteAttentionData.lastWidgetValue[widget.id];
                        var currentValue = widget.displayedValue ? widget.displayedValue : widget.labelValue;

                        var tag = $("#" + widget.id);
                        var inputValue = tag.length > 0 ? tag[0].value : null;
                        if (inputValue != null && currentValue != inputValue) {
                            currentValue = inputValue;
                        }

                        if (currentValue != null && typeof (currentValue) != 'undefined' && lastValue != currentValue) {

                            // Save the previous value to avoid a change to tigger wrongly
                            EPiServerSiteAttentionData.lastWidgetValue[widget.id] = currentValue;

                            // Check if this value has been reported yet
                            if (propValue != currentValue) {
                                console.info(currentValue);
                                EPiServerSiteAttentionData.properties[item.name] = currentValue
                                EPiServerSiteAttentionData.onContentChange.raise(item.name, propValue, currentValue);

                            }
                        }
                    };
                }
            });
        }
        setTimeout(function () { EPiServerSiteAttentionData.widgetWatch() }, 800);
    }

    this.watch = function (model) {
        this.model = model;
        if (!this.watchTimerActive) {
            this.watchTimerActive = true;
            this.watchTimer();
        }
    };

    this.watchTimer = function (a) {

        //console.info('- - - - - - - - - [icontent_name] SA: ' + this.properties['icontent_name'] + ' Model prop: ' + this.model.contentData.properties['icontent_name'] + ' Model model: ' + this.model.contentModel['epi-icontent_name']);
        for (var propName in this.properties) {

            var modelProperty = this.model.contentModel['epi-' + propName] == null ? '' : this.model.contentModel['epi-' + propName];
            var saProperty = this.properties[propName] == null ? '' : this.properties[propName];

            //console.info('prop: ' + propName + ' = ' + this.properties[propName]);

            if (modelProperty != saProperty) {
                //console.info('>>>>>>> [' + propName + '] Model: ' + modelProperty + ' --- SA: ' + saProperty);
                this.properties[propName] = modelProperty;
                EPiServerSiteAttentionData.onContentChange.raise(propName, saProperty, modelProperty);
            }

        }

        this.watchTimerObject = setTimeout("EPiServerSiteAttentionData.watchTimer(1)", 3000);
    };

    this.focus = function (propertyId) {

        if (propertyId == 'pageExternalURL' || propertyId == 'iroutable_routesegment') {
            // Special treatment of a few selected properties

            if (this.siteAttentionCurrentContentModel.viewName == 'onpageedit') {
                // Force the change to formsedit and in the next step, set focus when ready
                this.siteAttentionCurrentContentModel.setActiveProperty('iversionable_startpublish')
                this.focusWhenReady = propertyId;
            }
            else {
                this.focusWhenReady = null;
                var widgetToEdit = $.grep(EPiServerSiteAttentionData.$widgetsResult, function (e) { return e.name == propertyId && !e._destroyed; });
                if (widgetToEdit.length > 0 && widgetToEdit[widgetToEdit.length - 1].changeNode) {
                    widgetToEdit[widgetToEdit.length - 1].changeNode.click();
                }
            }
        }
        else {
            this.siteAttentionCurrentContentModel.setActiveProperty(propertyId)
        }


    };

    this._findLabelElement = function (baseTag) {
        if (baseTag != null) {
            for (var index = 0; index < baseTag.childNodes.length; index++) {
                if (baseTag.childNodes[index].id != null &&
                    (baseTag.childNodes[index].id.match(this.regExp) || baseTag.childNodes[index].id.match(this.regExpAlt))) {
                    return baseTag.childNodes[index];
                }
                else {
                    var tag = this._findLabelElement(baseTag.childNodes[index]);
                    if (tag != null) {
                        return tag;
                    }
                }
            }
        }
        return null;
    };

    this.clearHandlers = function () {
        this.onContentChange.clearAllHandlers();
    }

    this.onContentChange = new function () {
        this.handlers = [];
        this.add = function (func, handlerName, contentId) {
            if (handlerName == null) {
                handlerName = 'default'
            }
            handlerName = handlerName.toLowerCase();
            var doAdd = true;
            for (var key in this.handlers) {
                if (this.handlers[key].name == handlerName) {
                    this.handlers[key].func = func;
                    doAdd = false;
                }
            }
            if (doAdd) {
                this.handlers[this.handlers.length] = { 'name': handlerName, 'func': func };
                // Force an initial raise of the event
                if (contentId != null) {
                    var content = EPiServerSiteAttentionData.properties[contentId];
                    //console.info('.....' + func + ' contentId ' + contentId + ' ::: ' + content);
                    func(contentId, "", content.toString());
                };
            }
        };
        this.raise = function (name, oldValue, newValue) {

            for (var key in this.handlers) {
                if (this.handlers[key].name.indexOf(name.toLowerCase() + '_') == 0) {
                    var oldValueString = oldValue.toString();
                    var newValueString = newValue.toString();
                    var vt = "";
                    for (var vtkey in SiteAttentionSelectors) {
                        if (SiteAttentionSelectors[vtkey].contentId == name) {
                            vt = SiteAttentionSelectors[vtkey].wrapperTag;
                        };
                    }
                    if (vt != "") {
                        oldValueString = '<' + vt + '>' + oldValueString + '</' + vt + '>';
                        newValueString = '<' + vt + '>' + newValueString + '</' + vt + '>';
                    }

                    if (EPiServerSiteAttentionData.properties[name]) {
                        EPiServerSiteAttentionData.properties[name] = newValue.toString();
                    }

                    this.handlers[key].func(name, oldValueString, newValueString);

                }
            }
        };
        this.clearAllHandlers = function () {
            this.handlers = [];
        };

    };

    this.onPageChange = new function () {
        this.handlers = [];
        this.add = function (func, handlerName) {
            if (handlerName == null) {
                handlerName = 'default'
            }
            handlerName = handlerName.toLowerCase();
            var doAdd = true;
            for (var key in this.handlers) {
                if (this.handlers[key].name == handlerName) {
                    this.handlers[key].func = func;
                    doAdd = false;
                }
            }
            if (doAdd) {
                this.handlers[this.handlers.length] = { 'name': handlerName, 'func': func };
            }
        };
        this.raise = function (name) {
            //console.info('raiseOnPageChange ' + name);
            for (var key in this.handlers) {
                this.handlers[key].func(name.toLowerCase());
            }
        };
    };

}
