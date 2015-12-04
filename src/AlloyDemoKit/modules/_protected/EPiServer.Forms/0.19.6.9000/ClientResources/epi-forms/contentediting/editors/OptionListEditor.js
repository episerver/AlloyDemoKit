define([
// dojo
    'dojo/_base/array',
    'dojo/_base/declare',

    'dojo/dom-class',
// epi-addons
    'epi-forms/contentediting/editors/CollectionEditor'
],
function (
// dojo
    array,
    declare,

    domClass,
// epi-addons
    CollectionEditor
) {

    // module:
    //      epi-forms/contentediting/editors/OptionListEditor
    // summary:
    //      Option list editor widget
    // tags:
    //      public

    return declare([CollectionEditor], {

        // isMultiSelect: [public] Boolean
        //      If TRUE, allow user set checked properties for multi items otherwise only 1 item can be set checked.
        isMultiSelect: true,

        // =======================================================================
        // Overrided stubs
        // =======================================================================

        buildRendering: function () {

            this.inherited(arguments);

            domClass.add(this.domNode, 'epi-forms-optionList');
        },

        onExecuteDialog: function () {
            // summary:
            //      Override this method to modify behaviour when user select checked/unchecked for radio button list.
            // tags:
            //      protected, extensions

            var item = this._itemEditor.get('value');

            // If not allow multi select, update checked properties for each item if editing item is set as checked
            if (!this.isMultiSelect && item.checked) {
                array.forEach(this.model.get('items'), function (existingItem, i) {
                    if (existingItem.checked && i != this._editingItemIndex) {
                        existingItem.checked = false;
                        this.model.saveItem(existingItem, i);
                    }
                }, this);
            }

            this._editingItemIndex !== undefined
                ? this.model.saveItem(item, this._editingItemIndex)
                : this.model.addItem(item);
        },

        _setDialogConfirmActionStatus: function (/*Object*/item) {
            // summary:
            //      Sets dialog's buttons status.
            // item: [Object]
            //      Option item data object
            // tags:
            //      protected, extensions

            var disabled = !item
                || item.caption == '' || item.caption.trim() == ''
                || item.value == '' || item.value.trim() == '';

            this._dialog.onActionPropertyChanged({
                name: this._dialog._okButtonName
            }, 'disabled', disabled);
        }

    });

});