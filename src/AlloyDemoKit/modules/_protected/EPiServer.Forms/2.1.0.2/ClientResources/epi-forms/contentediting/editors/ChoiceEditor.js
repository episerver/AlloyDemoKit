define([
// dojo
    'dojo/_base/array',
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/dom-class',
// epi-addons
    'epi-forms/contentediting/editors/_WidgetListEditor',
    'epi-forms/ModuleSettings'
],
function (
// dojo
    array,
    declare,
    lang,

    domClass,
// epi-addons
    _WidgetListEditor,
    ModuleSettings
) {

    // module:
    //      epi-forms/contentediting/editors/ChoiceEditor
    // summary:
    //      Radio button list widget.
    // tags:
    //      public

    return declare([_WidgetListEditor], {

        // _recordSeparator: [private] String
        //      
        _recordSeparator: ModuleSettings.recordSeparator,

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        buildRendering: function () {

            this.inherited(arguments);

            this._setupLayout();
        },

        getCalculatedValue: function () {
            // summary:
            //      Overrided function to get calculated value of this editor.
            // returns: [Object]
            //      
            // tags:
            //      public, extensions

            var selectors = this.get('itemWidgets');

            return this.selectorType === 'multiple'
                ? this._getCheckBoxesCalculatedValue(selectors)
                : this._getRadioButtonsCalculatedValue(selectors);
        },

        // =======================================================================
        // Protected stubs
        // =======================================================================

        _setValueAttr: function (/*String*/value) {
            // summary:
            //      Set value for this editor.
            // value: [String]
            //      
            // tags:
            //      protected, extensions

            this.inherited(arguments);

            this._setSelectorsValue(value);
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _setupLayout: function () {
            // summary:
            //      Build layout for this editor.
            // tags:
            //      private

            domClass.add(this.domNode, this.selectoryType === 'multiple' ? 'epi-forms-checkBoxList' : 'epi-forms-radioButtonList');
        },

        _getCheckBoxesCalculatedValue: function (/*Array*/selectors) {
            // summary:
            //      
            // selectors: [Array]
            //      
            // returns: [String]
            //      
            // tags:
            //      private

            var values = [];
            array.forEach(selectors, function (widget) {
                if (true === widget.get('selectorChecked')) {
                    values.push(widget.get('selectorValue'));
                }
            }, this);

            return values.join(this._recordSeparator);
        },

        _getRadioButtonsCalculatedValue: function (/*Array*/selectors) {
            // summary:
            //      
            // selectors: [Array]
            //      
            // returns: [String]
            //      
            // tags:
            //      private

            var selectedWidgets = array.filter(selectors, function (widget) {
                return widget.get('selectorChecked');
            });

            return selectedWidgets.length > 0 ? selectedWidgets[0].get('selectorValue') : null;
        },

        _setSelectorsValue: function (/*String*/value) {
            // summary:
            //      
            // value: [String]
            //      
            // tags:
            //      private

            if (!(this.selections instanceof Array) || this.selections.length === 0) {
                return;
            }

            this._selectionsInterval = setInterval(lang.hitch(this, function () {

                var selectors = this.get('itemWidgets');
                if (selectors instanceof Array && selectors.length > 0) {
                    this._selectionsInterval && clearInterval(this._selectionsInterval);

                    this.selectorType === 'multiple'
                        ? this._setCheckBoxesValue(selectors, value)
                        : this._setRadioButtonsValue(selectors, value);
                }

            }), 100);
        },

        _setCheckBoxesValue: function (/*Array*/selectors, /*String*/value) {
            // summary:
            //      
            // selectors: [Array]
            //      
            // value: [String]
            //      
            // tags:
            //      private

            var values = [];
            if (value) {
                values = value.split(this._recordSeparator);
            }

            array.forEach(selectors, function (widget) {
                widget.set('selectorChecked', true === array.some(values, function (selectorValue) {
                    return selectorValue === widget.get('selectorValue');
                }));
            });
        },

        _setRadioButtonsValue: function (/*Array*/selectors, /*String*/value) {
            // summary:
            //      
            // selectors: [Array]
            //      
            // value: [String]
            //      
            // tags:
            //      private

            array.forEach(selectors, function (widget) {
                widget.set('selectorChecked', widget.get('selectorValue') == value);
            });
        }

    });

});