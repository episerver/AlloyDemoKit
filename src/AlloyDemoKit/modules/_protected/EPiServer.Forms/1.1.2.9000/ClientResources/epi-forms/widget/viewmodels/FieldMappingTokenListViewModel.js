define([
// dojo
    'dojo/_base/declare',

    'dojo/Deferred',
    'dojo/when',
// epi
    'epi/dependency',

    'epi-cms/contentediting/viewmodel/_ViewModelMixin'
],
function (
// dojo
    declare,

    Deferred,
    when,
// epi
    dependency,

    _ViewModelMixin
) {

    // module:
    //      epi-forms/widget/viewmodels/FieldMappingTokenListViewModel
    // summary:
    //      View model for 'epi-forms/widget/PlaceHolderDropDownButton' widget
    // tags:
    //      public

    return declare([_ViewModelMixin], {

        postscript: function () {

            this.inherited(arguments);

            var registry = dependency.resolve('epi.storeregistry');

            this._contextService = this._contextService || dependency.resolve('epi.shell.ContextService');
            this._formsDataStore = this._formsDataStore || registry.get('epi-forms.formsdata');
        },

        getItems: function () {
            // summary:
            //      Get field mapping collection from forms data store.
            // returns: [Array]
            //      Field mappings
            // tags:
            //      public

            var deferred = new Deferred(),
                params = {
                    contentLink: this._contextService.currentContext.id
                };

            when(this._formsDataStore.executeMethod('GetFieldMappings', null, params), function (/*Object*/result) {
                deferred.resolve(!result ? [] : result.fieldMappings);
            });

            return deferred;
        }

    });

});