define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/dom-class',
    'dojo/dom-construct',
// epi
    'epi-cms/contentediting/editors/TinyMCEEditor',
// epi-addons
    'epi-forms/contentediting/editors/_PlaceHolderMixin',
    'epi-forms/widget/PlaceHolderDropDownButton'
],
function (
// dojo
    declare,
    lang,

    domClass,
    domConstruct,
// epi
    TinyMCEEditor,
// epi-addons
    _PlaceHolderMixin,
    PlaceHolderDropDownButton
) {

    // module:
    //      epi-forms/contentediting/editors/ParagraphTextEditor
    // summary:
    //      Extends 'epi-cms/contentediting/editors/TinyMCEEditor' editor in order to add placeholder drop-down button widget
    // tags:
    //      public

    return declare([_PlaceHolderMixin, TinyMCEEditor], {

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        postCreate: function () {

            this.inherited(arguments);

            this.own(
                this._dropDownButton = new PlaceHolderDropDownButton({
                    readOnly: this.readOnly,
                    modelTypeName: this.extendedWidgetModelType
                })
            );

            if (!this._dropDownButton) {
                return;
            }

            this.own(
                this.connect(this._dropDownButton, 'onItemSelected', lang.hitch(this, this._onDropDownListItemSelected))
            );

            var wrapper = domConstruct.create('div');
            domConstruct.place(this._dropDownButton.domNode, wrapper);
            domConstruct.place(wrapper, this.stateNode, 'before');

            // TECHNOTE:
            //      At the moment, the 'EPiServer Front-End Style Guide' do not mentions about positioning of an element.
            //      Both '.ui-helper-clearfix' and '.epi-floatRight' CSS classes inside 'DojoDashboardCompatibility.css'
            domClass.add(wrapper, 'epi-forms-paragraphTextCommands ui-helper-clearfix');
            domClass.add(this._dropDownButton.domNode, 'epi-floatRight');
        },

        focus: function () {
            // summary:
            //      Set focus on the current editor.
            // tags:
            //      public, extensions

            this.inherited(arguments);

            var ed = this.getEditor();
            if (ed) {
                this.set('lastFocusedTarget', ed);
            }
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _onDropDownListItemSelected: function (/*Object*/item) {
            // summary:
            //      Listen on onClick event of each item in token drop-down button.
            //      If this event fired, get current position of the cursor and then place the selected token at the position.
            // item: [Object]
            //      Selected token key (without '#' wrapped).
            // tags:
            //      private

            this._setTokenKeyFor(item, ['_setTokenKeyForTinyMCE']);
        }

    });

});