define([
// dojo
    'dojo/_base/declare',
// epi
    'epi-cms/contentediting/command/ItemEdit',
// epi-addons
    'epi-forms/widget/ImageChoiceSelector'
],
function (
// dojo
    declare,
// epi
    ItemEdit,
// epi-addons
    ImageChoiceSelector
) {

    // module:
    //      epi-forms/component/command/EditImageChoice
    // tags:
    //      internal

    return declare([ItemEdit], {

        // dialogContentClass: [public] Class
        //      The widget class that will be created and placed as dialog's content
        dialogContentClass: ImageChoiceSelector

    });

});