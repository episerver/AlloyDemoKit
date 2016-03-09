define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/Deferred',
    'dojo/when',
// dijit
    'dijit/form/DropDownButton',
// epi-addons
    'epi-forms/_UtilityMixin'
],
function (
// dojo
    declare,
    lang,

    Deferred,
    when,
// dijit
    DropDownButton,
// epi-addons
    _UtilityMixin
) {

    // module:
    //      epi-forms/widget/DropDownButton
    // summary:
    //      EPiServer Forms drop-down button.
    // tags:
    //      protected

    return declare([_UtilityMixin, DropDownButton], {

        // dropDownSelectorType: [Object]
        //      
        dropDownSelectorType: null,

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

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

        // =======================================================================
        // Protected stubs
        // =======================================================================

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

        // =======================================================================
        // Private stubs
        // =======================================================================

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

            when(this._getModel(), lang.hitch(this, function (model) {
                if (!model || typeof model.getItems !== 'function') {
                    return;
                }

                when(model.getItems(this.searchConditions), lang.hitch(this, function (items) {

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
            }));
        },

        _getModel: function () {
            // summary:
            //      Gets view model for this widget
            // returns: [Object]
            //      An instance of 'dojo/Deferred' class
            // tags:
            //      private

            var deferred = new Deferred();
            if (this._model) {
                deferred.resolve(this._model);

                return deferred;
            }

            if (this.modelTypeName) {
                when(this.getInstanceFromType(this.modelTypeName), function (model) {
                    this._model = model;
                    deferred.resolve(this._model);
                });

                return deferred;
            }

            if (this.modelClassName) {
                this._model = new this.modelClassName();
                deferred.resolve(this._model);
            }

            return deferred;
        }

    });

});