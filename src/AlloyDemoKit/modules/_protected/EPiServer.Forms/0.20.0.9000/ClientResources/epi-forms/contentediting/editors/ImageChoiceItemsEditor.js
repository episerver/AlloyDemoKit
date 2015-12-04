define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

// epi
    'epi/shell/widget/ContextMenu',                                             // used to create context menu
    'epi-cms/contentediting/editors/ItemCollectionEditor',

// epi-forms
    'epi-forms/component/command/NewImageChoice',
    'epi-forms/component/command/ImageChoiceCommands',                    // context menu

// resources
    'epi/i18n!epi/cms/nls/episerver.forms.imagechoiceitems'

], function (
// dojo
    declare,
    lang,

// epi
    ContextMenu,
    ItemCollectionEditor,

// epi-forms
    NewImageChoiceItem,
    ImageChoiceCommands,

// resources
    resources
) {

    return declare([
        ItemCollectionEditor
    ], {

        // res: [protected] Json object
        //      Language resource
        res: resources,

        // actionsResource: [Object]
        //      The language resource for actions link
        actionsResource: resources,

        // commandProviderClass: [public] String
        //      The command's namespace can be injected from inheritance or caller.
        commandProviderClass: ImageChoiceCommands,

        setupCommands: function () {
            // summary
            //      Initialization commands
            // tags:
            //      protected

            // Make command provider is injected
            this.contextMenu = this.contextMenu || new ContextMenu();
            this.commandProvider = this.commandProvider || new this.commandProviderClass({ model: this.model, commandOptions: this.commandOptions });
            this.contextMenu.addProvider(this.commandProvider);

            lang.mixin(this.commandOptions.dialogContentParams, { hiddenFields: ["target"] });  // hide the not using target

            this.own(
                this.contextMenu,
                this.commandProvider,

                // Create new item command, store to reuse.
                this._newItemCommand = new NewImageChoiceItem({
                    "model": this.model,
                    "dialogContentParams": this.commandOptions ? this.commandOptions.dialogContentParams : {}
                })
            );
        }

    });
});
