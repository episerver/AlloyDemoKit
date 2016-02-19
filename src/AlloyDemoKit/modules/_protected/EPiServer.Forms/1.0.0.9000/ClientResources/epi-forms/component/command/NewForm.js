define([
// dojo
    'dojo/_base/declare',

    'dojo/topic',
// epi
    'epi/shell/TypeDescriptorManager',
    'epi-cms/component/command/NewBlock',
// epi-addons
    'epi-forms/ModuleSettings',
// resources
    'epi/i18n!epi/cms/nls/episerver.forms.formscomponent'
],
function (
// dojo
    declare,

    topic,
// epi
    TypeDescriptorManager,
    NewBlockCommand,
// epi-addons
    ModuleSettings,
// resources
    resources
) {

    // module:
    //      epi-forms/component/command/NewForm
    // tags:
    //      public

    return declare([NewBlockCommand], {

        contentType: ModuleSettings.formContainerContentType,
        label: resources.command.create.label,

        _execute: function () {
            // summary:
            //      Override to add allowedTypes to allow only object of form and form element content types can be created. 
            // tags:
            //      protected, extensions

            topic.publish('/epi/shell/action/changeview', 'epi-cms/contentediting/CreateContent', null, {
                requestedType: this.contentType,
                parent: this.model,
                createAsLocalAsset: this.createAsLocalAsset,
                view: TypeDescriptorManager.getValue(this.contentType, 'createView'),
                allowedTypes: ModuleSettings.allowedFormContentTypes
            });
        }

    });

});