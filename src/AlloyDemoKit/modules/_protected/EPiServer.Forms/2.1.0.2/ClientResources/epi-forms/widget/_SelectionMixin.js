define([
// dojo
    'dojo/dom-class'
],
function (
// dojo
    domClass
) {

    // module:
    //      epi-forms/widget/_SelectionMixin
    // summary:
    //      
    // tags:
    //      private

    return {

        openDropDown: function () {
            // summary:
            //      Opens the dropdown for this widget.   To be called only when this.dropDown
            //      has been created and is ready to display (ie, it's data is loaded).
            // returns:
            //      return value of dijit/popup.open()
            // tags:
            //      protected

            if (this.dropDown) {
                domClass.add(this.dropDown.domNode, 'epi-forms-selection');
                this.dropDown.menuTableNode && domClass.add(this.dropDown.menuTableNode, 'epi-forms-selectionMenu');
            }

            return this.inherited(arguments);
        },

        _getMenuItemForOption: function (option) {
            // summary:
            //      For the given option, return the menu item that should be used to display it.

            var item = this.inherited(arguments);
            domClass.add(item.containerNode, 'dojoxEllipsis');

            return item;
        },

        // TECHNOTE:
        //      At the moment, should overrides '_setDisplay()' PRIVATE function.
        //      Injects 'dojoEllipsis' class to option node of this selection widget.

        _setDisplay: function (/*String*/newDisplay) {
            // summary:
            //      Sets the display for the given value (or values)

            var lbl = newDisplay || this.emptyLabel;
            this.containerNode.innerHTML = '<span role="option" class="dijitReset dijitInline ' + this.baseClass.replace(/\s+|$/g, "Label ") + 'dojoxEllipsis">' + lbl + '</span>';
        }

    };

});