define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/when',
// epi-addons
    'epi-forms/widget/_ChoiceItemWith',
    'epi-forms/widget/_SelectionMixin'
],
function (
// dojo
    declare,
    lang,

    when,
// epi-addons
    _ChoiceItemWith,
    _SelectionMixin
) {

    // module:
    //      epi-forms/widget/ChoiceItemWithSelection
    // summary:
    //      Radio button widget included clickable label and drop-down button.
    //      'this.extendedWidgetType' should be:
    //      - 'epi-cms/contentediting/editors/SelectionEditor' or,
    //      - 'epi-cms/contentediting/editors/SelectionEditor''s concrete type
    // tags:
    //      public

    return declare([_ChoiceItemWith], {

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        buildRendering: function () {

            this.inherited(arguments);

            this._setupExtendedWidget();
        },

        // =======================================================================
        // Protected stubs
        // =======================================================================

        // =======================================================================
        // Private stubs
        // =======================================================================

        _setupExtendedWidget: function () {
            // summary:
            //      Decorates layout for this widget.
            // tags:
            //      private

            if (!this.model) {
                when(this.getInstanceFromType(this.editorModelType), lang.hitch(this, this._bindDataForExtendedWidget));
            } else {
                this._bindDataForExtendedWidget(this.model);
            }
        },

        _bindDataForExtendedWidget: function (model) {
            // summary:
            //      Bind data for extended widget.
            // model: [Object]
            //      View model for created drop-down button.
            // tags:
            //      private

            when(model.getItems(this.searchConditions), lang.hitch(this, function (items) {

                when(this._getExtendedWidget(), lang.hitch(this, function (extendedWidget) {

                    if (!extendedWidget) {
                        return;
                    }

                    declare.safeMixin(extendedWidget, _SelectionMixin);

                    extendedWidget.set('selections', this._getSelectionsData(items));
                    this.set('extendedWidgetValue', this.item);

                    this.own(
                        extendedWidget.on('change', lang.hitch(this, this._updateSelectorValue))
                    );
                }));
            }));
        },

        _getSelectionsData: function (/*Array*/items) {
            // summary:
            //      Gets selections data from given items array.
            // items: [Array]
            //      Item data collection.
            // tags:
            //      private

            var selections = [];
            if (!(items instanceof Array) || items.length === 0) {
                return selections;
            }

            var i = 0,
                totalItems = items.length,
                item = null;
            for (; i < totalItems; i++) {
                item = items[i];
                if (!item) {
                    continue;
                }

                selections.push({
                    'text': item.value,
                    'value': item.key
                });
            }

            return selections;
        }

    });

});