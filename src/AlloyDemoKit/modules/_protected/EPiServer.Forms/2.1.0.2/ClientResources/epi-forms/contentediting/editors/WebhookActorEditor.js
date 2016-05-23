define([
// dojo
    'dojo/_base/declare',
// epi-addons
    'epi-forms/contentediting/editors/CollectionEditor',
// resources
    'epi/i18n!epi/cms/nls/episerver.forms.editview'
],
function (
// dojo
    declare,
// epi-addons
    CollectionEditor,
// resources
    resources
) {

    // module:
    //      epi-forms/contentediting/editors/WebhookActorEditor
    // summary:
    //      Editor for Webhook.
    // tags:
    //      public

    return declare([CollectionEditor], {

        _getDialogTitleText: function (existingItem) {
            // summary:
            //      Get dialog title for create/edit Webhoook.
            // tags:
            //      Override

            return existingItem ? resources.editwebhook : resources.addwebhook;
        }

    });

});