define([
// dojo
    'dojo/_base/array',
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/store/Memory',

    'dojo/Evented',
    'dojo/Deferred',
// dijit
    'dijit/_TemplatedMixin',
    'dijit/_Widget',
    'dijit/_WidgetsInTemplateMixin',

    'dijit/form/FilteringSelect',
// resources
    'dojo/text!./templates/FilterSelector.html'
],
function (
// dojo
    array,
    declare,
    lang,

    Memory,

    Evented,
    Deferred,
// dijit
    _TemplatedMixin,
    _Widget,
    _WidgetsInTemplateMixin,

    FilteringSelect,
// resources
    template
) {

    // module:
    //      epi-forms/widget/_ChoiceItemWith
    // summary:
    //      This class implements a custom widget containing a FilterSelector as the only child.
    //      The custom widget can be used as an extended widget for the editors which need to support 
    //      The auto-complete function for users when they type on the combo box.
    //      The FilterSelector will display the value associated with the widget
    // tags:
    //      public

    return declare([_Widget, _TemplatedMixin, _WidgetsInTemplateMixin, Evented], {

        templateString: template,
        value: null,

        _selectionsDefer: null,
        _filteringSelectDefer: null,

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        postCreate: function () {

            this.inherited(arguments);

            this._selectionsDefer = new Deferred();
            this._filteringSelectDefer = new Deferred();

            this._setupLayout();
            this._setupEvents();
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _setupLayout: function () {

            this._selectionsDefer.then(lang.hitch(this, this._createFilteringSelect));

        },

        _setupEvents: function () {

            this.own(
                this.watch('value', lang.hitch(this, this._onValueChanged)),
                this.watch('selections', lang.hitch(this, this._onSelectionsChanged))
            );

            this._filteringSelectDefer.then(lang.hitch(this, function (filteringSelect) {

                this.own(
                    filteringSelect.on('change', lang.hitch(this, function (selectedValue) {
                        this.set('value', selectedValue);
                        this.emit('change', selectedValue);
                    }))
                );

            }));
        },

        _createFilteringSelect: function (selections) {

            var options = array.map(selections, function (item) {
                return {
                    'id': item.value,
                    'name': item.text
                }
            });

            var filteringSelect = new FilteringSelect({
                store: new Memory({
                    data: options,
                    value:this.get('value')
                }),
                searchAttr: 'name'
            });

            filteringSelect.startup();
            filteringSelect.placeAt(this.domNode);
            this._filteringSelectDefer.resolve(filteringSelect);
        },

        _onValueChanged: function (name, oldValue, newValue) {
            // summary:
            //      reset the selected item of FilterSelector when the value associated with the widget is changed by user.

            this._filteringSelectDefer.then(lang.hitch(this, function (filteringSelect) {
                var selectedItem = filteringSelect.store.get(newValue);
                filteringSelect.set('item', selectedItem);
            }));

        },

        _onSelectionsChanged: function (name, oldValue, newValue) {
            // summary:
            //      When the list of options returned from external systems are available, the defer in the function _getSelection will be resolved and
            //      the data which is stored in selecitons variable will be returned to requests.

            this._selectionsDefer.resolve(newValue);

        },

        _getSelections: function () {
            // summary:
            //      return the list of options returned by external systems.

            if (!this.selections) {
                return this._selectionsDefer;
            };

            return this.selections;
        }

    });

});