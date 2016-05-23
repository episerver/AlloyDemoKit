define([
// dojo
    'dojo/_base/declare',
// epi-addons
    'epi-forms/widget/DropDownButton',
    'epi-forms/widget/ExportSelectorMenu',
// resources
    'epi/i18n!epi/cms/nls/episerver.forms.formdataview'
],
function (
// dojo
    declare,
// epi-addons
    DropDownButton,
    ExportSelectorMenu,
// resources
    resources
) {

    // module:
    //      epi-forms/widget/ExportDropDownButton
    // summary:
    //      Export drop-down button.
    //      List all available export sources.
    // tags:
    //      public

    return declare([DropDownButton], {

        dropDownSelectorType: ExportSelectorMenu,

        buildRendering: function () {

            this.inherited(arguments);

            this.set('iconClass', 'epi-iconDownload');
            this.set('title', resources.export);
        }

    });

});