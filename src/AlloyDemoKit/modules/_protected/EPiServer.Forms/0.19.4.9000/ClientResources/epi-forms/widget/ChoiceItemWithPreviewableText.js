define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/aspect',
    'dojo/dom-class',
// epi
    'epi-cms/contentediting/editors/PreviewableTextEditor',
// epi-addons
    'epi-forms/ModuleSettings',
    'epi-forms/widget/_ChoiceItemWith'
],
function (
// dojo
    declare,
    lang,

    aspect,
    domClass,
// epi
    PreviewableTextEditor,
// epi-addons
    ModuleSettings,
    _ChoiceItemWith
) {

    // module:
    //      epi-forms/widget/ChoiceItemWithPreviewableText
    // summary:
    //      
    // tags:
    //      public

    return declare([_ChoiceItemWith], {

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        buildRendering: function () {

            this.inherited(arguments);

            this._setupExtendedWidget(this.item);
        },

        // =======================================================================
        // Protected stubs
        // =======================================================================

        _validToAddExtendedWidget: function (/*Object*/item) {
            // summary:
            //      Verifies that should be to create and then add extended widget or not.
            //      By default, return TRUE.
            //      Can be modified in an extended class.
            // item: [Object]
            //      Item data object used to build extended widget.
            // returns: [Boolean]
            //      TRUE:       Create and then Add extended widget. (Default)
            //      FALSE:      Do nothing.
            // tags:
            //      protected, extensions

            if (!item) {
                return false;
            }

            var allowedTypes = ModuleSettings.allowedPreviewableTextBoxTypes;
            if (!(allowedTypes instanceof Array) || allowedTypes.length <= 0) {
                return false;
            }

            var i = 0,
                totalTypes = allowedTypes.length,
                type = null;
            for (; i < totalTypes; i++) {
                type = allowedTypes[i];
                if (type && item.value.toLowerCase().indexOf(type) != -1) {
                    return true;
                }
            }

            return false;
        },

        _updateSelectorValue: function (/*String*/value) {
            // summary:
            //      
            // value: [String]
            //      
            // returns: [String]
            //      
            // tags:
            //      protected, abstract

            if (value == null) {
                return [value];
            }

            if (!this._selector || !this._selector.domNode) {
                return [value];
            }

            var selectorValue = this._selector.value;
            if (typeof selectorValue !== 'string') {
                return [value];
            }

            this.inherited(arguments);

            return [this._selector.get('value')];
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _setupExtendedWidget: function (/*Object*/item) {
            // summary:
            //      Injects 'epi-cms/contentediting/editors/PreviewableTextEditor' widget next to appropriate checkbox.
            // item: [Object]
            //      Item data object used to build extended widget.
            // tags:
            //      private

            var extendedWidget = this.get('extendedWidget');
            if (!extendedWidget || !item) {
                return;
            }

            this.set('extendedWidgetValue', item);

            // Should not ellipsis 'epi-cms/contentediting/editors/PreviewableTextEditor' widget's label
            if (extendedWidget.labelNode) {
                domClass.remove(extendedWidget.labelNode, 'dijitInline dojoxEllipsis');
            }

            this.own(
                aspect.before(extendedWidget, 'onChange', lang.hitch(this, this._updateSelectorValue))
            );
        }

    });

});