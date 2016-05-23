define([
// dojo
    'dojo/_base/declare',
// epi-addons
    'epi-forms/widget/DropDownButton',
    'epi-forms/widget/ExternalSystemSelectorMenu'
],
function (
// dojo
    declare,
// epi-addons
    DropDownButton,
    ExternalSystemSelectorMenu
) {

    // module:
    //      epi-forms/widget/ExternalSystemDropDownButton
    // summary:
    //      External property drop-down button.
    //      List all available external property sources.
    // tags:
    //      public

    return declare([DropDownButton], {

        dropDownSelectorType: ExternalSystemSelectorMenu

    });

});