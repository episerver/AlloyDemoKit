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
    "siteattention/content",
    "siteattention/siteattentionmodule",
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
    Content,
    SiteAttentionModuleWrapper
) {

    return declare("siteattention.DefaultModule", [_Module], {
        // summary: Module initializer for the default module.
        SiteAttentionModule: new SiteAttentionModuleWrapper().SiteAttentionModule,
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
            EPiServerSiteAttentionData.SiteAttentionModule = this.SiteAttentionModule;
        },

        _getRestPath: function (name) {
            return routes.getRestPath({ moduleArea: "siteattentionmodule", storeName: name });
        },

    });
});

var siteAttentionPluginUrl = 'https://api.siteattention.com/';

// The Data Helper object
var EPiServerSiteAttentionData = {
    licenseKey: null,
    iid: null,
    locked: false,
    PageInformation: {},
    siteAttentionCurrentContentModel: null,
    siteAttentionLoaded: false,
    SiteAttentionSelectors: [],
    SiteAttentionPageExternalUrl: null,
    SiteAttentionUILanguage: null,
    onPageChange: function () {

        try {
            //ugly hack, since the ui is not properly reset. Need to confirm with Marius
            SA.reset();
        }
        catch (ex) {
            //f** dojo
        }
        SiteAttentionEpiServerWatcher.clearHandlers();
        this.initSiteAttentionPlugin();
    },
    initSiteAttentionPlugin: function () {
        if (this.SiteAttentionLoaded) {
            this.loadSiteAttentionForPage();
            return;
        }

        this.SiteAttentionLoaded = true;

        this.SiteAttentionModule.inject_script(siteAttentionPluginUrl + (this.licenseKey ? this.licenseKey : ""), this.loadSiteAttentionForPage.bind(this));

        //SiteAttentionModule.hooks.add
        //(
        //    'after',
        //    'resume',
        //    '_handleSidebarPanel_resume',
        //    this._handleSidebarPanel,
        //    this
        //);
        //SiteAttentionModule.hooks.add
        //(
        //    'after',
        //    'play',
        //    '_handleSidebarPanel_play',
        //    this._handleSidebarPanel,
        //    this
        //);
        //SiteAttentionModule.hooks.add
        //(
        //    'after',
        //    'load',
        //    '_handleSidebarPanel_load',
        //    this._handleSidebarPanel,
        //    this
        //);

        SiteAttentionModule.hooks.add
        (
            'after',
            'register',
            'save license',
            this._saveLicense,
            this
        );
        SiteAttentionModule.hooks.add
        (
            'after',
            'instance',
            'save instance data',
            this._saveInstance,
            this
        );
        SiteAttentionModule.hooks.add
        (
            'after',
            'license',
            'save instance data',
            this._saveLicense,
            this
        );
    },
    _saveLicenseAndIid: function (license, iid, name, locked) {
        require(["dojo", "epi/dependency"], function (dojo, dependency) {
            //Register the store
            var registry = dependency.resolve("epi.storeregistry");
            var store = registry.get("siteattention.siteattentiondata");
            dojo.when(store.put({ licenseKey: license, iid: iid, instanceName: name, locked: locked }), function (result) {
            });
        });
    },
    _saveLicense: function (status, key, savedData) {
        if (status === true) {
            this.licenseKey = key;
            this.iid = savedData.iid;
            this.locked = savedData.locked==="1";
            this._saveLicenseAndIid(this.licenseKey, this.iid, savedData.name, this.locked);
        }
    },

    _saveInstance: function (status, instance) {
        if (status === true) {
            this.iid = instance.iid;
            this._saveLicenseAndIid(this.licenseKey, instance.iid, instance.name, this.locked);
        }
    },
    _handleSidebarPanel: function () {
        var siteAttentionContainer = document.querySelector("#SiteAttention");
        var siteAttentionWidgetContainer = document.querySelector("#SAPL");

        var movedAttribute = siteAttentionContainer.getAttribute("data-moved");
        if (!movedAttribute) {

            siteAttentionWidgetContainer.appendChild(siteAttentionContainer);
            siteAttentionContainer.setAttribute("data-moved", true);
        }
    },
    _generateContentAreaSelectors: function () {
        return SiteAttentionEpiServerWatcher
            .model
            .metadata
            .properties
            .filter(function (m) { return m.modelType === "EPiServer.Core.ContentArea" })
            .map(function (prop) {
                return {
                    contentfield: "content",
                    name: prop.displayName,
                    contentId: prop.name
                };
            });
    },
    loadSiteAttentionForPage: function () {

        /**
         * Start SiteAttention in case it is not already started.
         */
        if (!SiteAttention.started) {
            var siteAttentionWidgetContainer = document.querySelector("#SAPL");
            SiteAttention.play({
                container: siteAttentionWidgetContainer,
                minimised: false
            });
        }

        var fields = this.SiteAttentionSelectors.map(function (selector) {
            return {
                seo: selector.contentfield === 'url' ? 'url' : selector.contentfield,
                name: selector.name,
                selector: StringHelper.lowerCaseFirstLetter(selector.contentId),
                type: 'FieldEPiServerWrapper'
            }
        });

        let map = this.SiteAttentionModule.FieldFactory(fields);
        /**
         * Load SiteAttention configuration and let it do it's job.
         */
        //TODO: dummy data need to be populated from this.PageInformation
        var url = document.location.origin + EPiServerSiteAttentionData.SiteAttentionPageExternalUrl;
        SiteAttention.load(
            {
                cms: SiteAttentionModule.Cms.EPIServer,
                pid: this.PageInformation.contentGuid,
                iid: this.iid ? this.iid : null,
                type: this.PageInformation.pageTypeName,
                lang: this.PageInformation.languageId,
                user: this.PageInformation.username,
                url: url,//this.PageInformation.externalUrl,
                published: this.PageInformation.published,
                map: map
            }
        );
    }
}

//main data dispatcher to support FieldEPiServerWrapper
var SiteAttentionEpiServerWatcher = {
    handlers: {},
    model: {},
    metadata: {},
    renderedModel: {},
    renderedHtml: {},
    hasField: function (field) {
        return true;
    },
    clearHandlers: function (field) {
        handlers = {};
        renderedModel = {};
        renderedHtml = {};
    },
    register: function (field, cb) {
        var correctFieldName = StringHelper.lowerCaseFirstLetter(field);
        if (!this.handlers.hasOwnProperty(correctFieldName))
            this.handlers[correctFieldName] = [];

        this.handlers[correctFieldName].push(cb);
    },
    unregister: function (field) {
        var correctFieldName = StringHelper.lowerCaseFirstLetter(field);
        if (this.handlers.hasOwnProperty(correctFieldName)) {
            this.handlers[correctFieldName] = [];
        }
    },
    getValue: function (field) {
        var epiField = 'epi-' + StringHelper.lowerCaseFirstLetter(field);
        if (this.renderedModel.hasOwnProperty(epiField)) {
            return this.renderedModel[epiField];
        }

        if (this.model && this.model.contentModel) {
            if (this.model.contentModel.hasOwnProperty(epiField)) {
                return this.model.contentModel[epiField];
            }
        }

        return '';
    },

    getHtmlValue: function (field) {
        var epiField = 'epi-' + StringHelper.lowerCaseFirstLetter(field);
        if (this.renderedHtml.hasOwnProperty(epiField)) {
            var result = this.renderedHtml[epiField];
            return result;
        }

        if (this.model && this.model.renderedHtml) {
            if (this.model.renderedHtml.hasOwnProperty(epiField)) {
                return this.model.renderedHtml[epiField];
            }
        }

        return this.getValue(field);
    },

    updateValue: function (field, newValue, newHtml) {
        this.renderedModel['epi-' + field] = newValue;
        this.renderedHtml['epi-' + field] = (newHtml ? newHtml : newValue);

        var correctFieldName = StringHelper.lowerCaseFirstLetter(field);
        if (this.handlers.hasOwnProperty(correctFieldName)) {
            var cbs = this.handlers[correctFieldName];
            for (var index = 0; index < cbs.length; index++) {
                var cb = cbs[index];
                cb();
            }
        }
    },
    notifyAllHandlers: function () {
        Object.keys(this.handlers).forEach(function (field) {
            this.updateValue(field);
        }.bind(this));
    },
    //receiving model from SiteAttentionWidget 
    updateBaseModel: function (model) {
        this.model = model;
        this.renderedModel = {};
        this.renderedHtml = {};
    },
    focus: function (propertyId) {
        if (propertyId === "pageExternalURL" || propertyId === "iroutable_routesegment") {
            $(".epi-form-container.epi-cmsEditingForm.epi-cmsEditingFormOpe.dijitContainer.epi-cardContainer-child.epi-cardContainer-epi-cmsEditingForm.dijitHidden").removeClass("dijitHidden").addClass("dijitVisible");
            var attr = "[name*='" + propertyId + "']";
            var ctr = $(attr);
            try {
                ctr[0].click();
            } catch (ex) {
            }

        } else {
            this.model.setActiveProperty(propertyId);
        }
    }
}

//function StringHelper(parameters) {};

var StringHelper = {
    lowerCaseFirstLetter: function (value) {
        return value.charAt(0).toLowerCase() + value.slice(1);
    }
}