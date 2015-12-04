define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/topic',
    'dojo/when',
// dijit
    'dijit/Destroyable',
// epi
    'epi/_Module',
    'epi/dependency',
    'epi/routes',

    'epi-cms/store/CustomQueryEngine',
// epi-addons
    'epi-forms/ModuleSettings',
    'epi-forms/widget/ContentTypeService'
],
function (
// dojo
    declare,
    lang,

    topic,
    when,
// dijit
    Destroyable,
// epi
    _Module,
    dependency,
    routes,

    CustomQueryEngine,
// epi-addons
    ModuleSettings,
    ContentTypeService
) {

    // module:
    //      epi-forms/FormsModule
    // summary:
    //      EPiServer Form main
    // tags:
    //      public

    return declare([_Module, Destroyable], {

        _settings: null,

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        constructor: function (/*Object*/settings) {

            this._settings = settings;
        },

        initialize: function () {
            // summary:
            //      Initialize module
            // tags:
            //      public, extensions

            this.inherited(arguments);

            declare.safeMixin(ModuleSettings, this._settings);

            var registry = this.resolveDependency('epi.storeregistry'),
                profile = dependency.resolve('epi.shell.Profile');

            registry.create('epi-forms.formselement', this._getRestPath('formselement'), { queryEngine: CustomQueryEngine });
            registry.create('epi-forms.formsdata', this._getRestPath('formsdata'), { idProperty: 'id' });
            registry.create('epi-forms.externalfeed', this._getRestPath('externalfeed'));
            registry.create('epi-forms.visitordatasource', this._getRestPath('visitordatasource'));

            this._contextHistory = this._contextHistory || dependency.resolve('epi.cms.BackContextHistory');
            this._contentDataStore = this._contentDataStore || registry.get('epi.cms.contentdata');

            topic.subscribe('/epi/cms/contentdata/childrenchanged', lang.hitch(this, this._navigateToFormContainer));

            return when(profile.getContentLanguage(), lang.hitch(this, function (language) {

                // Replace 'epi-cms/widget/ContentTypeService' with EPiServer Forms's content type service.
                this.registerDependency('epi.cms.ContentTypeService', new ContentTypeService());
            }));
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _getRestPath: function (/*String*/name) {
            // summary:
            //      Get EPiServer Forms REST path
            // name: [String]
            //      The current store name
            // tags:
            //      private

            return routes.getRestPath({
                moduleArea: 'EPiServer.Forms',
                storeName: name
            });
        },

        _navigateToFormContainer: function (/*String*/elementContentLink) {
            // summary:
            //      Navigates to Form Container block.
            // elementContentLink: [String]
            //      Content reference of editing Form element block.
            // tags:
            //      private

            if (!elementContentLink) {
                return;
            }

            when(this._contentDataStore.get(elementContentLink), lang.hitch(this, function (contentData) {
                if (!contentData) {
                    return;
                }

                if (!this._contextHistory) {
                    return;
                }

                var previousContent = this._contextHistory.getPrevious();
                if (!previousContent
                    // Do NOTHING if:
                    //  - Previous content is not type of Form Container block
                    //  - Publishing content is type of Form Container block
                    //  - Publishing content is not type of registered Form element blocks
                    || previousContent.typeIdentifier !== ModuleSettings.formContainerContentType
                    || contentData.typeIdentifier === ModuleSettings.formContainerContentType
                    || ModuleSettings.registeredElementContentTypes.indexOf(contentData.typeIdentifier) === -1) {
                    return;
                }

                // Close active popup object
                dijit.popup.close();

                topic.publish('/epi/shell/context/request', { uri: previousContent.uri }, { trigger: 'back', sender: this });
            }));
        }

    });

});