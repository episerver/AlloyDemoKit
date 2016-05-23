define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/aspect',
    'dojo/when',
// epi
    'epi/shell/dnd/Target',
    'epi-cms/contentediting/editors/ContentAreaEditor',
    'epi-cms/core/ContentReference',
// epi-addons
    'epi-forms/ModuleSettings',
    'epi-forms/widget/_ContentAreaMixin',
    'epi-forms/widget/command/CreateContentFromSelector'
],
function (
// dojo
    declare,
    lang,

    aspect,
    when,
// epi
    Target,
    ContentAreaEditor,
    ContentReference,
// epi-addons
    ModuleSettings,
    _ContentAreaMixin,
    CreateContentFromSelector
) {

    // module:
    //      epi-forms/contentediting/editors/ContentAreaEditor
    // summary:
    //      
    // tags:
    //      public

    return declare([ContentAreaEditor, _ContentAreaMixin], {

        // =======================================================================
        // Overrided stubs
        // =======================================================================

        postCreate: function () {
            // tags:
            //      public, extensions

            this.inherited(arguments);

            if (this.tree && this.tree.model) {
                this.own(
                    aspect.around(this.tree.model, 'newItem', lang.hitch(this, this._aroundNewItem))
                );
            }
        },

        buildRendering: function () {
            // tags:
            //      public, extensions

            this.inherited(arguments);

            this.own(
                this._dndTarget = new Target(this.actionsContainer, {
                    accept: this.allowedDndTypes,
                    reject: this.restrictedDndTypes,
                    isSource: false,
                    alwaysCopy: false,
                    insertNodes: function () { }
                }),
                aspect.after(this._dndTarget, 'onDropData', lang.hitch(this, this._onDropData), true)
            );
        },

        executeAction: function (/*String*/actionName, /*Object*/itemData) {
            // summary:
            //      Overridden mixin class executing click actions from textWithLinks widget
            // actionName: [String]
            //      Action name of link on content area
            // itemData: [Object]
            //      
            // tags:
            //      public, extensions

            var command = null;

            if (actionName === ModuleSettings.createNewFormsElementByDndActionName) {
                // HACK: Preventing the onBlur from being executed so the editor wrapper keeps this editor in editing state
                this._preventOnBlur = true;
                // since we're going to create a block, we need to hide all validation tooltips because onBlur is prevented here
                this.validate(false);

                command = this._getCreateNewFormsBlockCommand(itemData);
            }

            if (actionName === ModuleSettings.createNewFormsElementActionName) {
                // HACK: Preventing the onBlur from being executed so the editor wrapper keeps this editor in editing state
                this._preventOnBlur = true;
                // since we're going to create a block, we need to hide all validation tooltips because onBlur is prevented here
                this.validate(false);

                command = this._getCreateNewBlockCommand();
            }

            if (!command) {
                return;
            }

            command.set('model', {
                save: lang.hitch(this, function (block) {
                    this._preventOnBlur = false;

                    var value = lang.clone(this.get('value'), true) || [];
                    value.push(block);

                    this.set('value', value);
                    this.onChange(value);

                    // Now call onBlur since it's been prevented using the _preventOnBlur flag.
                    this.onBlur();
                }),
                cancel: lang.hitch(this, function () {
                    this._preventOnBlur = false;
                    this.onBlur();
                })
            });

            command.execute();
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _aroundNewItem: function (original) {
            // summary:
            //      Modifies Dnd data before send it to tree's model 'epi-cms/contentediting/editors/_ContentAreaTreeModel' newItem() function.
            //      Modified data includes:
            //          contentLink - content reference identification of a newly created form element
            //          name - content name of a newly created form element
            // original: [Object]
            //      Original function - 'newItem(args, parent, insertIndex, before)'
            // tags:
            //      private

            return lang.hitch(this, function (args, parent, insertIndex, before) {

                if (ModuleSettings.quickLayout
                    && args && args.dndData && args.dndData.data && !args.dndData.data.contentLink) {

                    when(this.getCurrentContent(), lang.hitch(this, function (contentData) {
                        when(this._getElementTypeId(args.dndData.data.typeIdentifier), lang.hitch(this, function (typeId) {
                            when(this._getElementByType(typeId, contentData.contentLink), lang.hitch(this, function (contentLink) {
                                var contentWithoutVersion = (new ContentReference(contentLink)).createVersionUnspecificReference().toString();
                                when(this.contentDataStore.get(contentWithoutVersion), lang.hitch(this, function (content) {
                                    args.dndData.data.contentLink = contentWithoutVersion;
                                    args.dndData.data.name = content.name;

                                    return original.apply(this.tree.model, [args, parent, insertIndex, before]);
                                }));
                            }));
                        }));
                    }));

                } else {
                    return original.apply(this.tree.model, [args, parent, insertIndex, before]);
                }

            });

        },

        _onDropData: function (/*Array*/data, /*Object*/source, /*Array*/nodes, /*Boolean*/isCopy) {
            // summary:
            //      onDropData handler for the source.
            // data: [Array]
            //      Data extracted from the dragged items.
            // source: [Object]
            //      The source that the drag event originated from.
            // nodes: [Array]
            //      The nodes being dragged.
            // isCopy: [Boolean]
            //      Flag indicating whether the drag is a copy. False indicates a move.
            // tags:
            //      private

            var itemData = (data instanceof Array) && data[0],
                self = this;

            if (itemData && itemData.options && itemData.options.createNew === true) {
                if (ModuleSettings.quickLayout) {

                    when(self.getCurrentContent(), function (contentData) {
                        when(self._getElementByType(itemData.options.contentTypeId, contentData.contentLink), function (contentLink) {
                            when(self.contentDataStore.get(contentLink), function (content) {
                                self.model.modify(function () {
                                    self.model.addChild(content);
                                });
                            });
                        });
                    });

                } else {
                    self.executeAction(ModuleSettings.createNewFormsElementByDndActionName, itemData);
                }

                return;
            }

            self.model.modify(function () {
                self.model.addChild(itemData.data);
            });
        },

        _getCreateNewBlockCommand: function () {
            // summary:
            //      
            // returns: [Object]
            //      
            // tags:
            //      private

            return new CreateContentFromSelector({
                allowedTypes: this.allowedTypes,
                createAsLocalAsset: true,
                creatingTypeIdentifier: ModuleSettings.formElementBaseContentType,
                restrictedTypes: this.restrictedTypes
            });
        },

        _getCreateNewFormsBlockCommand: function (/*Object*/itemData) {
            // summary:
            //      
            // itemData: [Object]
            //      
            // returns: [Object]
            //      
            // tags:
            //      private

            return new CreateContentFromSelector({
                allowedTypes: this.allowedTypes,
                createAsLocalAsset: true,
                creatingTypeIdentifier: itemData.data.typeIdentifier,
                contentTypeId: itemData.options.contentTypeId,
                restrictedTypes: this.restrictedTypes
            });
        }

    });

});