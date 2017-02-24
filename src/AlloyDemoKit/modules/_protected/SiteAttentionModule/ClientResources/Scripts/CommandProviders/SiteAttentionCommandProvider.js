/* The Command Provider*/
define([
"dojo/_base/declare",
"dojo/topic",
"epi/shell/command/_CommandProviderMixin"],

function (declare, topic, _CommandProviderMixin) {
    return declare([_CommandProviderMixin], {

        _propertyEditedHandle: null,
        _someArray: null,

        someData: null,

        updateCommandModel: function (model) {
            // summary:
            //      Updates the model for the commands.
            // tags:
            //      public

            this.inherited(arguments);

            if (this._propertyEditedHandle) {
                this._propertyEditedHandle.remove();
            }

            this._propertyEditedHandle = model.contentModel.watch(function (name, oldValue, value) {
                console.log(name, value);
                EPiServerSiteAttentionData.onContentChange.raise(name, oldValue == null ? '' : oldValue, value);

            });

            // Keep track also of widgets change becaus the model watch will not cover all changes
            require(["dojo/ready", "dojo/topic", "dojo/_base/array"], function (ready, topic, array) {
                ready(function () {
                    EPiServerSiteAttentionData.initializeWidgetWatch();
                    EPiServerSiteAttentionData.waitForAllWidgets();
                })
            });

            topic.publish("siteattention/modelchanged", model);
        }

    });
});
