define(
    ["dojo/_base/declare",
     "dojo/dom-attr",
     "dojo/_base/lang",
     "dojo/topic",
     "dojo/query",
     "dojo/cookie",
     "epi/Url",
     "epi/i18n!epi/shell/ui/nls/EPiServer.Shell.UI.Resources.GlobalMenu"],
    function (
        declare,
        domAttr,
        lang,
        topic,
        query,
        cookie,
        Url,
        resources) {
        return declare([], {

            res: resources,
            _siteUrl: null,
            _handle: null,

            initialize: function () {
                this.inherited(arguments);
                topic.subscribe("/epi/shell/context/changed", lang.hitch(this, "_onContextChanged"));

                // Required to set up on first initialisation
                _handle = topic.subscribe("/epi/shell/context/current", lang.hitch(this, "_onContextCurrent"));
            },


            _onContextCurrent: function (ctx) {
                _handle.remove();
                this._onContextChanged(ctx);
            },

            //_onContextChanged: function (ctx, callerData) {
            _onContextChanged: function (ctx) {

                //Only do this if the menu is pinned out
                if (cookie("menupin") === "true") {

                    var toViewModeElement = this._getToViewModeElement();
                    //Only change the URL if we have one site
                    if (!toViewModeElement) {
                        return;
                    }

                    var url = this._buildPublicUrl(ctx, toViewModeElement);
                    var title = lang.replace(this.res.toviewmode, [url.toString()]);

                    domAttr.set(toViewModeElement, { href: url.path, title: title });
                }
            },

            _getToViewModeElement: function () {

                var utilItemsContainer = query(".epi-navigation-container-utils", this.element)[0];
                return query(".epi-navigation-global_sites.epi-navigation-currentSite.epi-navigation-iconic", utilItemsContainer)[0];
            },

            _buildPublicUrl: function (ctx, viewModeElement) {

                if (this._siteUrl === null) {
                    this._siteUrl = viewModeElement.href;
                }

                var siteUrl = new Url(this._siteUrl);
                var location = window.location;
                var params = {
                    scheme: location.protocol,
                    authority: location.host,
                    path: ctx.publicUrl === "" ? siteUrl.path : ctx.publicUrl
                };
                var url = new Url(null, params, true);

                return url;
            }

        });
    });