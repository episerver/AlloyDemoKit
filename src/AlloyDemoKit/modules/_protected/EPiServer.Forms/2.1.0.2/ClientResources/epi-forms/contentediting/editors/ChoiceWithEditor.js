define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',
// epi-addons
    'epi-forms/contentediting/editors/ChoiceEditor'
],
function (
// dojo
    declare,
    lang,
// epi-addons
    ChoiceEditor
) {

    // module:
    //      epi-forms/contentediting/editors/ChoiceWithEditor
    // summary:
    //      RadioButton|CheckBox selector with a type of drop-down button list widget.
    // tags:
    //      protected

    return declare([ChoiceEditor], {

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        postMixInProperties: function () {

            this.inherited(arguments);

            !this.itemParams && (this.itemParams = {});

            lang.mixin(this.itemParams, {
                extendedWidgetType: this.extendedWidgetType
            });
        }

        // =======================================================================
        // Protected stubs
        // =======================================================================

        // =======================================================================
        // Private stubs
        // =======================================================================

    });

});