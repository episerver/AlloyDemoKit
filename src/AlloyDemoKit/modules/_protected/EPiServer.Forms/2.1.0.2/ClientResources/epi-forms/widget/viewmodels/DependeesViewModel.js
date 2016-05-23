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
    //      epi-forms/widget/viewmodels/DependeesViewModel
    // summary:
    //      View model for 'epi-forms/widget/PlaceHolderDropDownButton' widget
    // tags:
    //      public

    return declare([_ViewModelMixin], {

        postscript: function () {

            this.inherited(arguments);

            var registry = dependency.resolve('epi.storeregistry');

            this._contextService = this._contextService || dependency.resolve('epi.shell.ContextService');
            this._formsElementStore = this._formsElementStore || registry.get('epi-forms.formselement');
        },

        getItems: function () {
            // summary:
            //      Get all available dependees from forms element store.
            // returns: [Array]
            //      Dependees
            // tags:
            //      public

            var deferred = new Deferred(),
                query = {
                    id: this._contextService.currentContext.id,
                    query: 'GetAllDependees'
                };

            when(this._formsElementStore.query(query), function (/*Object*/results) {
                if (!(results instanceof Array) || results.length === 0) {
                    deferred.resolve([]);

                    return;
                }

                var i = 0,
                    totalItems = results.length,
                    items = [];
                for (; i < totalItems; i++) {
                    items.push({
                        'key': results[i].name,
                        'value': results[i].name
                    });
                }

                deferred.resolve(items);
            });

            return deferred;
        }

    });

});