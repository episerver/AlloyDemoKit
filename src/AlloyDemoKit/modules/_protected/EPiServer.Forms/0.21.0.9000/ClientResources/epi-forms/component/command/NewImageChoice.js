define([
// dojo
    'dojo/_base/declare',
// epi
    'epi-cms/contentediting/command/NewItem',
// epi-addons
    'epi-forms/widget/ImageChoiceSelector'
],
function (
// dojo
    declare,
// epi
    NewItem,
// epi-addons
    ImageChoiceSelector
) {

    // module:
    //      epi-forms/component/command/NewImageChoice
    // tags:
    //      internal

    return declare([NewItem], {

        // dialogContentClass: [public] Class
        //      The widget class that will be created and placed as dialog's content
        dialogContentClass: ImageChoiceSelector

    });

});