define([
// dojo
    'dojo/_base/declare',
// dijit
    'dijit/MenuItem',
// epi-addons
    'epi-forms/widget/SelectorMenuBase'
],
function (
// dojo
    declare,
// dijit
    MenuItem,
// epi-addons
    SelectorMenuBase
) {

    // module:
    //      epi-forms/widget/ExternalSystemSelectorMenu
    // summary:
    //      External property selector menu widget.
    // tags:
    //      public

    return declare([SelectorMenuBase], {

        createMenuItem: function (/*Object*/item) {
            // summary:
            //      Create an instance of 'dijit/MenuItem' from the given data object.
            // item: [Object]
            //      Data object that used to build a menu item widget.
            // returns: [Object]
            //      Returns an instance of 'dijit/MenuItem' class.
            // tags:
            //      public, extensions

            return new MenuItem({
                label: item.label,
                title: item.description,
                onClick: item.onItemSelected
            });
        }

    });

});