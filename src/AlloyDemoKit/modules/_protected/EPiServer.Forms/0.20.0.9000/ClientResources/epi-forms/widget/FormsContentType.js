define([
// dojo
    'dojo/_base/declare',

    'dojo/dom-attr',
    'dojo/dom-class',
    'dojo/query',
// dijit
    'dijit/_TemplatedMixin',
    'dijit/_Widget',
// epi
    'epi/shell/TypeDescriptorManager',
// templates
    'dojo/text!./templates/FormsContentType.html'
],
function (
// dojo
    declare,

    domAttr,
    domClass,
    query,
// dijit
    _TemplatedMixin,
    _Widget,
// epi
    TypeDescriptorManager,
// templates
    formsContentTypeTemplate
) {

    // module:
    //      epi-forms/widget/FormsContentType
    // summary:
    //      Render EPiServer Forms content type element
    // tags:
    //      public

    return declare([_Widget, _TemplatedMixin], {

        // contentType: [public] Object
        //      The content type to be displayed.
        contentType: null,

        // templateString: [protected] String
        //      The widget template.
        templateString: formsContentTypeTemplate,

        // =======================================================================
        // Property setters
        // =======================================================================

        _setContentTypeAttr: function (/*Object*/contentType) {
            // summary:
            //      Sets content type object and then _renderLayout UI based on this object
            // contentType: [Object]
            //      Content type information
            // tags:
            //      private

            this._set('contentType', contentType);

            if (this._created) {
                this._renderLayout();
            }
        },

        // =======================================================================
        // Overrided stubs
        // =======================================================================

        buildRendering: function () {
            // summary:
            //      Construct the UI with the initial content type.
            // tags:
            //      protected, extensions

            this.inherited(arguments);

            this._renderLayout();
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _renderLayout: function () {
            // summary:
            //      Render the content type layout.
            // tags:
            //      private

            if (!this.contentType) {
                return;
            }

            query(this.contentTypeName).text(this.contentType.localizedName);

            domAttr.set(this.contentTypeItem, 'title', this.contentType.localizedDescription || '');

            domClass.add(this.domNode, 'epi-forms-' + this.contentType.name.toLowerCase());
            domClass.add(this.contentTypeIcon, TypeDescriptorManager.getValue(this.contentType.typeIdentifier, 'iconClass'));
        }

    });

});