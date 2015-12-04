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
    //      epi-forms/contentediting/editors/viewmodels/ExternalFeedSelectionViewModel
    // summary:
    //      View model for 'epi-forms/contentediting/editors/ChoiceWithEditor' widget
    // tags:
    //      public

    return declare([_ViewModelMixin], {

        postscript: function () {

            this.inherited(arguments);

            var registry = dependency.resolve('epi.storeregistry');

            this._externalFeedStore = this._externalFeedStore || registry.get('epi-forms.externalfeed');
        },

        getItems: function (/*Object*/searchConditions) {
            // summary:
            //      Get feed item collection.
            // searchConditions: [Object]
            //      
            // returns: [Array]
            //      Feed items
            // tags:
            //      public

            var deferred = new Deferred(),
                params = {
                    feedId: searchConditions.key
                };

            when(this._externalFeedStore.executeMethod('getFeedItems', null, params), function (/*Array*/items) {
                deferred.resolve(items);
            });

            return deferred;
        }

    });

});