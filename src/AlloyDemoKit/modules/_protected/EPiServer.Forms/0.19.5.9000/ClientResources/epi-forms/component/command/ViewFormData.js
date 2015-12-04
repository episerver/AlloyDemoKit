define([
// dojo
    'dojo/_base/declare',
// epi
    'epi-cms/component/command/ChangeContext',
// resources
    'epi/i18n!epi/cms/nls/episerver.forms.formscomponent'
],

function (
// dojo
    declare,
// epi
    ChangeContextCommand,
// resources
    resources
) {

    // module:
    //      epi-forms/component/command/ViewFormData
    // tags:
    //      public

    return declare([ChangeContextCommand], {

        // Request the view form data view.
        viewName: 'FormData',

        _onModelChange: function () {
            // summary:
            //      Updates label for command to view data instead of the default label (view or edit).
            // tags:
            //      protected

            this.inherited(arguments);

            this.set('label', resources.command.viewdata.label);
            this.set('iconClass', 'epi-iconList');
        }

    });

});