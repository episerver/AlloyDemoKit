define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/aspect',
// dijit
    'dijit/_TemplatedMixin',
    'dijit/_WidgetsInTemplateMixin',
// epi
    'epi-cms/widget/_GridWidgetBase',
// resources
    'dojo/text!./templates/FieldSelectorDialog.html',
    'epi/i18n!epi-cms/nls/episerver.forms.contenttypescomponent'
],
function (
// dojo
    declare,
    lang,

    aspect,
// dijit
    _TemplatedMixin,
    _WidgetsInTemplateMixin,
// epi
    _GridWidgetBase,
// resources
    template,
    resources
) {

    // module:
    //      epi-forms/widget/FieldSelectorDialog
    // tags:
    //      internal

    return declare([_GridWidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin], {

        res: resources,

        templateString: template,

        // storeKeyName: [public] string
        //      The key of the store used to retrieve the store from the store registry.
        storeKeyName: 'epi-forms.formselement',

        contextChangeEvent: null,

        _selectedData: null,

        buildRendering: function () {
            // summary:
            //      Construct the UI for this widget. this.gridNode is initialized as a dGrid.
            // tags:
            //      protected, extensions

            var gridSettings = lang.mixin({
                columns: {
                    name: {
                        renderCell: lang.hitch(this, '_renderContentItem')
                    }
                },
                store: this.store,
                query: {
                    parentLink: this.model._currentContext.parentLink,
                    id: this.model._currentContext.id,
                    query: 'GetAllDependees'
                },
                showHeader: false
            }, this.defaultGridMixin);

            this.inherited(arguments);

            this.own(
                this.grid = new this._gridClass(gridSettings, this.gridNode),
                this.grid.on('dgrid-select', lang.hitch(this, function (event) {
                    this._selectedData = event.rows[0].data;
                })),
                aspect.around(this.grid, 'insertRow', lang.hitch(this, this._aroundInsertRow))
            );
        },

        fetchData: function () {
            // summary:
            //      Fetches data by setting a query on the grid. A get children query will be performed on the store.
            // tags:
            //      protected, extensions

            this.grid.refresh();
        },

        refresh: function () {

            this._selectedData = null;
            this.grid.refresh();
        },

        _aroundInsertRow: function (original) {
            // summary:
            //      Called 'around' the insertRow method to fix the grids less than perfect selection.
            // tags:
            //      protected

            return lang.hitch(this, function (object, parent, beforeNode, i, options) {

                // Call original method
                var row = original.apply(this.grid, arguments);
                if (this.value === object.contentLink) {
                    this.grid.select(row);
                }

                return row;
            });

        },

        _getValueAttr: function () {
            // summary:
            //      Value's getter
            // tags:
            //      protected

            if (this._selectedData) {
                return this._selectedData.contentLink;
            }

            return null;
        }

    });

});