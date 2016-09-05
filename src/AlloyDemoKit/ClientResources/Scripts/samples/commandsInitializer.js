define([
    "dojo",
    "dojo/_base/declare",
    "epi/_Module",
    "epi/dependency",
    "epi/routes",
    "commands/samples/relatedPagesCommandProvider"
], function (
    dojo,
    declare,
    _Module,
    dependency,
    routes,
    RelatedPagesCommandProvider
) {
    return declare([_Module], {
        initialize: function () {
            this.inherited(arguments);

            var relatedPagesCommandProvider = new RelatedPagesCommandProvider();

            var commandregistry = dependency.resolve("epi.globalcommandregistry");
            var area = "epi.cms.publishmenu";
            commandregistry.registerProvider(area, relatedPagesCommandProvider);
        }
    });
});