define([
// dojo
    'dojo/_base/array',
    'dojo/_base/declare',
// epi
    'epi-cms/widget/SelectorMenuBase'
],
function (
// dojo
    array,
    declare,
// epi
    SelectorMenuBase
) {

    // module:
    //      epi-forms/widget/SelectorMenuBase
    // summary:
    //      Base class to build a drop-down button that used in EPiServer Forms.
    // tags:
    //      protected

    return declare([SelectorMenuBase], {

        createMenuItem: function(/*Object*/item){
            // summary:
            //      Create an instance of 'dijit/MenuItem' from the given data object.
            // item: [Object]
            //      Data object that used to build a menu item widget.
            // returns: [Object]
            //      Returns an instance of 'dijit/MenuItem' class.
            // tags:
            //      public, abstract
        },

        _setMenuItemsAttr: function (/*Object*/value) {
            // summary:
            //      Set menu item data collection.
            // value: [Object]
            //      Collection of menu item object
            // tags:
            //      protected

            this._set('menuItems', value);

            this._setupMenuItems();
        },

        _setupMenuItems: function () {
            // summary:
            //      Build menu items for drop-down.
            // tags:
            //      private

            if (!(this.menuItems instanceof Array) || this.menuItems.length === 0) {
                return;
            }

            var menuItem = null;
            array.forEach(this.menuItems, function (/*Object*/item) {

                if (!item) {
                    return;
                }

                menuItem = this.createMenuItem(item);
                if (!menuItem) {
                    return;
                }

                this.addChild(menuItem);

            }, this);
        }

    });

});