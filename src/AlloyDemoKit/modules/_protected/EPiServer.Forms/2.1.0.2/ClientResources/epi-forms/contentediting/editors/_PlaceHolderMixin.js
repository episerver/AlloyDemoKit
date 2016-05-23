define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',
// dijit
    'dijit/registry'
],
function (
// dojo
    declare,
    lang,
// dijit
    registry
) {

    // module:
    //      epi-forms/contentediting/editors/_PlaceHolderMixin
    // summary:
    //      
    // tags:
    //      protected

    return declare([], {

        // =======================================================================
        // Protected stubs
        // =======================================================================

        _setTokenKeyFor: function (/*Object*/item, /*Array*/providers) {
            // summary:
            //      Listen on onClick event of each item in token drop-down button.
            //      If this event fired, get current position of the cursor and then place the selected token at the position.
            // item: [Object]
            //      Selected token key (without '#' wrapped).
            // providers: [Array]
            //      Collection of handlers that used to set token key to a focusing target.
            // tags:
            //      protected

            var i = 0,
                totalItems = providers.length,
                callback = null;
            for (; i < totalItems; i++) {
                callback = lang.hitch(this, providers[i], item.key);
                if (callback()) {
                    return;
                }
            }
        },

        _setTokenKeyForTextBox: function (/*String*/tokenKey) {
            // summary:
            //      Sets formatted token for an instance of 'dijit/form/TextBox' class.
            // tokenKey: [String]
            //      Original token key string
            // returns: [Boolean]
            //      FALSE: Incase cannot set value.
            //      TRUE: Incase value successfully set.
            // tags:
            //      protected

            var lastFocusedTarget = this.get('lastFocusedTarget');
            if (typeof lastFocusedTarget !== 'string') {
                return false;
            }

            var lastFocusedWidget = registry.byId(lastFocusedTarget);
            if (!lastFocusedWidget) {
                return false;
            }

            var originalValue = lastFocusedWidget.get('value'),
                caretPosition = document.getElementById(lastFocusedTarget).selectionStart;

            lastFocusedWidget.set('value', originalValue.substring(0, caretPosition) + this._getFormattedTokenKey(tokenKey) + originalValue.substring(caretPosition));

            return true;
        },

        _setTokenKeyForTinyMCE: function (/*String*/tokenKey) {
            // summary:
            //      Sets formatted token for an instance of 'epi-cms/contentediting/editors/TinyMCEEditor' class.
            // tokenKey: [String]
            //      Original token key string
            // returns: [Boolean]
            //      FALSE: Incase cannot set value.
            //      TRUE: Incase value successfully set.
            // tags:
            //      protected

            var lastFocusedTarget = this.get('lastFocusedTarget');
            if (typeof lastFocusedTarget !== 'object') {
                return false;
            }

            var caretPosition = lastFocusedTarget.selection.getRng().startOffset;
            lastFocusedTarget.execCommand('mceInsertContent', false, this._getFormattedTokenKey(tokenKey), caretPosition);

            return true;
        },

        _getFormattedTokenKey: function (/*String*/originalKey) {
            // summary:
            //      Gets token key from the original key in the indicated format.
            //      Indicated format should be (original key wrapped by '#' at the begin and end point):
            //          #originalKey#
            // originalKey: [String]
            //      The raw token key.
            // returns: [String]
            //      Token key in the indicated format.
            // tags:
            //      protected

            return '#' + originalKey + '#';
        }

    });

});