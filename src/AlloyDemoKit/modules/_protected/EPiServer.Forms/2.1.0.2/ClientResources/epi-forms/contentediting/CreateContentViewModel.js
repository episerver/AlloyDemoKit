define([
// dojo
    'dojo/_base/declare',
// epi
    'epi/shell/TypeDescriptorManager',
    'epi-cms/contentediting/viewmodel/CreateContentViewModel',
// epi-addons
    'epi-forms/ModuleSettings'
],
function (
// dojo
    declare,
// epi
    TypeDescriptorManager,
    CreateContentViewModel,
// epi-addons
    ModuleSettings
) {

    // module:
    //      epi-forms/contentediting/CreateContentViewModel
    // summary:
    //      Overrides CreateContentViewModel class in order to:
    //      - Sets showAllProperties option based on quick layout mode.
    //      - Sets content name based on EPiServer Forms element content type.
    // tags:
    //      public

    return declare([CreateContentViewModel], {

        // =======================================================================
        // Overrided stubs
        // =======================================================================

        _autoPublishSetter: function (/*Boolean*/autoPublish) {
            // summary:
            //      Sets:
            //      - showAllProperties option based on quick layout mode (ON/OFF) of the EPiServer Forms
            //      - autoPublish option.
            // autoPublish: [Boolean]
            //      The value.
            // tags:
            //      protected, extensions

            this.set('showAllProperties', ModuleSettings.quickLayout ? false : autoPublish);
            this.autoPublish = autoPublish;
        },

        _requestedTypeSetter: function (/*String*/requestedType) {
            // summary:
            //      Set requested type.
            //      After the value is set, heading text and content name are also updated.
            // requestedType: [String]
            //      The value.
            // tags:
            //      protected, extensions

            this.inherited(arguments);

            this.defaultName = TypeDescriptorManager.getResourceValue(requestedType, 'defaultname');
            this.set('contentName', TypeDescriptorManager.getResourceValue(requestedType, 'newitemdefaultname'));
        }

    });

});