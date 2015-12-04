define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/aspect',
// epi
    'epi/shell/widget/FormContainer'
],
function (
// dojo
    declare,
    lang,

    aspect,
// epi
    FormContainer
) {

    // module:
    //      epi-forms/widget/FormContainer
    // summary:
    //      Decorates 'epi/shell/widget/FormContainer' class (CMS's widget) in order to:
    //      - Catchs onfocus event on each form's input field and then expose this event with indicated focus element for focus element id.
    // tags:
    //      public

    return declare([FormContainer], {

        buildRendering: function () {

            this.inherited(arguments);

            this.own(
                aspect.after(this, 'onFieldCreated', lang.hitch(this, this._onFieldCreated), true)
            );
        },

        onFieldFocused: function (/*String|Object*/target) {
            // summary:
            //      Public callback that exposes focus event on each form's input element.
            // target: [String|Object]
            //      Focused element id or focused object.
            // tags:
            //      callback
        },

        _onFieldCreated: function (/*String*/fieldName, /*Object*/widget) {
            // summary:
            //      Raised when a field editor widget is created.
            // fieldName: [String]
            //      The field name
            // widget: [Object]
            //      The instance of dijit._Widget.
            // tags:
            //      private

            if (!widget) {
                return;
            }

            // CASE: Normal form field
            // In this case, pass focused element id to 'onFieldFocused' public callback
            var focusNode = widget.focusNode;
            if (focusNode) {
                this.own(
                    this.connect(widget, 'onFocus', lang.hitch(this, function () {
                        this._onFieldFocused(focusNode.id);
                    }))
                );

                return;
            }

            // CASE: RichText form field (TinyMCE)
            // In this case, pass focused object to 'onFieldFocused' public callback
            if (widget.baseClass.indexOf('epiTinyMCEEditor') !== -1) {
                this.own(
                    this.connect(widget, 'onFocus', lang.hitch(this, function () {
                        this._onFieldFocused(tinyMCE && tinyMCE.activeEditor);
                    }))
                );
            }
        },

        _onFieldFocused: function (/*String|Object*/focusTarget) {
            // summary:
            //      Pass focused target object to public callback.
            // focusTarget: [String|Object]
            //      Focused element id or focused object.
            // tags:
            //      private

            if (!focusTarget) {
                return;
            }

            this.onFieldFocused(focusTarget);
        }

    });

});