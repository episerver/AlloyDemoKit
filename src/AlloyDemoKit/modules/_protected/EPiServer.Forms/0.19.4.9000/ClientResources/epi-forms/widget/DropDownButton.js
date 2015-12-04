define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/when',
// dijit
    'dijit/form/DropDownButton'
],
function (
// dojo
    declare,
    lang,

    when,
// dijit
    DropDownButton
) {

    // module:
    //      epi-forms/widget/DropDownButton
    // summary:
    //      EPiServer Forms drop-down button.
    // tags:
    //      protected

    return declare([DropDownButton], {

        // dropDownSelectorType: [Object]
        //      
        dropDownSelectorType: null,

        _setMenuItemsAttr: function (/*Object*/value) {
            // summary:
            //      Set menu item data collection.
            // value: [Object]
            //      Collection of menu item data object
            // tags:
            //      protected

            if (!this.dropDown) {
                return;
            }

            this.dropDown.set('menuItems', value);
        },

        buildRendering: function () {

            this.inherited(arguments);

            this._setupLayout();
        },

        onItemSelected: function (/*Object*/item) {
            // summary:
            //      Listen on onClick event of each item in token drop-down button.
            //      If this event fired, expose the selected token key.
            // item: [Object]
            //      Selected item data.
            // tags:
            //      callback
        },

        _setupLayout: function () {
            // summary:
            //      Setup layout for this widget.
            // tags:
            //      private

            if (this.dropDownSelectorType) {
                this.own(this.dropDown = new this.dropDownSelectorType());
            }

            this._buildMenuItems();
        },

        _buildMenuItems: function () {
            // summary:
            //      Build menu items
            // tags:
            //      private

            if (!this.model || typeof this.model.getItems !== 'function') {
                return;
            }

            when(this.model.getItems(this.searchConditions), lang.hitch(this, function (items) {

                if (!(items instanceof Array) || items.length === 0) {
                    return;
                }

                if (!this.dropDown) {
                    return;
                }

                var menuItems = [],
                    menuItem = null,
                    i = 0,
                    totalItems = items.length;
                for (; i < totalItems; i++) {
                    menuItem = items[i];
                    if (!menuItem) {
                        continue;
                    }

                    menuItems.push({
                        label: menuItem.label || menuItem.key,
                        description: menuItem.description || menuItem.value,
                        onItemSelected: lang.hitch(this, this.onItemSelected, menuItem)
                    });
                }

                this.set('menuItems', menuItems);

            }));
        }

    });

});