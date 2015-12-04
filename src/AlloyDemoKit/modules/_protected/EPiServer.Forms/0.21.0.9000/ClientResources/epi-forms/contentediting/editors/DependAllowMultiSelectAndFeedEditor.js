define([
// dojo
    'dojo/_base/array',
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/dom-style',
    'dojo/when',
// epi
    'epi/dependency',
    'epi-cms/contentediting/command/Editing',
// epi-forms
    'epi-forms/contentediting/editors/OptionListEditor',
    'epi-forms/ModuleSettings'
],
function (
// dojo
    array,
    declare,
    lang,

    domStyle,
    when,
// epi
    dependency,
    EditingCommands,
// epi-forms,
    OptionListEditor,
    ModuleSettings
) {

    // module:
    //      epi-forms/contentediting/editors/DependAllowMultiSelectEditor
    // summary:
    //      
    // tags:
    //      public

    return declare([OptionListEditor], {

        _store: null,

        _contentViewModel: null,

        _allowMultiSelectPropertyName: 'allowMultiSelect',

        _feedPropertyName: 'feed',

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        postCreate: function () {
            // tags:
            //      protected, extensions

            var registry = dependency.resolve('epi.storeregistry');
            this._store = registry.get('epi.cms.content.light');
            this._contentViewModel = EditingCommands.get('model');

            // this editor depend on [Allow Multiple Select] property,
            // if [Allow Multiple Select] property is set to true then allow multi selection on this editor,
            // otherwise allow single selection
            this.isMultiSelect = this._contentViewModel.getProperty(this._allowMultiSelectPropertyName);
            this.connect(this._contentViewModel, 'onPropertyEdited', lang.hitch(this, function (propertyName, value) {

                if (propertyName == this._allowMultiSelectPropertyName) {
                    this.isMultiSelect = value;
                    // reset checked items if the property change from true to false
                    if (!value) {
                        array.forEach(this.model.get('items'), function (existingItem, i) {
                            existingItem.checked = false;
                            this.model.saveItem(existingItem, i);
                        }, this);
                    }
                } else if (propertyName == this._feedPropertyName) {
                    // if user choose [Use manual input] then show the grid for enter selecting items
                    this._setOptionItemsEditorDisplay(value == ModuleSettings.useManualInput);
                }

            }));

            this.inherited(arguments);
        },

        startup: function () {

            this.inherited(arguments);

            var feedValue = this._contentViewModel.getProperty(this._feedPropertyName);
            this._setOptionItemsEditorDisplay(feedValue == ModuleSettings.useManualInput);
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _setOptionItemsEditorDisplay: function (show) {
            // summary:
            //      show/hide OptionItems editor.
            // tags:
            //      private

            // show/hide whole field item which contain this editor
            domStyle.set(this.domNode.parentNode, 'display', show ? '' : 'none');
        },

        _getGridDefinition: function () {
            // summary:
            //      Returns grid's columns definition.
            // tags:
            //      override

            var columns = this.inherited(arguments);
            // display name of the image instead of ID
            lang.mixin(columns.source, {
                renderCell: lang.hitch(this, function (item, value, node, options) {

                    if (!item.source) {
                        return;
                    }

                    when(this._store.get(item.source), lang.hitch(this, function (content) {
                        node.innerHTML = content.name;
                    }));

                })
            });

            return columns;
        }

    });

});