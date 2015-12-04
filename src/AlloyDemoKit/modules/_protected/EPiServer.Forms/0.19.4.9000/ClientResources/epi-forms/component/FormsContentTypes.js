define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',
    'dojo/when',
// dijit
    'dijit/_TemplatedMixin',
    'dijit/_WidgetsInTemplateMixin',
    'dijit/layout/_LayoutWidget',
    'dijit/layout/BorderContainer', /* Used in template */
    'dijit/layout/StackContainer', /* Used in template */
// epi
    'epi/shell/widget/_ModelBindingMixin',
    'epi/shell/widget/layout/_ComponentWrapper',

    'epi-cms/_ContentContextMixin',
    'epi-cms/core/ContentReference',
// epi-addons
    'epi-forms/component/FormsContentTypesViewModel',
    'epi-forms/ModuleSettings',
    'epi-forms/widget/FormsContentTypeList', /* Used in template */
// templates
    'dojo/text!./templates/FormsContentTypes.html',
// resources
    'epi/i18n!epi-cms/nls/episerver.forms.contenttypescomponent'
],
function (
// dojo
    declare,
    lang,
    when,
// dijit
    _TemplatedMixin,
    _WidgetsInTemplateMixin,
    _LayoutWidget,
    BorderContainer, /*Used in template*/
    StackContainer, /*Used in template*/
// epi
    _ModelBindingMixin,
    _ComponentWrapper,

    _ContentContextMixin,
    ContentReference,
// epi-addons
    FormsContentTypesViewModel,
    ModuleSettings,
    FormsContentTypeList, /*Used in template*/
// templates
    template,
// resources
    resources
) {

    // module:
    //      epi-forms/component/FormsContentTypes
    // summary:
    //      EPiServer Forms - Content Types component
    // tags:
    //      public

    return declare([_LayoutWidget, _TemplatedMixin, _WidgetsInTemplateMixin, _ModelBindingMixin, _ContentContextMixin], {

        // modelType: [public]
        //      
        modelType: FormsContentTypesViewModel,

        // templateString: [public] String
        //      
        templateString: template,

        modelBindingMap: {
            'actualParentLink': ['actualParentLink'],
            'allowedTypes': ['allowedTypes'],
            'createAsLocalAsset': ['createAsLocalAsset'],
            'requestedType': ['requestedType'],
            'restrictedTypes': ['restrictedTypes']
        },

        _setActualParentLinkAttr: function (/*String*/actualParentLink) {
            // summary:
            //      Set actual parent link
            // actualParentLink: [String]
            //      
            // tags:
            //      private

            this.contentTypeList.set('parentLink', actualParentLink);
        },

        _setAllowedTypesAttr: function (/*Array*/allowedTypes) {
            // summary:
            //      Set the allowed types
            // allowedTypes: [Array]
            //      
            // tags:
            //      private

            this.contentTypeList.set('allowedTypes', allowedTypes);
        },

        _setCreateAsLocalAssetAttr: function (/*Boolean*/createAsLocalAsset) {
            // summary:
            //      Reset breadcrumb in case createAsLocalAsset had updated its value
            // createAsLocalAsset: [Boolean]
            //      TRUE if a new content will be create as a local asset
            // tags:
            //      private

            this._set('createAsLocalAsset', createAsLocalAsset);

            this.contentTypeList.set('localAsset', createAsLocalAsset);
        },

        _setRequestedTypeAttr: function (/*String*/requestedType) {
            // summary:
            //      Set requested type attribute
            // requestedType: [String]
            //      
            // tags:
            //      private

            this.contentTypeList.set('requestedType', requestedType);
        },

        _setRestrictedTypesAttr: function (/*Array*/restrictedTypes) {
            // summary:
            //      Set the restricted types
            // restrictedTypes: [Array]
            //      
            // tags:
            //      private

            this.contentTypeList.set('restrictedTypes', restrictedTypes);
        },

        postMixInProperties: function () {
            // summary:
            //      Post properties mixin handler.
            //      Set up model and resource for template binding.
            // tags:
            //      protected

            this.inherited(arguments);

            this.model = new this.modelType();
        },

        postCreate: function () {
            // summary:
            //      Post widget creation handler.
            // tags:
            //      protected

            this.inherited(arguments);

            when(this.getCurrentContext(), lang.hitch(this, function (currentContext) {
                var contentWithoutVersion = (new ContentReference(currentContext.id)).createVersionUnspecificReference().toString();
                when(this.model.contentDataStore.get(contentWithoutVersion), lang.hitch(this, function (currentContent) {
                    this.updateView({
                        parent: currentContent,
                        createAsLocalAsset: true,
                        requestedType: 'episerver.core.blockdata'
                    });

                    this._toggleComponentWrapper(currentContext);
                }));
            }));
        },

        contentContextChanged: function (ctx, callerData) {
            // summary:
            //      Called when the currently loaded content changes. I.e. a new content data object is loaded into the preview area.
            // tags:
            //      protected

            this._toggleComponentWrapper(ctx);
        },

        layout: function () {
            // summary:
            //      Layout the widget.
            //      Set the widget's size to the top layout container.
            // tags:
            //      protected

            if (this._started) {
                this.layoutContainer.resize(this._containerContentBox || this._contentBox);
            }
        },

        updateView: function (/*Object*/data) {
            // summary:
            //      
            // data: [Object]
            //      
            // tags:
            //      public

            // content can only be created when it has parent and requestedType (when creating via New Page, Block buttons)
            // or content can be created when it has contentData and languageBranch (when creating via Translate notification) 
            // if incoming data doesn't have parent and requestedType then no need to update the view & model.
            if (data && ((data.parent && data.requestedType) || (data.contentData && data.languageBranch))) {
                when(this.model.update(data), lang.hitch(this, this.layout), function (err) {
                    console.log(err);
                });
            }
        },

        _toggleComponentWrapper: function (/*Object*/context) {
            // summary:
            //      Toggle the display of the component wrapper widget
            // context: [Object]
            //      Current context object
            // tags:
            //      private

            var componentWrapper = this._getComponentWrapper();
            if (componentWrapper) {
                componentWrapper.set('open', context.dataType === ModuleSettings.formContainerContentType);
            }
        },

        _getComponentWrapper: function () {
            // summary:
            //      Gets component wrapper widget
            // returns: [Object]
            //      An instance of _ComponentWrapper class
            // tags:
            //      private

            var parent = this.getParent();
            while (parent && !(parent instanceof _ComponentWrapper)) {
                parent = parent.getParent();
            }

            return parent;
        }

    });

});