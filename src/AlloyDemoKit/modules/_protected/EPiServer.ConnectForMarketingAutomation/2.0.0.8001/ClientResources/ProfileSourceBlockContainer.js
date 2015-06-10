define([
    "dojo/_base/declare",
    "dojo/_base/lang",

    "epi/shell/layout/SimpleContainer"
],
function (
    declare,
    lang,

    SimpleContainer
) {

    return declare([SimpleContainer], {
        listTypeSourceDropdown: null,
        profileSourceDropdown: null,

        addChild: function (child) {
            // Summar: Add a widget to the container

            this.inherited(arguments);

            if (child.name.indexOf("listTypeSource") >= 0) {
                // If it's the listTypeSource drop down list
                this.listTypeSourceDropdown = child;

                // Connect to change event to update the profileSource drop down list
                this.own(this.listTypeSourceDropdown.on("change", lang.hitch(this, this._updateProfileSourceDropdown)));
            } else if (child.name.indexOf("profileSource") >= 0) {
                // If it's the profileSource drop down list
                this.profileSourceDropdown = child;

                // Update the profileSource drop down
                this._updateProfileSourceDropdown(this.listTypeSourceDropdown.value);
            }
        },

        _updateProfileSourceDropdown: function (listTypeSource) {
            // Summary: Update the profileSource drop down list according to the selected listTypeSource

            // Clear the current value
            this.profileSourceDropdown.set("value", null);

            // Set the filter
            this.profileSourceDropdown.set("filter", function (profileSource) {
                // Oops, the profileSource code is prefixed with listTypeSource code, for the simplicity
                return profileSource.value.indexOf(listTypeSource) === 0;
            });
        }
    });
});