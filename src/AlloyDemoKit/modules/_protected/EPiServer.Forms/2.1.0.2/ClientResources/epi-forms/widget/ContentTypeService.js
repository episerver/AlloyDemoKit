define([
// dojo
    'dojo/_base/array',
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/Deferred',
    'dojo/when',
// epi
    'epi/shell/TypeDescriptorManager',
    'epi-cms/widget/ContentTypeService',
// epi-forms
    'epi-forms/ModuleSettings'
],
function (
// dojo
    array,
    declare,
    lang,

    Deferred,
    when,
// epi
    TypeDescriptorManager,
    ContentTypeService,
// epi-forms
    ModuleSettings
) {

    // module:
    //      epi-forms/widget/ContentTypeService
    // summary:
    //      Overrides 'epi-cms/widget/ContentTypeService' in order to filter out epi-forms's content types from ContentTypeList widget
    // tags:
    //      public

    return declare([ContentTypeService], {

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        filterQueryResult: function (result, allowedTypes, restrictedTypes) {
            // summary:
            //      Returns the filtered list result where filter is based on given allowed/restricted types. 
            // result: [Object]
            //      The returned array of models or promises from ContentTypeStore
            // allowedTypes: [Array]
            //      The list of allowed types (retrieved from AllowedTypesAttribute.AllowedTypes metadata) 
            // restrictedTypes: [Array]
            //      The list of restricted types (retrieved from AllowedTypesAttribute.restrictedTypes metadata) 
            // tags:
            //      protected, extensions

            // CASE 1:
            //      Show EPiServer Forms's container block only.
            // Query content type list from:
            //      - CMS Content area
            //      - Shared Blocks gadget
            //      - Global menu
            if (!allowedTypes || (allowedTypes instanceof Array && allowedTypes.indexOf(ModuleSettings.formElementBaseContentType) === -1)) {
                !allowedTypes && (allowedTypes = ['episerver.core.icontentdata']);
                // Only show EPiServer Forms's container block in this case.
                // So that, add entire EPiServer Forms's element block types to restricted types.
                !(restrictedTypes instanceof Array) && (restrictedTypes = []);
                restrictedTypes.push.apply(restrictedTypes, ModuleSettings.formElementContentTypes);

                return this._injectImageForFormContainerType(this.getInherited(arguments), [result, allowedTypes, restrictedTypes]);
            }

            // CASE 2:
            //      Show EPiServer Forms's element blocks only.
            // Query content type list from EPiServer Forms's content area
            return this._injectImageForFormElementTypes(this.inherited(arguments));
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _injectImageForFormContainerType: function (/*Object*/inheritedFunc, /*Array*/params) {
            // summary:
            //      Injects image path for EPiServer Forms's Form container block.
            // inheritedFunc: [Object]
            //      Base function that want to applies modification.
            // params: [Array]
            //      Modified arguments.
            // tags:
            //      private

            return when(inheritedFunc.apply(this, params), lang.hitch(this, function (types) {

                // Injects image path for Forms Container block.
                var i = 0,
                    totalItems = types.length,
                    type = null;
                for (; i < totalItems; i++) {
                    type = types[i];
                    if (type.typeIdentifier === ModuleSettings.formContainerContentType && type.imagePath == null) {
                        type.imagePath = this._getImagePathByTypeIdentifier(type.typeIdentifier, [ModuleSettings.formContainerContentType]);
                    }
                }

                return types;

            }));
        },

        _injectImageForFormElementTypes: function (/*Object*/result) {
            // summary:
            //      Injects image path for each type of EPiServer Forms's element block.
            // result: [Object]
            //      The returned array of models or promises from ContentTypeStore
            // tags:
            //      private

            var deferred = new Deferred();
            when(result, lang.hitch(this, function (types) {

                // Injects image path for each type of EPiServer Forms element block.
                var i = 0,
                    totalItems = types.length;
                for (; i < totalItems; i++) {
                    var imagePath = this._getImagePathByTypeIdentifier(types[i].typeIdentifier, ModuleSettings.registeredElementContentTypes);
                    if (imagePath) {
                        types[i].imagePath = imagePath;
                    }
                }

                deferred.resolve(types);

            }));

            return deferred;
        },

        _getImagePathByTypeIdentifier: function (/*String*/typeIdentifier, /*Array*/registeredTypes) {
            // summary:
            //      Gets image path for Form's content type based on its type identifier.
            // typeIdentifier: [String]
            //      Form's content type's type identifier
            // registeredTypes: [Array]
            //      Collection of registered types.
            // returns: [String]
            //      Image path for this content type.
            // tags:
            //      private

            if (!typeIdentifier) {
                return;
            }

            if (!(registeredTypes instanceof Array) || registeredTypes.length === 0) {
                return;
            }

            if (registeredTypes.indexOf(typeIdentifier) === -1) {
                return;
            }

            return ModuleSettings.clientResourcePath + '/ClientResources/epi-forms/themes/sleek/images/contenttypes/' + typeIdentifier.split('.').pop() + '.png';
        }

    });

});