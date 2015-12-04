define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/dom-class',
    'dojo/dom-construct',

    'dojo/Evented',
    'dojo/when',
// epi-addons
    'epi-forms/_UtilityMixin',
    'epi-forms/ModuleSettings',
    'epi-forms/widget/ChoiceItem'
],
function (
// dojo
    declare,
    lang,

    domClass,
    domConstruct,

    Evented,
    when,
// epi-addons
    _UtilityMixin,
    ModuleSettings,
    ChoiceItem
) {

    // module:
    //      epi-forms/widget/_ChoiceItemWith
    // summary:
    //      Base class for an instance of 'epi-forms/widget/ChoiceItem' class with additional WIDGET.
    // tags:
    //      protected

    return declare([ChoiceItem, _UtilityMixin, Evented], {

        // _itemModelSeparator: [private] String
        //      
        _itemModelSeparator: ModuleSettings.itemModelSeparator,

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        buildRendering: function () {

            this.inherited(arguments);

            this._addExtendedWidget(this.item);
        },

        // =======================================================================
        // Protected stubs
        // =======================================================================

        _getExtendedWidgetAttr: function () {
            // summary:
            //      Gets created extended widget object.
            // returns: [Object]
            //      An instance of 'dijit/_Widget' class.
            // tags:
            //      protected

            return this._extendedWidget;
        },

        _setExtendedWidgetValueAttr: function (/*Object*/item) {
            // summary:
            //      
            // item: [Object]
            //      Item data object used to build extended widget.
            // tags:
            //      protected

            if (!this._extendedWidget || !item) {
                return;
            }

            var extendedWidgetValue = this._getExtendedWidgetValue(item);
            if (extendedWidgetValue) {
                this._extendedWidget.set('value', extendedWidgetValue);
            }
        },

        _getExtendedWidgetValue: function (/*Object*/item) {
            // summary:
            //      Gets stored value to display on the extended widget.
            // item: [Object]
            //      Item data object used to build extended widget.
            // returns: [String]
            //      Value to display on the extended widget.
            // tags:
            //      protected

            if (!item) {
                return;
            }

            var itemValue = item.value;
            if (!itemValue) {
                return;
            }

            if (itemValue.indexOf(this._itemModelSeparator) === -1) {
                return;
            }

            return itemValue.split(this._itemModelSeparator).pop();
        },

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
            //      protected, abstract

            return true;
        },

        _updateSelectorValue: function (/*String*/value) {
            // summary:
            //      
            // value: [String]
            //      
            // returns: [String]
            //      
            // tags:
            //      protected, extensions

            var selectorValue = this._selector.value;
            if (typeof selectorValue === 'string') {
                var extendedValue = this._itemModelSeparator + value;
                this._selector.set('value', selectorValue.indexOf(this._itemModelSeparator) === -1
                    ? selectorValue + extendedValue
                    : selectorValue.split(this._itemModelSeparator)[0] + extendedValue);

                this.emit('selectorChanged');
            }
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _addExtendedWidget: function (/*Object*/item) {
            // summary:
            //      Places created widget as the last child of the selector container section.
            // item: [Object]
            //      Item data object used to build extended widget.
            // tags:
            //      private

            if (!this.extendedWidgetType || !this._validToAddExtendedWidget(item)) {
                return;
            }

            when(this.getInstanceFromType(this.extendedWidgetType), lang.hitch(this, function (/*Object*/extendedWidget) {
                // extendedWidget: [Object]
                //      An instance of 'dijit/_Widget' class.

                if (!extendedWidget || !extendedWidget.domNode || !this.selectorContainer) {
                    return;
                }

                domClass.add(extendedWidget.domNode, 'epi-forms-extendedWidget');
                domConstruct.place(extendedWidget.domNode, this.selectorContainer, 'last');

                this._extendedWidget = extendedWidget;
            }));
        }

    });

});