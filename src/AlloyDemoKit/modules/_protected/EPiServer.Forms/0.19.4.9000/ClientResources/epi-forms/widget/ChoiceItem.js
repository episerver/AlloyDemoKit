define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/dom-attr',
    'dojo/dom-class',
    'dojo/dom-construct',

    'dojo/on',
// dijit
    'dijit/_TemplatedMixin',
    'dijit/_Widget',
    'dijit/_WidgetsInTemplateMixin',

    'dijit/focus',

    'dijit/form/CheckBox',
    'dijit/form/RadioButton',
// resources
    'dojo/text!./templates/ChoiceItem.html'
],
function (
// dojo
    declare,
    lang,

    domAttr,
    domClass,
    domConstruct,

    on,
// dijit
    _TemplatedMixin,
    _Widget,
    _WidgetsInTemplateMixin,

    focusUtil,

    CheckBox,
    RadioButton,
// resources
    template
) {

    // module:
    //      epi-forms/widget/ChoiceItem
    // summary:
    //      RadioButton|CheckBox widget that contains clickable label.
    // tags:
    //      public

    return declare([_Widget, _TemplatedMixin, _WidgetsInTemplateMixin], {

        templateString: template,

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        buildRendering: function () {

            this.inherited(arguments);

            this._setupLayout();
            this._setupEvents();
        },

        getFocusableNode: function () {
            // summary:
            //      Gets focusable node of this widget.
            // returns: [DOM]
            //      Focusable DOM of this widget.
            // tags:
            //      public

            return this._selector && this._selector.domNode;
        },

        // =======================================================================
        // Protected stubs
        // =======================================================================

        _setSelectorReadOnlyAttr: function (/*Object*/value) {
            // summary:
            //      Sets 'readOnly' attribute value for selector widget.
            // tags:
            //      protected

            this._selector && this._selector.set('readOnly', value);
        },

        _getSelectorValueAttr: function () {
            // summary:
            //      Gets value from this selector widget.
            // tags:
            //      protected

            return this._selector && this._selector.value;
        },

        _setSelectorValueAttr: function (/*Object*/value) {
            // summary:
            //      Sets value for selector widget.
            // tags:
            //      protected

            if (value == null) {
                return;
            }

            this._selector && this._selector.set('value', value);
        },

        _setSelectorCheckedAttr: function (value) {
            // summary:
            //      Sets 'checked' attribute value for selector widget.
            // tags:
            //      protected

            this._selector && this._selector.set('checked', value);
        },

        _getSelectorCheckedAttr: function () {
            // summary:
            //      Gets 'checked' attribute value of the selector widget.
            // tags:
            //      protected

            return this._selector && this._selector.checked;
        },

        _setSelectorTextAttr: function (/*Object*/value) {
            // summary:
            //      Sets label text for selector widget.
            // tags:
            //      protected

            this.selectorLabel.textContent = value;
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _setupLayout: function () {
            // summary:
            //      Build layout for this widget.
            // tags:
            //      private

            this._buildSelectorSection();
        },

        _setupEvents: function () {
            // summary:
            //      Setup events for this widget.
            // tags:
            //      private

            if (this._selector) {
                this.own(
                    this._selector.on('change', lang.hitch(this, function () {
                        this.emit('selectorChanged');
                    })),
                    on(this.selectorLabel, 'click', lang.hitch(this, function () {
                        focusUtil.focus(this._selector.domNode);
                    }))
                );
            }
        },

        _buildSelectorSection: function () {
            // summary:
            //      Create selector widget.
            //      Based on the selector type, created widget will be RadioButton or CheckBox.
            //      Selector type:
            //          'single':       RadioButton will be created.
            //          'multiple':     CheckBox will be created.
            // tags:
            //      private

            domClass.add(this.selectorContainer, this.selectorType === 'multiple'
                ? 'epi-forms-checkBoxContainer'
                : 'epi-forms-radioButtonContainer');

            this._selector = this.selectorType === 'multiple'
                ? this._createCheckBoxWidget()
                : this._createRadioButtonWidget();

            domConstruct.place(this._selector.domNode, this.selectorContainer, 'first');

            this._selector && domAttr.set(this.selectorLabel, 'for', this._selector.id);
        },

        _createRadioButtonWidget: function () {
            // summary:
            //      Create RadioButton widget.
            // returns: [Object]
            //      An instance of 'dijit/form/RadioButton' class.
            // tags:
            //      private

            var selector = new RadioButton();

            return selector;
        },

        _createCheckBoxWidget: function () {
            // summary:
            //      Create CheckBox widget.
            // returns: [Object]
            //      An instance of 'dijit/form/CheckBox' class.
            // tags:
            //      private

            var selector = new CheckBox();

            return selector;
        }

    });

});