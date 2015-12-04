define([
// dojo
    'dojo/_base/array',
    'dojo/_base/connect',
    'dojo/_base/declare',
    'dojo/_base/lang',

    'dojo/dom-style',
// epi
    'epi-cms/widget/LinkEditor',
// epi-addons
    'epi-forms/ModuleSettings'
],
function (
// dojo
    array,
    connect,
    declare,
    lang,

    domStyle,
// epi
    LinkEditor,
// epi-addons
    ModuleSettings
) {

    // module:
    //      epi-forms/widget/ImageChoiceSelector
    // summary:
    //      Represents the widget to edit PropertyURL.
    // tags:
    //      internal

    return declare([LinkEditor], {

        onFormCreated: function (widget) {

            this.inherited(arguments);

            // find out the child widget called href (it is HyperLinkSelector) inside the LinkEditor
            var hrefWidget = this.getFormWidget('href');
            if (hrefWidget == null || typeof hrefWidget.onSelectorsCreated !== 'function') {
                return;
            }

            // hide the contained Language widget since this selector is only specific to Media content which is the same in all languages
            hrefWidget.set('showLanguageSelector', false);

            // only show the contained Media widget (inside the hrefWidget), could not based on "wrappers" change because "wrappers" change only ONE time
            // causes the callback runs only ONE time too then hrefWidget.watch (commented below) does't work as expected.
            this._showMediaWidget(hrefWidget, hrefWidget.get('wrappers'));

            // show Media and hide other widgets at the "very first time" of the form
            connect.connect(hrefWidget, 'onSelectorsCreated', lang.hitch(this, function () {
                var wrappers = hrefWidget.get('wrappers');
                this._showMediaWidget(hrefWidget, wrappers);
            }));
        },

        _showMediaWidget: function (container, wrappers) {
            array.forEach(wrappers, function (wrapper) {
                if (wrapper.name === 'Media') {
                    // Only image type allowed to show on content selector dialog
                    wrapper.inputWidget.set('allowedTypes', ModuleSettings.imageChoiceAllowedTypes);

                    // make the Media Wrapper is selected one and hide its radio because now there is only one Media Wrapper
                    container.set('selectedWrapper', wrapper);
                    domStyle.set(wrapper.radioNode, { 'display': 'none' });
                }
                else {
                    domStyle.set(wrapper.domNode, { 'display': 'none' });
                }
            }, this);
        }

    });

});