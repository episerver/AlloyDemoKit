define([
// dojo
    'dojo/_base/declare',
// epi-addons
    'epi-forms/widget/DropDownButton',
    'epi-forms/widget/PlaceHolderSelectorMenu',
    'epi-forms/widget/viewmodels/FieldMappingTokenListViewModel',
// resources
    'epi/i18n!epi/cms/nls/episerver.forms.editview'
],
function (
// dojo
    declare,
// epi-addons
    DropDownButton,
    PlaceHolderSelectorMenu,
    FieldMappingTokenListViewModel,
// resources
    resources
) {

    // module:
    //      epi-forms/widget/PlaceHolderDropDownButton
    // summary:
    //      Form field mapping tokens drop-down button.
    //      List all available form field mapping tokens.
    // tags:
    //      public

    return declare([DropDownButton], {

        dropDownSelectorType: PlaceHolderSelectorMenu,

        modelTypeName: null,

        modelClassName: FieldMappingTokenListViewModel,

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        buildRendering: function () {

            this.inherited(arguments);

            this.set('iconClass', 'epi-iconGuides epi-icon--medium');
            this.set('label', resources.insertplaceholder);
        }

    });

});