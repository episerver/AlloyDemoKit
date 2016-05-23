define([
// dojo
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/aspect',

    'dojo/dom-class',
// epi
    'epi-cms/contentediting/editors/CollectionEditor',
// epi-addons
    'epi-forms/contentediting/editors/DefaultGridAssembler',
    'epi-forms/contentediting/editors/viewmodels/CollectionEditorModel'
],
function (
// dojo
    declare,
    lang,

    aspect,

    domClass,
// epi
    CollectionEditor,
// epi-addons
    DefaultGridAssembler,
    CollectionEditorModel
) {

    // module:
    //      epi-forms/contentediting/editors/CollectionEditor
    // summary:
    //      Override 'epi-cms/contentediting/editors/CollectionEditor' class.
    //      Base class for FORM collection editor property that extended from CollectionEditor.
    // tags:
    //      public

    return declare([CollectionEditor], {

        // modelType: [public] Function
        //      The widget's model class. By default it is epi-cms/contentediting/editors/viewmodels/CollectionEditorModel
        modelType: CollectionEditorModel,

        // gridAssemblerType: [public] Function
        //      The grid assembler class.
        gridAssemblerType: DefaultGridAssembler,

        // =======================================================================
        // Public, overrided stubs
        // =======================================================================

        buildRendering: function () {

            this.inherited(arguments);

            this._setupLayout();

            this.own(
                aspect.after(this, 'onExecuteDialog', lang.hitch(this, function () {
                    // The CMS CollectionEditor has no focus (after making change and click on the popup's OK button) issue CMS-1903,
                    // explicitly set focus to the grid so that if blur happens the AutoSave will execute
                    this.grid.focus();
                }))
            );
        },

        // =======================================================================
        // Private stubs
        // =======================================================================

        _setupLayout: function () {
            // summary:
            //      Setup layout for this widget.
            // tags:
            //      private

            domClass.add(this.domNode, 'epi-forms-collection-editor');
        }

    });

});