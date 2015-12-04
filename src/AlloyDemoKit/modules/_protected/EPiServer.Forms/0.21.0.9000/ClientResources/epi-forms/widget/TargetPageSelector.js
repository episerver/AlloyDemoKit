define([
// dojo
    'dojo/_base/declare',
// epi
    'epi/shell/widget/dialog/Dialog',
    'epi-cms/widget/UrlSelector',
// epi-addons
    'epi-forms/widget/TargetPageEditor',
// resources
    'epi/i18n!epi/cms/nls/episerver.forms.editview'
],
function (
// dojo
    declare,
// epi
    Dialog,
    UrlSelector,
// epi-addons
    TargetPageEditor,
// resources
    resources
) {

    // module:
    //      epi-forms/widget/TargetPageSelector
    // tags:
    //      public

    return declare([UrlSelector], {

        _getDialog: function () {
            // summary:
            //      Create Link Editor dialog
            // tags:
            //      protected

            this.dialogContent = new TargetPageEditor({
                modelType: this.metadata.additionalValues['modelType'],
                hiddenFields: ['text', 'title', 'target']
            });

            this.own(this.dialogContent);

            return new Dialog({
                title: this._getTitle(),
                dialogClass: 'epi-dialog-portrait',
                content: this.dialogContent,
                destroyOnHide: false,
                defaultActionsVisible: false
            });
        },


        _getTitle: function () {
            // summary:
            //      Get title for the dialog.
            // tags:
            //      Override

            return resources.selectpage;
        }

    });

});