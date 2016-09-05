define([
    "dojo",
    "dojo/_base/declare",
    "epi/shell/command/_CommandProviderMixin",
    "commands/samples/showRelatedPagesCommand"
], function (dojo, declare, _CommandProviderMixin, ShowRelatedPagesCommand) {
    return declare([_CommandProviderMixin], {

        constructor: function () {
            this.inherited(arguments);

            var showRelatedPagesCommand = new ShowRelatedPagesCommand();
            this.add("commands", showRelatedPagesCommand);
        }
    });
});