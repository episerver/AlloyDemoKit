define([
// dojo
    'dojo/_base/array',
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/dom-class',

    'dojo/Deferred',
    'dojo/promise/all',
    'dojo/when',
// dijit
    'dijit/layout/_LayoutWidget',
// epi
    'epi/dependency',
    'epi/shell/TypeDescriptorManager',
// epi-addons
    'epi-forms/ModuleSettings',
    'epi-forms/widget/FormsContentTypeGroup'
],
function (
// dojo
    array,
    declare,
    lang,

    domClass,

    Deferred,
    all,
    when,
// dijit
    _LayoutWidget,
// epi
    dependency,
    TypeDescriptorManager,
// epi-addons
    ModuleSettings,
    FormsContentTypeGroup
) {

    // module:
    //      epi-forms/widget/FormsContentTypeList
    // summary:
    //      A list of suggested and available content types for content creation.
    //      Displays a list of suggested and available content types for content creation.
    // tags:
    //      public

    return declare([_LayoutWidget], {

        // store: [readonly] dojo.store
        //      Underlying store which will be queried for data to display.
        store: null,

        // parentLink: [public] String
        //      Link to parent content which the new content will be created beneath.
        parentLink: null,

        // groups: [public] Object
        //      Named value object containing the current content type groups.
        groups: null,

        // requestedType: [public] String
        //      Specify the content type to be shown on the list.
        requestedType: null,

        // allowedTypes: [public] Array
        //      The types which are allowed. i.e used for filtering based on AllowedTypesAttribute
        allowedTypes: null,

        // restrictedTypes: [public] Array
        //      The types which are restricted.
        restrictedTypes: null,

        contentTypeService: null,

        _setLocalAssetAttr: function (localAsset) {
            this._set('localAsset', localAsset);

            if (this.requestedType && this.parentLink) {
                this.refresh();
            }
        },

        _setParentLinkAttr: function (value) {
            this._set('parentLink', value);

            if (this.requestedType) {
                this.refresh();
            }
        },

        postMixInProperties: function () {
            // summary:
            //      Initiates the store if none has been mixed in.
            // tags:
            //      protected

            this.inherited(arguments);

            this.groups = {};

            this.contentTypeService = this.contentTypeService || dependency.resolve('epi.cms.ContentTypeService');

            if (!this.store) {
                var registry = dependency.resolve('epi.storeregistry');
                this.store = registry.get('epi.cms.contenttype');
            }
        },

        refresh: function () {
            // summary:
            //      Refresh the content and rendered view of the list.
            // tags:
            //      public

            // Clear any existing data first to stop flickering in the UI.
            this.clear();

            this._setupWidgetTemplate();

            when(all({
                groups: this._groupContentTypes()
            }), lang.hitch(this, function (result) {
                var types = result.types,
                    groups = result.groups,
                    grouped = groups.grouped,
                    contentTypes = groups.contentTypes;

                // Clear and load the available content types sorted into groups.
                var key, group;

                // Update remaining groups with new content types.
                for (key in grouped) {
                    group = this._getOrCreateGroup(key);
                    group.set('contentTypes', grouped[key]);
                }
            }));
        },

        setVisibility: function (display) {
            // summary:
            //      The common method to show / hide this widget
            // display: [Boolean]
            //      The flag to show or hide.
            // tags:
            //      pubic

            this.getChildren().forEach(function (group) {
                group.setVisibility(display);
            }, this);
        },

        _setupWidgetTemplate: function () {
            this._otherTypesTitle = TypeDescriptorManager.getResourceValue(this.requestedType, 'othertypes');
        },

        clear: function () {
            // summary:
            //      Removes all the content types groups from the current view, except for
            //      suggested content types which will only have it's children removed.
            // tags:
            //      public

            for (var key in this.groups) {
                this.groups[key].destroyRecursive();
                delete this.groups[key];
            }
        },

        _getOrCreateGroup: function (name) {
            var group = this.groups[name];
            if (!group) {
                group = new FormsContentTypeGroup({ title: name });
                this.addChild(group);
                this.groups[name] = group;
            }

            return group;
        },

        _getAvailableContentTypes: function (type) {
            // summary:
            //      Query for available content types based on the type.
            // tags:
            //      private

            if (!(this.allowedTypes instanceof Array)) {
                this.allowedTypes = [];
            }

            var formElementContentTypes = ModuleSettings.formElementContentTypes;
            if (formElementContentTypes instanceof Array && formElementContentTypes.length > 0) {
                this.allowedTypes.push.apply(this.allowedTypes, formElementContentTypes);
            }

            return this.contentTypeService.getAcceptedChildTypes(this.parentLink, this.get('localAsset'), [type], this.allowedTypes, this.restrictedTypes);
        },

        _groupContentTypes: function () {
            // summary:
            //      Group the available content types.
            // tags:
            //      private

            var grouped = {},
                deferred = new Deferred(),
                otherGroupType = this._otherTypesTitle;

            when(this._getAvailableContentTypes(this.requestedType), lang.hitch(this, function (available) {
                var count = available.length;
                array.forEach(available, function (item) {
                    when(item, function (type) {
                        var groupName = type.groupName || otherGroupType,
                            group = grouped[groupName] || [];

                        group.push(type);
                        grouped[groupName] = group;

                        count--;
                        if (count === 0) {
                            deferred.resolve({ grouped: grouped, contentTypes: available });
                        }
                    });
                });
            }));

            return deferred;
        }

    });

});