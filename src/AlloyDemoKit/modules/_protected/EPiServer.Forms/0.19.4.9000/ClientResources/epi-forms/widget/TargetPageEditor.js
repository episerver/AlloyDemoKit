define([
// dojo
    'dojo/_base/array',
    'dojo/_base/connect',
    'dojo/_base/declare',
    'dojo/_base/lang',
    'dojo/dom-style',

// epi
    'epi-cms/widget/LinkEditor'

],
function (
// dojo
    array,
    connect,
    declare,
    lang,
    domStyle,

// epi
    LinkEditor
    ) {

    return declare([LinkEditor], {
        // summary:
        //    Represents the widget to edit PropertyURL.
        // tags:
        //    internal

        _hiddenChildFields: ['Media', 'Email', 'ExternalLink', 'Anchor'],

        onFormCreated: function (widget) {

            this.inherited(arguments);

            // find out the child widget called href (it is HyperLinkSelector) inside the LinkEditor
            var hrefWidget = this.getFormWidget('href');
            if (hrefWidget == null || typeof hrefWidget.onSelectorsCreated !== 'function') {
                return;
            }

            // hide the contained Language widget since the language is from the language of page which is viewing in View mode.
            hrefWidget.set('showLanguageSelector', false);

            // hide non-Page widgets (inside the hrefWidget), could not based on 'wrappers' change because 'wrappers' change only ONE time
            // causes the callback runs only ONE time too then hrefWidget.watch (commented below) does't work as expected.
            this._hideChildWidgets(hrefWidget.get('wrappers'));

            // hide non-Page widgets at the 'very first time' of the form
            connect.connect(hrefWidget, 'onSelectorsCreated', lang.hitch(this, function () {
                this._hideChildWidgets(hrefWidget.get('wrappers'));
            }));
        },

        _hideChildWidgets: function (wrappers) {
            array.forEach(wrappers, function (wrapper) {
                domStyle.set(wrapper.domNode, {
                    'display': this._hiddenChildFields.indexOf(wrapper.name) != -1 ? 'none' : ''
                });
            }, this);
        }

    });
});
