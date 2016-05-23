define([
// dojo
    'dojo/_base/array',
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/dom-class',
    'dojo/dom-construct',

    'dojo/on',
    'dojo/when',
// dijit
    'dijit/_TemplatedMixin',
    'dijit/_Widget',

    'dijit/focus',
// epi
    'epi/shell/widget/_ValueRequiredMixin',
// epi-addons
    'epi-forms/contentediting/editors/_EditorMixin',
    'epi-forms/ModuleSettings'
],
function (
// dojo
    array,
    declare,
    lang,

    domClass,
    domConstruct,

    on,
    when,
// dijit
    _TemplatedMixin,
    _Widget,

    focusUtil,
// epi
    _ValueRequiredMixin,
// epi-addons
    _EditorMixin,
    ModuleSettings
) {

    // module:
    //      epi-forms/contentediting/editors/_WidgetListEditor
    // summary:
    //      Base widget for option list.
    //      Option item can be a radio button or a checkbox button.
    // tags:
    //      protected

    return declare([_Widget, _TemplatedMixin, _ValueRequiredMixin, _EditorMixin], {

        templateString: '<section class="dijit dijitReset dijitInline"></section>',

        baseClass: 'epi-forms-itemWidgetList',

        value: null,

        // _recordFieldSeparator: [private] String
        //      
        _recordFieldSeparator: ModuleSettings.recordFieldSeparator,

        constructor: function () {

            this._itemWidgets = [];
        },

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        postMixInProperties: function () {

            this.inherited(arguments);

            !this.itemParams && (this.itemParams = {});

            lang.mixin(this.itemParams, {
                editorModelType: this.editorModelType,
                selectorType: this.selectorType
            });
        },

        buildRendering: function () {

            this.inherited(arguments);

            if (this.selectorContainerType) {
                array.forEach(this.selections, this._createChildItem, this);
            }
        },

        destroy: function () {

            var itemWidget;
            while (itemWidget = this._itemWidgets.pop()) {
                itemWidget.destroyRecursive();
            }

            this.inherited(arguments);
        },

        focus: function () {
            // summary:
            //      Focus the widget.
            // tags:
            //      public

            try {
                if (!(this._itemWidgets instanceof Array) || this._itemWidgets.length === 0) {
                    return;
                }

                var focusableNode = typeof this._itemWidgets[0].getFocusableNode === 'function'
                    && this._itemWidgets[0].getFocusableNode();
                focusableNode && focusUtil.focus(focusableNode);
            }
            catch (e) { /*quiet*/ }
        },

        getCalculatedValue: function () {
            // summary:
            //      Abstract function to get calculated value of this widget.
            // returns: [Object]
            //      
            // tags:
            //      public, abstract
        },

        onChange: function (/*===== newValue =====*/) {
            // summary:
            //      Callback when this widget's value is changed.
            // tags:
            //      callback
        },

        onBlur: function () {
            // summary:
            //      Callback when this widget loses focus.
            // tags:
            //      callback
        },

        onFocus: function () {
            // summary:
            //      Callback when this widget gains focus.
            // tags:
            //      callback
        },

        // =======================================================================
        // Protected stubs
        // =======================================================================

        _getItemWidgetsAttr: function () {
            // summary:
            //      Gets collection of item widget.
            // returns: [Array]
            //      A collection of item widget.
            // tags:
            //      protected

            return this._itemWidgets;
        },

        _setValueAttr: function (value) {
            // tags:
            //      protected

            this._set('value', value);
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _onBlur: function () {

            this.inherited(arguments);

            this.onBlur();
        },

        _calculateValue: function () {
            // summary:
            //      Calculate value for this widget.
            // tags:
            //      private

            this._set('value', this.getCalculatedValue());
        },

        _createChildItem: function (/*Object*/item) {
            // summary:
            //      Build an option widget from the given item data object and then add it to the collection.
            // item: [Object]
            //      Item data object that used to build an option widget.
            // tags:
            //      private

            var itemParams = {};
            if (this.itemParams) {
                itemParams = lang.clone(this.itemParams);
            }

            lang.mixin(itemParams, {
                item: lang.delegate(item, { readOnly: this.readOnly }),
                selectedItemValue: this.selectedItemValue,
                selectorReadOnly: this.readOnly,
                selectorValue: item.value,
                selectorText: item.text,
                searchConditions: {
                    key: this._getSearchKey(item.value)
                }
            });

            when(this.getInstanceFromType(this.selectorContainerType, itemParams), lang.hitch(this, this._setupItemWidget));
        },

        _setupItemWidget: function (/*Object*/itemWidget) {
            // summary:
            //      
            // itemWidget: [Object]
            //      An instance of 'dijit/_Widget' class
            // tags:
            //      private

            if (!itemWidget) {
                return;
            }

            this._itemWidgets.push(itemWidget);

            domClass.add(itemWidget.domNode, this.itemContainerClass);
            domConstruct.place(itemWidget.domNode, this.domNode, 'last');

            this.own(
                itemWidget.on('selectorChanged', lang.hitch(this, function () {
                    this._calculateValue();
                    this.onChange(this.value);
                }))
            );
        },

        _getSearchKey: function (/*String*/value) {
            // summary:
            //      Gets searchable key from given value.
            // value: [String]
            //      Raw value used to extracts searchable key from.
            // returns: [String]
            //      Searchable key string.
            // tags:
            //      private

            if (value.indexOf(this._recordFieldSeparator) === -1) {
                return value;
            }

            return value.split(this._recordFieldSeparator).shift();
        }

    });

});