define([
// dojo
    'dojo/_base/declare',
// epi
    'epi-cms/contentediting/command/BlockRemove',
    'epi-cms/contentediting/command/ContentAreaCommands',
    'epi-cms/contentediting/command/MoveToNext',
    'epi-cms/contentediting/command/MoveToPrevious',
// epi-addons
    'epi-forms/component/command/EditImageChoice'
],
function (
// dojo
    declare,
// epi
    Remove,
    ContentAreaCommands,
    MoveToNext,
    MoveToPrevious,
// epi-addons
    EditImageChoice
) {

    // module:
    //      epi-forms/component/command/ImageChoiceCommands
    // summary:
    //      The commands for context menu of editor, 
    //      and use as class for commandProviderClass
    // description:
    //      That include:
    //          - Edit command
    //          - Move previous command
    //          - Move next command
    //          - Remove command
    // tags:
    //      internal

    return declare([ContentAreaCommands], {

        constructor: function (/*Object*/options) {
            // summary:
            //      Overwrite base class
            // tags:
            //      protected

            var commandOptions = options ? options.commandOptions : {};
            this.commands = [
                new EditImageChoice(commandOptions),
                new MoveToPrevious(commandOptions),
                new MoveToNext(commandOptions),
                new Remove(commandOptions)
            ];
        }

    });

});