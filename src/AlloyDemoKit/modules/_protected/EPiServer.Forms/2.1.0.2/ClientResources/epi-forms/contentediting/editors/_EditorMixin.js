define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/when',
// epi-addons
    'epi-forms/_UtilityMixin'
],
function (
// dojo
    declare,
    lang,

    when,
// epi-addons
    _UtilityMixin
) {

    // module:
    //      epi-forms/contentediting/editors/_EditorMixin
    // summary:
    //      
    // tags:
    //      protected

    return declare([_UtilityMixin], {

        postMixInProperties: function () {

            this.inherited(arguments);

            when(this.getInstanceFromType(this.editorModelType), lang.hitch(this, function (editorModel) {

                !this.itemParams && (this.itemParams = {});

                lang.mixin(this.itemParams, {
                    model: editorModel
                });

            }));
        }

    });

});