define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/aspect',

    'dojo/dom-class',
    'dojo/dom-style',
// dijit
    'dijit/Destroyable',
// epi
    'epi-cms/contentediting/editors/DefaultGridAssembler',
// epi-addons
    'epi-forms/dgrid/Formatters'
],
function (
// dojo
    declare,
    lang,

    aspect,

    domClass,
    domStyle,
// dijit
    Destroyable,
// epi
    DefaultGridAssembler,
// epi-addons
    Formatters
) {

    // module:
    //      epi-forms/contentediting/editors/DefaultGridAssembler
    // summary:
    //      Override 'epi-cms/contentediting/editors/DefaultGridAssembler' class in order to injects formatter for desired column(s).
    // tags:
    //      public

    return declare([DefaultGridAssembler, Destroyable], {

        // _gridNoDataClass: [private] String
        //      CSS class to marks dgrid with state of no data.
        _gridNoDataClass: 'epi-forms-dgrid-no-data',

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        build: function (/*DOM*/gridNode, /*DOM*/listCommandNode) {
            // summary:
            //      Build the grid from given parameters.
            // gridNode: DomNode
            //      The dom node where the grid is created on.
            // listCommandNode: DomNode
            //      The dom node where the list command is created on.
            // tags:
            //      public, abstract

            this._injectRichTextFormatter();

            this._grid = this.inherited(arguments);
            this._decorateGrid();

            return this._grid;
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _injectRichTextFormatter: function () {
            // summary:
            //      Injects 'richTextTemplate' dgrid formatter for each matched column.
            // tags:
            //      private

            var richTextColumns = this.gridSettings.richTextColumns;
            if (richTextColumns instanceof Array && richTextColumns.length > 0 && this.columnDefinitions) {
                for (var propertyName in this.columnDefinitions) {
                    if (richTextColumns.indexOf(propertyName) !== -1) {
                        this.columnDefinitions[propertyName]['formatter'] = Formatters.richTextTemplate;
                    }
                }
            }
        },

        _decorateGrid: function () {
            // summary:
            //      Decorates styles for this dgrid
            // tags:
            //      private

            if (!this._grid) {
                return;
            }

            this.own(
                aspect.before(this._grid, 'renderArray', lang.hitch(this, this._adjustGridHeight))
            );
        },

        _adjustGridHeight: function (results, beforeNode, options) {
            // summary:
            //      Run each time dgrid refresh its content view.
            //      Adjusts height of dgrid.
            // tags:
            //      private

            results instanceof Array && results.length > 0 ? this._styleGridHaveData() : this._styleGridNoData();

            return [results, beforeNode, options];
        },

        _styleGridNoData: function () {
            // summary:
            //      Applies styles for dgrid incase it have no data.
            // tags:
            //      private

            domClass.add(this._grid.domNode, this._gridNoDataClass);

            domStyle.set(this._grid.domNode, {
                height: '7em'
            });
        },

        _styleGridHaveData: function () {
            // summary:
            //      Applies styles for dgrid incase it have data.
            // tags:
            //      private

            domClass.remove(this._grid.domNode, this._gridNoDataClass);

            domStyle.set(this._grid.domNode, { height: '' });
        }

    });

});