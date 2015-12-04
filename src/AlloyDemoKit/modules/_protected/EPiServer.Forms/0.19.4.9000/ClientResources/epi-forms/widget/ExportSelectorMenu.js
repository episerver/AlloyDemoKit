define([
// dojo
    'dojo/_base/declare',
// dijit
    'dijit/MenuItem',
// epi-addons
    'epi-forms/widget/SelectorMenuBase',
// resources
    'epi/i18n!epi/cms/nls/episerver.forms.formdataview'
],
function (
// dojo
    declare,
// dijit
    MenuItem,
// epi-addons
    SelectorMenuBase,
// resources
    resources
) {

    // module:
    //      epi-forms/widget/ExportSelectorMenu
    // summary:
    //      Export selector menu widget.
    // tags:
    //      public

    return declare([SelectorMenuBase], {

        headingText: resources.export,

        createMenuItem: function(/*Object*/item){
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
                onClick: function () {
                    typeof item.onExport === 'function' && item.onExport(item.exportType);
                }
            });
        }

    });

});