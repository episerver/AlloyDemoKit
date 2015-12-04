define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/dom-class',
    'dojo/dom-construct',
// dijit
    'dijit/registry',
// epi-addons
    'epi-forms/contentediting/editors/CollectionEditor',

    'epi-forms/widget/FormContainer',
    'epi-forms/widget/PlaceHolderDropDownButton',
// resources
    'epi/i18n!epi/cms/nls/episerver.forms.editview'
],
function (
// dojo
    declare,
    lang,

    domClass,
    domConstruct,
// dijit
    registry,
// epi-addons
    CollectionEditor,

    FormContainer,
    PlaceHolderDropDownButton,
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