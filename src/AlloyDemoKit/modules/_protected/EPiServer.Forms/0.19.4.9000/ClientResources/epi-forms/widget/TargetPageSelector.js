define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

// epi
    'epi/shell/widget/dialog/Dialog',
    'epi-cms/widget/UrlSelector',

// epi-forms
    'epi-forms/widget/TargetPageEditor',

    // resources
    'epi/i18n!epi/cms/nls/episerver.forms.editview'
], function (
// dojo
    declare,
    lang,

// epi
    Dialog,
    UrlSelector,

// epi-forms
    TargetPageEditor,

// resources
    resources
) {

    return declare([
        UrlSelector
    ], {

        _getDialog: function () {
            // summary:
            //		Create Link Editor dialog
            // tags:
            //    protected

            this.dialogContent = new TargetPageEditor({
                modelType: this.metadata.additionalValues["modelType"],
                hiddenFields: ["text", "title", "target"]
            });

            this.own(this.dialogContent);

            return new Dialog({
                title: this._getTitle(),
                dialogClass: "epi-dialog-portrait",
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
