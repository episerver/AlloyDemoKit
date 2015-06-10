define([
    "dojo/_base/declare",
    "dojo/_base/array",

    // Detect EPiServer version and change dojo root to 'epi-cms' for version 7.5+
    "epi/cms/contentediting/editors/SelectionEditor"
],
function (
    declare,
    array,

    SelectionEditor
) {

    return declare([SelectionEditor], {
        _allOptions: null,

        filter: null,

        _setOptionsAttr: function (options) {
            // summary: set the options

            this._allOptions = options;

            this.inherited(arguments, [array.filter(options, this.filter || function () {
                // return all options if no filter function provided.
                return true;
            }, this)]);
        },

        _setFilterAttr: function (filter) {
            // summary: set the option filter function

            this._set("filter", filter);

            this.set("options", this._allOptions);
        }
    });
});