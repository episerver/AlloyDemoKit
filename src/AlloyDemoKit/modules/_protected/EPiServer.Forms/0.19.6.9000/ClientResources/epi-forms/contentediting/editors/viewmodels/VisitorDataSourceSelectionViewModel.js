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
    //      epi-forms/contentediting/editors/viewmodels/VisitorDataSourceSelectionViewModel
    // summary:
    //      View model for 'epi-forms/contentediting/editors/ChoiceWithEditor' widget
    // tags:
    //      public

    return declare([_ViewModelMixin], {

        postscript: function () {

            this.inherited(arguments);

            var registry = dependency.resolve('epi.storeregistry');

            this._visitorDataSourceStore = this._visitorDataSourceStore || registry.get('epi-forms.visitordatasource');
        },

        getItems: function (/*Object*/searchConditions) {
            // summary:
            //      Get visitor data source property collection.
            // searchConditions: [Object]
            //      
            // returns: [Array]
            //      Visitor data source properties
            // tags:
            //      public

            var deferred = new Deferred(),
                params = {
                    visitorDataSourceType: searchConditions.key
                };

            when(this._visitorDataSourceStore.executeMethod('getVisitorDataSourceProperties', null, params), function (/*Array*/properties) {
                deferred.resolve(properties);
            });

            return deferred;
        }

    });

});