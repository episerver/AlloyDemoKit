define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',
// epi
    'epi-cms/widget/viewmodel/HierarchicalListViewModel',
    'epi-cms/command/ShowAllLanguages',
// epi-addons
    'epi-forms/component/command/NewForm',
    'epi-forms/component/command/ViewFormData'
],

function (
// dojo
    declare,
    lang,
// epi
    HierarchicalListViewModel,
    ShowAllLanguagesCommand,
// epi-addons
    NewFormCommand,
    ViewFormDataCommand
) {

    // module:
    //      epi-forms/component/FormsViewModel
    // summary:
    //      Handles search and tree to list browsing widgets.
    // tags:
    //      public

    return declare([HierarchicalListViewModel], {

        onListItemSelected: function (model) {
            // summary:
            //      Update model of command when selection in the list changes.
            // tags:
            //      public
            this.inherited(arguments);
            this._commandRegistry.viewData.command.set("model", model);
        },

        _updateTreeContextCommandModels: function (model) {
            // summary:
            //      Update model of commands in case selected content is folder
            // tags:
            //      private

            this.inherited(arguments);

            var translateDelegate = lang.hitch(this.treeStoreModel, this.treeStoreModel.translate);
            this._commandRegistry.translate.command.set('model', model);
            this._commandRegistry.translate.command.set('executeDelegate', translateDelegate);

            this._commandRegistry.newFormDefault.command.set('model', model);
            this._commandRegistry.newForm.command.set('model', model);
        },

        _setupCommands: function () {
            // summary:
            //      Creates and registers the commands used.
            // tags:
            //      protected

            this.inherited(arguments);

            var customCommands = {
                newFormDefault: {
                    command: new NewFormCommand({
                        viewModel: this
                    })
                },
                newForm: {
                    command: new NewFormCommand({
                        viewModel: this,
                        category: "context",
                        iconClass: "epi-iconSharedBlock"
                    }),
                    order: 2,
                    isAvailable: this.menuType.ROOT | this.menuType.TREE
                },
                allLanguages: {
                    command: new ShowAllLanguagesCommand({ model: this }),
                    order: 55
                },
                viewData: {
                    command: new ViewFormDataCommand({
                        category: "context",
                        forceContextChange: true
                    }),
                    order: 4,
                    isAvailable: this.menuType.LIST
                }
            };

            this._commandRegistry = lang.mixin(this._commandRegistry, customCommands);

            this.pseudoContextualCommands.push(this._commandRegistry.newFormDefault.command);
        }

    });

});