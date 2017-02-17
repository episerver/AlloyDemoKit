define([
       "dojo/_base/declare",
       "epi/shell/command/_Command",
       "epi-cms/widget/ContentReferences",
       "epi/shell/widget/dialog/Dialog",
       "epi/shell/TypeDescriptorManager",
       "epi/i18n!epi/cms/nls/episerver.cms.widget.contentreferences"
],
   function (
       declare,
       _Command,
       ContentReferences,
       Dialog,
       TypeDescriptorManager) {
       return declare([_Command], {
           name: "ContentReferences",
           label: "Content references",
           tooltip: "Show content references",
           iconClass: "epi-iconReferences",
           canExecute: true,

           _execute: function () {

               var contentItems = [this.model.contentData];
               var params = { contentItems: contentItems, mode: "show" };
               var content = new ContentReferences(params);
               content.startup();

               var dialog = new Dialog({
                   defaultActionsVisible: false,
                   focusActionsOnLoad: true,
                   destroyOnHide: true,
                   dialogClass: "epi-dialog-contentReferences",
                   title: TypeDescriptorManager.getResourceValue(this.model.contentData.typeIdentifier, "references"),
                   content: content
               });

               dialog.definitionConsumer.add({
                   name: "close",
                   label: epi.resources.action.close,
                   action: dialog.onCancel
               });

               dialog.show();

               var handle = content.on("viewReference", function () {
                   dialog.hide();
                   handle.remove();
               });
           }
       });
   });