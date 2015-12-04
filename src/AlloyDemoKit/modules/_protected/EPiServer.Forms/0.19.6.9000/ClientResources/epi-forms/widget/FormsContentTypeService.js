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
    //      epi-forms/widget/FormsContentTypeService
    // summary:
    //      Overrides 'epi-cms/widget/ContentTypeService' in order to filter out epi-forms's content types from ContentTypeList widget
    // tags:
    //      public

    return declare([ContentTypeService], {

        // _rootImageContentTypesPath: [private] String
        //      Root path for image's content types
        _rootImageContentTypesPath: null,

        constructor: function () {

            this._rootImageContentTypesPath = ModuleSettings.clientResourcePath + '/ClientResources/epi-forms/themes/sleek/images/contenttypes/';
        },

        filterQueryResult: function (result, allowedTypes, restrictedTypes) {
            // summary:
            //      Returns the filtered list result where filter is based on given allowed/restricted types. 
            // query: Object
            //      The returned array of models or promises from ContentTypeStore
            // allowedTypes: array
            //      The list of allowed types (retrieved from AllowedTypesAttribute.AllowedTypes metadata) 
            // restrictedTypes: array
            //      The list of restricted types (retrieved from AllowedTypesAttribute.restrictedTypes metadata) 
            // tags:
            //      protected, extensions

            var formElementContentTypes = ModuleSettings.formElementContentTypes;
            if (!allowedTypes || (allowedTypes instanceof Array && allowedTypes.indexOf(ModuleSettings.formElementBaseContentType) === -1)) {
                if (!(restrictedTypes instanceof Array)) {
                    restrictedTypes = [];
                }

                restrictedTypes.push.apply(restrictedTypes, formElementContentTypes);

                if (!allowedTypes) {
                    allowedTypes = ['episerver.core.icontentdata'];
                }

                return when(result, lang.hitch(this, function (types) {
                    // get the typeIdentifiers
                    var availableTypeIdentifiers = array.map(types, function (type) {
                        return type.typeIdentifier;
                    });

                    // filter typeIdentifiers based on allowed/restricted types
                    availableTypeIdentifiers = TypeDescriptorManager.getValidAcceptedTypes(availableTypeIdentifiers, allowedTypes, restrictedTypes);

                    types = array.filter(types, function (type) {
                        if (type.typeIdentifier === ModuleSettings.formContainerContentType && type.imagePath == null) {
                            type.imagePath = this._getImagePathByTypeIdentifier(type.typeIdentifier, [ModuleSettings.formContainerContentType]);
                        }

                        return array.some(availableTypeIdentifiers, function (typeIdentifier) {
                            return type.typeIdentifier === typeIdentifier;
                        });
                    }, this);

                    return types;
                }));
            }

            var deferred = new Deferred();
            when(this.inherited(arguments), lang.hitch(this, function (types) {

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

            return this._rootImageContentTypesPath + typeIdentifier.split('.').pop() + '.png';
        }

    });

});