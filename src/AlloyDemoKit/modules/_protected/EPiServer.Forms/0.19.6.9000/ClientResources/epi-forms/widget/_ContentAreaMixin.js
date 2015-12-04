define([
// dojo
    'dojo/_base/declare',

    'dojo/Deferred',
    'dojo/when',
// epi
    'epi/dependency',
    'epi/shell/TypeDescriptorManager',
// resources
    'epi/i18n!epi/cms/nls/episerver.forms.formscontentarea'
],
function (
// dojo
    declare,

    Deferred,
    when,
// epi
    dependency,
    TypeDescriptorManager,
// resources
    actionResources
) {

    // module:
    //      epi-forms/widget/_ContentAreaMixin
    // summary:
    //      
    // tags:
    //      private

    return declare(null, {

        // actionsResource: [public] Object
        //      The language resource for actions link
        actionsResource: actionResources,

        // contentDataStore: [public] Object
        //      
        contentDataStore: null,

        // formsElementStore: [public] Object
        //      
        formsElementStore: null,

        postMixInProperties: function () {

            this.inherited(arguments);

            var registry = dependency.resolve('epi.storeregistry');

            this.contentDataStore = this.contentDataStore || registry.get('epi.cms.contentdata');
            this.formsElementStore = this.formsElementStore || registry.get('epi-forms.formselement');
        },

        _getElementByType: function (/*Int*/typeId, /*String*/parentLink) {
            // summary:
            //      
            // typeId: [Int]
            //      
            // parentLink: [String]
            //      
            // returns: [Object]
            //      
            // tags:
            //      protected

            var deferred = new Deferred(),
                params = {
                    typeId: typeId,
                    parentLink: parentLink
                };

            when(this.formsElementStore.executeMethod('GetElementByType', null, params), function (element) {
                deferred.resolve(element);
            });

            return deferred;
        },

        _getElementTypeId: function (/*String*/typeName) {
            // summary:
            //      Get type id from type name.
            //
            // typeName: [String]
            //      
            // tags:
            //      private

            var deferred = new Deferred();

            when(this.formsElementStore.executeMethod('GetElementTypeId', null, { typeName: typeName }), function (typeId) {
                deferred.resolve(typeId);
            });

            return deferred;
        },

        _getDndTypes: function (/*String*/typeIdentifier) {
            // summary:
            //      
            // typeIdentifier: [String]
            //      
            // returns: [Array]
            //      
            // tags:
            //      private

            return TypeDescriptorManager.getAndConcatenateValues(typeIdentifier, 'dndTypes');
        }

    });

});