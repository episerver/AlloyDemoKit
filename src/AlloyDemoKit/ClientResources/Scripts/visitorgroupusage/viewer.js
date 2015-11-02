define([
    "dojo/_base/declare",
    "dojo/parser",
    "dojo/topic",
    "dojo/dom-class",
    "dijit/layout/_LayoutWidget",
    "dijit/_TemplatedMixin",
    "epi-cms/_ContentContextMixin",
    "epi/dependency",
    "epi-cms/widget/VisitorGroupButton"
], function (
    declare,
    parser,
    topic,
    domClass,
    layoutWidget,
    templatedMixin,
    contentContextMixin,
    locator,
    vgButton
) {
    return declare("visitorgroupusage",
        [layoutWidget, templatedMixin, contentContextMixin],
        {
            templateString: dojo.cache("/episerver/CMS/VisitorGroupUsage"),

            //startup: function () {
            postCreate: function () {
                this.inherited(arguments);
                var ctx = this.getCurrentContext();
                this._getVisitorGroups(ctx.id);

                this._visitorGroupsSelector = new vgButton();
            },

            contextChanged: function (context, callerData) {
                this._getVisitorGroups(context.id);
            },

            _getVisitorGroups: function (id) {

                var that = this;

                this._viewSettingsManager = locator.resolve('epi.viewsettingsmanager');
                var vg = this._viewSettingsManager.getSettingProperty('visitorgroup');
                //$.get('/episerver/CMS/VisitorGroupUsage/?id=' + id & "&vg=" + vg, function (xml) {

                $.get('/episerver/CMS/VisitorGroupUsage/?id=' + id + "&vg=" + vg, function (xml) {
                    if (xml == null || xml == "") {
                        that.xmlContent.innerHTML = "No visitor groups used on this content.";
                    } else {
                        if (that.xmlContent != null) {
                            that.xmlContent.innerHTML = xml;

                            //Click event works and selects the visitor group, however UI does not update, so commenting for now until the UI can be updated to show the selected visitor group
                            //dojo.query(".selected-VG").connect("onclick", function (evt) {
                            //    evt.currentTarget.children[0].className = "dijitReset dijitInline dijitIcon epi-iconCheckmark";
                            //    topic.publish("/epi/cms/action/eyetoggle", true);
                            //    topic.publish("/epi/cms/action/viewsettingvaluechanged", "visitorgroup", evt.currentTarget.dataset.visitorgroup);
                            //    domClass.add(this._visitorGroupsSelector, "dijitChecked");
                            //});
                        }
                    }
                });
            }

        });
});
