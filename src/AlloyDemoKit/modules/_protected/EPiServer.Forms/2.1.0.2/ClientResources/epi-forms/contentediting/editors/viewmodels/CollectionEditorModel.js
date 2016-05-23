define([
// dojo
    'dojo/_base/declare',
// epi
    'epi-cms/contentediting/editors/model/CollectionEditorModel'
],
function (
// dojo
    declare,
// epi
    CollectionEditorModel
) {

    // module:
    //      epi-forms/contentediting/editors/viewmodels/CollectionEditorModel
    // summary:
    //      Extends 'epi-cms/contentediting/editors/model/CollectionEditorModel' class in order to:
    //      - Fix bug 'null' display for "+" button in IE browser.
    // tags:
    //      public

    return declare([CollectionEditorModel], {

        getListCommands: function (availableCommands) {
            // summary:
            //      Return list level commands.
            // availableCommands:
            //      The available commands bitmask. This value is Not needed to be passed since it's set up when the model is created.
            // tags:
            //      public, extensions

            var listCommands = this.inherited(arguments);
            // TECHNOTE:
            //      Avoid on IE the label button display 'null', we set the label to empty string.
            if (listCommands instanceof Array && listCommands.length > 0) {
                listCommands[0].label = '';
            }

            return listCommands;
        }

    });

});