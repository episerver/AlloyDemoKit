define([
// dojo
    'dojo/_base/array',
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/dom-construct',
    'dojo/dom-style',

    'dojo/topic',
// dijit
    'dijit/_TemplatedMixin',

    'dijit/layout/_LayoutWidget',
// epi
    'epi/shell/dnd/Source',
    'epi/shell/TypeDescriptorManager',

    'epi-cms/_ContentContextMixin',
// epi-addons
    'epi-forms/widget/FormsContentType',
// templates
    'dojo/text!./templates/FormsContentTypeGroup.html'
],
function (
// dojo
    array,
    declare,
    lang,

    domConstruct,
    domStyle,

    topic,
// dijit
    _TemplatedMixin,

    _LayoutWidget,
// epi
    dndSource,
    TypeDescriptorManager,

    _ContentContextMixin,
// epi-addons
    FormsContentType,
// templates
    template
) {

    // module:
    //      epi-forms/widget/FormsContentTypeGroup
    // summary:
    //      Displays a group of content types under a common heading.
    // tags:
    //      public

    return declare([_LayoutWidget, _TemplatedMixin, _ContentContextMixin], {

        // contentTypes: [public] Array
        //      Collection of content types that are displayed in the group.
        contentTypes: null,

        // templateString: [protected] String
        //      A string that represents the widget template.
        templateString: template,

        // title: [public] String
        //      The title for the content type group.
        title: '',

        _setTitleAttr: { node: 'titleNode', type: 'innerText' },

        _setContentTypesAttr: function (/*String*/contentType) {
            this._set('contentTypes', contentType);

            if (this._created) {
                this._renderLayout();
            }
        },

        postCreate: function () {
            this.inherited(arguments);

            this._setupDndSource();
            this._renderLayout();

            this.own(
                topic.subscribe('/epi/shell/action/changeview', lang.hitch(this, this._toggleDnd)),
                topic.subscribe('/epi/shell/action/changeview/back', lang.hitch(this, this._toggleDnd))
            );
        },

        _renderLayout: function () {
            // summary:
            //      Render the group with the current content types. This will
            //      destroy the current view if it exists.
            // tags:
            //      private

            this.clear();

            var formsContentType = null;
            array.forEach(this.contentTypes, function (type) {
                formsContentType = new FormsContentType({ contentType: type });
                this.addChild(formsContentType);

                this._source.setItem(formsContentType.id, {
                    data: type,
                    type: this._getDndTypes(type.typeIdentifier),
                    options: {
                        contentTypeId: type.id,
                        createNew: true
                    }
                });
            }, this);
        },

        clear: function () {
            // summary:
            //      Destroys the current view.
            // tags:
            //      public

            array.forEach(this.getChildren(), function (child) {
                this.removeChild(child);
                child.destroyRecursive();
            }, this);
        },

        setVisibility: function (/*Boolean*/display) {
            // summary:
            //      Set the group's visibility.
            // display: [Boolean]
            //      Flag states if the group will be shown or not.
            // tags:
            //      public

            domStyle.set(this.domNode, 'display', display ? 'block' : 'none');
        },

        contentContextChanged: function (ctx, callerData) {
            // summary:
            //      Called when the currently loaded content changes. I.e. a new content data object is loaded into the preview area.
            //      Toggle Dnd source.
            // tags:
            //      protected, extensions

            var viewKey = callerData.sender && callerData.sender.viewName;
            this._toggleDnd(viewKey);
        },

        _setupDndSource: function () {
            // summary:
            //      Setups Dnd source object.
            // tags:
            //      private

            this._source = new dndSource(this.containerNode, {
                creator: lang.hitch(this, this._dndNodeCreator),
                copyOnly: true,
                selfAccept: false,
                selfCopy: false
            });

            this._toggleDnd();
        },

        _dndNodeCreator: function (/*Object*/item, /*Object*/hint) {
            // summary:
            //      Custom Dnd avatar creator method.
            // item: [Object]
            //      Item data object
            // tags:
            //      private

            return {
                'node': domConstruct.create('div').appendChild(document.createTextNode(item.localizedName)),
                'type': this._getDndTypes(item.typeIdentifier),
                'data': item
            };
        },

        _toggleDnd: function (/*String*/viewKey) {
            // summary:
            //      Toggles Dnd for this area.
            // viewKey: [String]
            //      Current view mode key.
            // tags:
            //      private

            if ((viewKey && viewKey !== 'onpageedit')
                || this._currentContext.currentMode === 'create') {
                this._source.isSource = false;

                return;
            }

            if (this._source) {
                this._source.isSource = !this._currentContext.capabilities.isPage;
            }
        },

        _getDndTypes: function (/*String*/typeIdentifier) {
            // summary:
            //      Get Dnd types from given type identifier.
            // typeIdentifier: [String]
            //      Conten type identifier.
            // returns: [Array]
            //      Array of Dnd type.
            // tags:
            //      private

            return TypeDescriptorManager.getAndConcatenateValues(typeIdentifier, 'dndTypes');
        }

    });

});