define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/dom-class',
    'dojo/dom-construct',
// dijit
    'dijit/registry',
// epi-addons
    'epi-forms/contentediting/editors/CollectionEditor',

    'epi-forms/widget/FormContainer',
    'epi-forms/widget/PlaceHolderDropDownButton',

    // resources
    'epi/i18n!epi/cms/nls/episerver.forms.editview'
],
function (
// dojo
    declare,
    lang,

    domClass,
    domConstruct,
// dijit
    registry,
// epi-addons
    CollectionEditor,

    FormContainer,
    PlaceHolderDropDownButton,

    // resources
    resources
) {

    // module:
    //      epi-forms/contentediting/editors/EmailTemplateActorEditor
    // summary:
    //      Show token drop-down button.
    // tags:
    //      public

    return declare([CollectionEditor], {

        // itemEditorType: [public] Function
        //      The item editor class. By default, it is 'epi/shell/widget/FormContainer'
        itemEditorType: FormContainer,

        _setupItemEditor: function () {
            // summary:
            //      Decorates editor after its initialization phase finished.
            // tags:
            //      protected, extensions

            this.inherited(arguments);

            this._setupWidgetLayout();
            this._setupWidgetEvents();
        },

        _setupWidgetLayout: function () {
            // summary:
            //      Setup layout for this widget:
            //      - Add token selector drop-down list button widget.
            // tags:
            //      private

            if (!this._dialog) {
                return;
            }

            domClass.add(this._dialog.domNode, 'epi-forms-emailTemplate');

            this._setupDialogHeadingSection();
        },

        _setupWidgetEvents: function () {
            // summary:
            //      Setup events for this widget.
            // tags:
            //      private

            if (!this._dialog) {
                return;
            }

            if (this._itemEditor) {
                this._dialog.own(
                    this.connect(this._itemEditor, 'onFieldFocused', lang.hitch(this, this._onFieldFocused))
                );
            }

            if (this._dropDownButton) {
                this._dialog.own(
                    this.connect(this._dropDownButton, 'onItemSelected', lang.hitch(this, this._onItemSelected))
                );
            }
        },

        _setupDialogHeadingSection: function () {
            // summary:
            //      Create a new drop-down button for token list and then place it inside heading section of the dialog.
            // tags:
            //      private

            // TECHNOTE:
            //      Must pass ' ' in order to make heading section displayable.
            this._dialog.set('heading', ' ');

            this._dialog.own(
                this._dropDownButton = new PlaceHolderDropDownButton()
            );

            // TECHNOTE:
            //      At the moment, the 'EPiServer Front-End Style Guide' do not mentions about positioning of an element.
            //      Both '.ui-helper-clearfix' and '.epi-floatRight' CSS classes inside 'DojoDashboardCompatibility.css'
            domClass.add(this._dialog.headingNode, 'ui-helper-clearfix');
            domClass.add(this._dropDownButton.domNode, 'epi-floatRight');

            domConstruct.place(this._dropDownButton.domNode, this._dialog.headingNode);
        },

        _onItemSelected: function (/*Object*/item) {
            // summary:
            //      Listen on onClick event of each item in token drop-down button.
            //      If this event fired, get current position of the cursor and then place the selected token at the position.
            // item: [Object]
            //      Selected token key (without '#' wrapped).
            // tags:
            //      private

            var providers = ['_setTokenKeyForTextBox', '_setTokenKeyForTinyMCE'],
                i = 0,
                totalItems = providers.length,
                callback = null;
            for (; i < totalItems; i++) {
                callback = lang.hitch(this, providers[i], item.key);
                if (callback()) {
                    return;
                }
            }
        },

        _onFieldFocused: function (/*String|Object*/target) {
            // summary:
            //      Sets last focused target.
            // target: [String|Object]
            //      Focused element id or focused object.
            // tags:
            //      private

            this.set('lastFocusedTarget', target);
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
            //      private

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
            //      private

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
            //      private

            return '#' + originalKey + '#';
        },

        _getDialogTitleText: function (existingItem) {
            // summary:
            //      Get dialog title for create new and edit a email template.
            // tags:
            //      Override

            return existingItem ? resources.editemailtemplate : resources.createemailtemplate;
        }

    });

});