define([
// Dojo
    "dojo",
    "dojo/_base/declare",
//CMS
    "epi/_Module",
    "epi/dependency",
    "epi/routes",
    "commands/samples/commandsInitializer",
    "menupin/MenuPinInit"
], function (
// Dojo
    dojo,
    declare,
//CMS
    _Module,
    dependency,
    routes,
    MyInitializer,
    MenuPinInit
) {

    return declare("app.Initializer", [_Module], {
        // summary: Module initializer for the default module.

        initialize: function () {

            this.inherited(arguments);

            var myinitializer = new MyInitializer();
            myinitializer.initialize();

            var minitializer = new MenuPinInit();
            minitializer.initialize();
        }
    });
});