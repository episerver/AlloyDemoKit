define([
// dojo
    'dojo/_base/array',
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/Stateful',
// epi
    'epi/dependency'
],
function (
// dojo
    array,
    declare,
    lang,

    Stateful,
// epi
    dependency
) {

    // module:
    //      epi-forms/component/FormsContentTypesViewModel
    // summary:
    //      EPiServer Forms - Content Types component view model
    // tags:
    //      public

    return declare([Stateful], {

        // contentDataStore: [public] epi/shell/RestStore
        //      The content data store instance.
        contentDataStore: null,

        // parent: Content
        //      The parent content on which the new content is created.
        parent: null,

        // requestedType: String
        //      The type indentifier of created content. This is used for filtering available content types.
        requestedType: null,

        // createAsLocalAsset: Boolean
        //      Indicates that the content is created as local asset which means it will be attached to the parent content's asset folder.
        createAsLocalAsset: null,

        // actualParentLink: String
        //      Link of the parent beneath which the content is created. It could be the given parent or the given parent's local asset folder.
        actualParentLink: null,

        postscript: function () {
            // summary:
            //      Initializes internal objects and state after constructed.
            //      Obtains content data store and metadata manager instances from dependency manager.
            // tags:
            //      protected

            this.inherited(arguments);

            if (!this.contentDataStore) {
                var registry = dependency.resolve('epi.storeregistry');
                this.contentDataStore = registry.get('epi.cms.contentdata');
            }
        },

        update: function (/*Object*/settings) {
            // summary:
            //      Update the component with new settings.
            // settings: [Object]
            //      The settings object.
            // tags:
            //      protected

            // Copy data properties from topic sender
            if (settings) {
                array.forEach(['allowedTypes', 'restrictedTypes', 'requestedType', 'parent', 'createAsLocalAsset'], function (property) {
                    this.set(property, settings[property]);
                }, this);
            }
        },

        _createAsLocalAssetSetter: function (/*Boolean*/createAsLocalAsset) {
            // summary:
            //      Set createAsLocalAsset option.
            // createAsLocalAsset: Boolean
            //      
            // tags:
            //      private

            this.createAsLocalAsset = createAsLocalAsset;

            if (this.parent) {
                this.set('actualParentLink', this._getParentLink());
            }
        },

        _parentSetter: function (/*String*/parent) {
            // summary:
            //      
            // parent: [String]
            //      
            // tags:
            //      private

            this.parent = parent;
        },

        _requestedTypeSetter: function (/*String*/requestedType) {
            // summary:
            //      
            // requestedType: [String]
            //      
            // tags:
            //      private

            this.requestedType = requestedType;
        },

        _getParentLink: function () {
            // summary:
            //      Gets the link to the parent where the content should be created under.
            //      If the parent is a Content Asset folder the link to the owner content will be returned.
            // tags:
            //      private

            if (!this.parent) {
                return null;
            }

            if (this.createAsLocalAsset) {
                return this.parent.ownerContentLink ? this.parent.ownerContentLink : this.parent.contentLink;
            }

            return this.parent.contentLink;
        }

    });

});