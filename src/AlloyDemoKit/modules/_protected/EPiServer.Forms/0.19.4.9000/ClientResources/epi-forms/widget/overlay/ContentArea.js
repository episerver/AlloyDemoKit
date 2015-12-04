define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/when',
// epi
    'epi-cms/core/ContentReference',
    'epi-cms/widget/overlay/ContentArea',
// epi-addons
    'epi-forms/ModuleSettings',

    'epi-forms/widget/_ContentAreaMixin',
    'epi-forms/widget/command/CreateContentFromSelector'
],
function (
// dojo
    declare,
    lang,

    when,
// epi
    ContentReference,
    ContentArea,
// epi-addons
    ModuleSettings,

    _ContentAreaMixin,
    CreateContentFromSelector
) {

    // module:
    //      epi-forms/widget/overlay/ContentArea
    // summary:
    //      
    // tags:
    //      public

    return declare([ContentArea, _ContentAreaMixin], {

        // =======================================================================
        // Overrided stubs
        // =======================================================================

        executeAction: function (/*String*/actionName, /*Object*/itemData) {
            // summary:
            //      
            // actionName: [String]
            //      
            // itemData: [Object]
            //      
            // tags:
            //      public, extensions

            var command = null;

            if (actionName === ModuleSettings.createNewFormsElementByDndActionName) {
                command = this._getCreateNewFormsBlockCommand(itemData);
            }

            if (actionName === ModuleSettings.createNewFormsElementActionName) {
                command = this._getCreateNewBlockCommand();
            }

            if (!command) {
                return;
            }

            command.set('model', {
                save: lang.hitch(this, function (block) {

                    var value = lang.clone(this.model.get('value'), true) || [];
                    value.push(block);

                    this.onValueChange({
                        propertyName: this._source.propertyName,
                        value: value
                    });

                })
            });

            command.execute();
        },

        _onDrop: function (/*Array*/data, /*Object*/source, /*Array*/nodes, /*Boolean*/isCopy) {
            // summary:
            //      onDrop handler for the source.
            // data: [Array]
            //      Data extracted from the dragged items.
            // source: [Object]
            //      The source that the drag event originated from.
            // nodes: [Array]
            //      The nodes being dragged.
            // isCopy: [Boolean]
            //      Flag indicating whether the drag is a copy. False indicates a move.
            // tags:
            //      protected, extensions

            var inherited = this.getInherited(arguments),
                itemData = (data instanceof Array) && data[0],
                targetAnchor = this._source.targetAnchor,
                before = this._source.before;

            if (itemData && itemData.options && itemData.options.createNew === true) {

                if (ModuleSettings.quickLayout) {

                    when(this._getElementByType(itemData.options.contentTypeId, this._ownerContentLink), lang.hitch(this, function (contentLink) {

                        var contentWithoutVersion = (new ContentReference(contentLink)).createVersionUnspecificReference().toString();
                        when(this.contentDataStore.get(contentWithoutVersion), lang.hitch(this, function (content) {

                            var newData = [{
                                data: content,
                                type: this._getDndTypes(content.typeIdentifier)
                            }];

                            // Rebind source's properties:
                            //      targetAnchor
                            //      before
                            if (!this._source.targetAnchor) {
                                this._source.targetAnchor = targetAnchor;
                                this._source.before = before;
                            }

                            inherited.apply(this, [newData, source, nodes, isCopy]);

                        }));

                    }));

                } else {
                    this.executeAction(ModuleSettings.createNewFormsElementByDndActionName, itemData);
                }

                return;

            }

            this.inherited(arguments);
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

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