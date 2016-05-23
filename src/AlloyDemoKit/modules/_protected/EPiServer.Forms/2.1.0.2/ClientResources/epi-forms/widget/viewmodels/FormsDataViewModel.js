define([
// dojo
    "dojo/_base/declare",
    "dojo/_base/lang",

    "dojo/Deferred",
    "dojo/Stateful",
    "dojo/when",
// epi
    "epi/shell/DestroyableByKey",
    "epi/dependency",

    "epi-cms/_ContentContextMixin",
// epi-addons
    'epi-forms/widget/Downloader'
],
function (
// dojo
    declare,
    lang,

    Deferred,
    Stateful,
    when,
// epi
    DestroyableByKey,
    dependency,

    _ContentContextMixin,
// epi-addons
    Downloader
) {

    return declare([Stateful, DestroyableByKey, _ContentContextMixin], {

        // store: [readonly] Rest store
        //      The form data store
        store: null,

        postscript: function () {
            // summary:
            //      Setup mixed in properties
            // tags:
            //      protected
            var registry = dependency.resolve("epi.storeregistry");
            this.store = registry.get("epi-forms.formsdata");

            this.inherited(arguments);

            this.set("store", this.store);

            when(this.getCurrentContext(), lang.hitch(this, function (context) {
                this._fetchData(context);
            }));
        },

        contentContextChanged: function (context, callerData) {
            // summary:
            //      Fetching data when the context change.
            // tags:
            //      override

            this.inherited(arguments);

            // reset beginDate and endDate fields when context changed
            this.set("beginDate", null);
            this.set("endDate", null);
            this.set("finalizedOnly", false);
            this._fetchData(context);
        },

        getColumns: function () {

            var def = new Deferred();

            when(this.getCurrentContext(), lang.hitch(this, function (context) {
                when(this.store.query({ query: "getcolumns", parent: context.id }), lang.hitch(this, function (items) {
                    def.resolve(items);
                }));
            }));

            return def;
        },

        getChartData: function (beginDate, endDate, finalizedOnly) {
            // summary:
            //      Get data to draw chart
            // tags:
            //      public
            var def = new Deferred();

            when(this.getCurrentContext(), lang.hitch(this, function (context) {
                when(this.store.query({ query: "getchartdata", parent: context.id, beginDate: beginDate, endDate: endDate, finalizedOnly: finalizedOnly }), lang.hitch(this, function (data) {
                    def.resolve(data);
                }));
            }));

            return def;
        },

        exportData: function (extension, submissionIds, beginDate, endDate, finalizedOnly, callback) {
            // summary:
            //      Get exported data file
            // tags:
            //      public

            Downloader.download({
                contentLink: this._currentContext.id,
                extension: extension,
                submissionIds: submissionIds,
                beginDate: beginDate,
                endDate: endDate,
                finalizedOnly: finalizedOnly
            }, callback);
        },

        deleteData: function (submissionIds) {
            // summary:
            //      Delete selected posts
            // tags:
            //      public

            var def = new Deferred();

            when(this.store.executeMethod("DeleteData", null,
                {
                    contentLink: this._currentContext.id,
                    submissionIds: submissionIds
                }), lang.hitch(this, function (result) {
                    def.resolve(result);
                }));

            return def;
        },

        _fetchData: function (context) {
            // summary:
            //      Fetch data from store
            // tags:
            //      private

            this.set("query", { parent: context.id });
        }

    });

});