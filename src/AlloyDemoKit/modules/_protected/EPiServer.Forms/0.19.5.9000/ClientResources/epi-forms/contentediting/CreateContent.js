define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/aspect',
    'dojo/dom-style',
// epi
    'epi-cms/contentediting/CreateContent',
// epi-addons
    'epi-forms/ModuleSettings',
    'epi-forms/contentediting/CreateContentViewModel'
],
function (
// dojo
    declare,
    lang,

    aspect,
    domStyle,
// epi
    CreateContent,

    ModuleSettings,
    CreateContentViewModel
) {

    // module:
    //      epi-forms/contentediting/CreateContent
    // summary:
    //      Overrides CreateContent widget in order to:
    //      - Bind custom view model.
    //      - Hides suggested content types section from content type list.
    // tags:
    //      public

    return declare([CreateContent], {

        // modelType: [public] Object
        //      Overrided view model for create content by EPiServer Forms
        modelType: CreateContentViewModel,

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        postCreate: function () {
            this.inherited(arguments);

            this._hideSuggestedContentTypes();

            this.own(
                // TECH NOTE: In quickLayout mode, when user choose contentType to create form elment
                // we call this._onSave for automatically create and publish the element
                aspect.after(this.propertiesForm, '_setupForm', lang.hitch(this, function () {
                    if (ModuleSettings.quickLayout == true) {
                        this._setButtonsVisibility(false);
                        this._onSave();
                    }
                }))
            );
        },

        // =======================================================================
        // Protected stubs
        // =======================================================================

        _onContentTypeSelected: function (item) {
            // summary:
            //    Handle content type selected event from the content type list widget.
            //
            // tags:
            //    override

            this.inherited(arguments);

            this.model.set('contentName', item.localizedName);

            this._setButtonsVisibility(!ModuleSettings.quickLayout);
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _hideSuggestedContentTypes: function () {
            // summary:
            //      Hides suggested content types section.
            // tags:
            //      private

            var suggestedContentTypes = this.contentTypeList && this.contentTypeList._suggestedContentTypes;
            if (suggestedContentTypes) {
                this.own(
                    aspect.after(suggestedContentTypes, 'setVisibility', function () {
                        typeof this.clear === 'function' && this.clear();

                        domStyle.set(this.domNode, 'display', 'none');
                    })
                );
            }
        },

        _setButtonsVisibility: function (visible) {
            // summary:
            //    Set saveButton and cancelButton visibility.
            //
            // tags:
            //    private

            this.toolbar.setItemVisibility('saveButton', visible);
            this.toolbar.setItemVisibility('cancelButton', visible);
        }

    });

});