define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/dom-attr',
    'dojo/dom-class',
    'dojo/dom-construct',
    'dojo/dom-style',

    'dojo/query',
    'dojo/when',
// dijit
    'dijit/_TemplatedMixin',
    'dijit/_Widget',
    'dijit/_WidgetsInTemplateMixin',

    'dijit/form/Button', // used in template
    'dijit/Tooltip',
// epi
    'epi/dependency',
    'epi/shell/widget/_ValueRequiredMixin',
    'epi/shell/widget/dialog/Dialog',

    'epi-cms/_ContentContextMixin',
    'epi-cms/widget/_HasChildDialogMixin',
// epi-addons
    'epi-forms/widget/FieldSelectorDialog',
// resources
    'dojo/text!./templates/FieldSelector.html',
    'epi/i18n!epi-cms/nls/episerver.forms.fieldselector'
],
function (
// dojo
    declare,
    lang,

    domAttr,
    domClass,
    domConstruct,
    domStyle,

    query,
    when,
// dijit
    _TemplatedMixin,
    _Widget,
    _WidgetsInTemplateMixin,

    Button, // used in template
    Tooltip,
// epi
    dependency,
    _ValueRequiredMixin,
    Dialog,

    _ContentContextMixin,
    _HasChildDialogMixin,
// epi-addons
    FieldSelectorDialog,
// resources
    template,
    res
) {

    // module:
    //      epi-forms/widget/FieldSelector
    // tags:
    //      internal

    return declare([_Widget, _TemplatedMixin, _WidgetsInTemplateMixin, _HasChildDialogMixin, _ValueRequiredMixin], {

        templateString: template,

        res: res,

        value: null,

        store: null,

        onChange: function (value) {
            // summary:
            //      Fired when value is changed.
            // value:
            //      The value
            // tags:
            //      public, callback
        },

        postMixInProperties: function () {
            // summary:
            //      Initialize properties
            // tags:
            //      protected

            this.inherited(arguments);

            if (!this.contentDataStore) {
                var registry = dependency.resolve('epi.storeregistry');
                this.contentDataStore = registry.get('epi.cms.contentdata');
            };
        },

        destroyDescendants: function () {

            if (this._tooltip) {
                this._tooltip.destroy();

                delete this._tooltip;
            }

            this.inherited(arguments);
        },

        _setValueAttr: function (value) {
            //summary:
            //      Value's setter.
            // value:
            //      Array of categories.
            //      Value to be set.
            // tags:
            //      protected

            this._clearFieldButtons();

            if (value) {
                // Clear cached data before using.
                when(this.contentDataStore.evict(value), lang.hitch(this, function () {
                    when(this.contentDataStore.get(value), lang.hitch(this, this._createFieldButton));
                }));
            }

            this._setValueAndFireOnChange(value);
        },

        _setValueAndFireOnChange: function (value) {

            this._set('value', value);
            this.onChange(value);
        },

        _setReadOnlyAttr: function (value) {
            // tags:
            //      protected

            this._set('readOnly', value);

            domStyle.set(this.button.domNode, 'display', value ? 'none' : '');
            domClass.toggle(this.domNode, 'dijitReadOnly', value);
        },

        focus: function () {

            this.button.focus();
        },

        _createFieldButton: function (field) {
            //summary:
            //      Create button to display as selected field
            //field:
            //      content data represent of the field.
            // tags:
            //      private

            if (!field) {
                return;
            }

            if (query('div[data-epi-field-id=' + field.contentLink + ']', this.contentLinkContainer).length !== 0) {
                return;
            }

            var containerDiv = domConstruct.create('div', { 'class': 'dijitReset dijitLeft dijitInputField dijitInputContainer epi-categoryButton' }),
                buttonWrapperDiv = domConstruct.create('div', { 'class': 'dijitInline epi-resourceName' }),
                fieldNameDiv = domConstruct.create('div', { 'class': 'dojoxEllipsis', innerHTML: field.name });

            domConstruct.place(fieldNameDiv, buttonWrapperDiv);

            domConstruct.place(buttonWrapperDiv, containerDiv);
            // create tooltip for the div
            this._tooltip = new Tooltip({
                connectId: fieldNameDiv,
                label: field.name
            });

            var removeButtonDiv = domConstruct.create('div', { 'class': 'epi-removeButton', innerHTML: '&nbsp;' });
            domAttr.set(removeButtonDiv, 'data-epi-field-id', field.contentLink);
            var eventName = removeButtonDiv.onClick ? 'onClick' : 'onclick';

            if (!this.readOnly) {
                this.connect(removeButtonDiv, eventName, lang.hitch(this, this._onRemoveClick));
                domConstruct.place(removeButtonDiv, buttonWrapperDiv);
            } else {
                domConstruct.place(domConstruct.create('span', { innerHTML: '&nbsp;' }), buttonWrapperDiv);
            }

            domConstruct.place(containerDiv, this.contentLinkContainer);
        },

        _clearFieldButtons: function () {
            //summary:
            //      Remove field buttons displaying.
            // tags:
            //      private

            domConstruct.empty(this.contentLinkContainer);
        },

        _onRemoveClick: function (arg) {
            //summary:
            //      Handles remove click event.
            // arg:
            //      Event argument.
            // tags:
            //      private

            this._clearFieldButtons();
            this._setValueAndFireOnChange(null);
        },

        _onShow: function () {
            //summary:
            //      Handle onShow dialog event.
            // tags:
            //      private

            this._fieldSelectorDialog.set('value', this.value);

            this.isShowingChildDialog = true;
            this._fieldSelectorDialog.onShow();
        },

        _onExecute: function () {
            //summary:
            //      Handle dialog close
            // tags:
            //      private

            var selectedField = this._fieldSelectorDialog.get('value');

            this.set('value', selectedField);
        },

        _onDialogHide: function () {
            //summary:
            //      Handle dialog close
            // tags:
            //      private

            this.focus();
            this.isShowingChildDialog = false;
        },

        _createDialog: function () {
            // summary:
            //      Create page tree dialog
            // tags:
            //      protected

            this._fieldSelectorDialog = new FieldSelectorDialog({
                model: this.model || (this.model = new _ContentContextMixin())
            });

            this._dialog = new Dialog({
                title: res.title,
                content: this._fieldSelectorDialog,
                dialogClass: 'epi-dialog-portrait'
            });

            this.connect(this._dialog, 'onExecute', this._onExecute);
            this.connect(this._dialog, 'onShow', this._onShow);
            this.connect(this._dialog, 'onHide', this._onDialogHide);

            this._dialog.startup();
        },

        _onButtonClick: function () {
            //summary:
            //      Handle add category button click
            // tags:
            //      private

            if (!this._dialog) {
                this._createDialog();
            }

            this._fieldSelectorDialog.refresh();
            this._dialog.show(true);
        }

    });

});