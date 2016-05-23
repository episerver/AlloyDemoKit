define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/topic',
    'dojo/when',
// epi
    'epi/shell/TypeDescriptorManager',
    'epi-cms/widget/command/CreateContentFromSelector',
// epi-addons
    'epi-forms/ModuleSettings'
],
function (
// dojo
    declare,
    lang,

    topic,
    when,
// epi
    TypeDescriptorManager,
    CreateContentFromSelector,
// epi-addons
    ModuleSettings
) {

    // module:
    //      epi-forms/widget/command/CreateContentFromSelector
    // summary:
    //      
    // tags:
    //      public

    return declare([CreateContentFromSelector], {

        constructor: function () {
            // Use settings to display root folder of EPiServer Forms on SelectContentDialog
            this.set('roots', ModuleSettings.roots);
        },

        _switchView: function (/*Object*/content) {
            // summary:
            //      Change view to Create Content with parent content
            // content: [Object]
            //      
            // tags:
            //      protected, extensions

            when(this.getCurrentContent(), lang.hitch(this, function (contextContent) {
                topic.publish('/epi/shell/action/changeview', 'epi-forms/contentediting/CreateContent', null, {
                    contentTypeId: this.contentTypeId,
                    requestedType: this.creatingTypeIdentifier,
                    parent: contextContent,
                    addToDestination: this.model,
                    createAsLocalAsset: true,
                    treatAsSecondaryView: true,
                    view: TypeDescriptorManager.getValue(this.creatingTypeIdentifier, 'createView'),
                    autoPublish: true,
                    allowedTypes: this.allowedTypes,
                    restrictedTypes: this.restrictedTypes,
                    showAllProperties: false
                });
            }));
        }

    });

});