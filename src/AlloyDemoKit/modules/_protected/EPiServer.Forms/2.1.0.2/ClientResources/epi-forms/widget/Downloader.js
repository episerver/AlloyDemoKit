define([
// Dojo
    "dojo/_base/lang",
    "dojo/dom-construct",
// Epi Framwork
    "epi/shell/XhrWrapper",

// Epi Forms
    "epi-forms/ModuleSettings",
],
function (
// Dojo
    lang,
    domConstruct,
// Epi Framework
    XhrWrapper,

// EPi Forms
    ModuleSettings
) {
    return {
        // summary:
        //      Downloader static class that used to force download media file from browser by javascript.
        // tags:
        //      internal

        // xhrHandler: [private] Object
        //  The xhr implementation to use when requesting data. Defaults to epi.shell.XhrWrapper
        _xhrHandler: new XhrWrapper(),

        _classicalDownload: function (/*String*/url, /*String*/name) {
            // summary:
            //      Classical method to download file by direct url.
            // tags:
            //      private

            // Create a temporary anchor link, trigger click event and then destroy it!
            var bodyNode = document.getElementsByTagName("body")[0],
                dowloadLinkAttributes = {
                    href: url,
                    download: name,
                    target: "_blank",
                    style: { display: "none;" }
                },
                downloadLinkNode = domConstruct.create("a", dowloadLinkAttributes, bodyNode, "last");

            downloadLinkNode.click();
            domConstruct.destroy(downloadLinkNode);
        },

        download: function (/*Object*/postData, /*Function*/callback) {
            // summary:
            //      Download and save a blob content to local device.
            // tags:
            //      public virtual

            // Need to call PrepaireExport because the postData might contains large data of post ids,
            // and it cannot be handle by a GET request
            this._xhrHandler.xhrPost({
                url: ModuleSettings.prepareExportUrl,
                handleAs: "json",
                content: postData
            }).then(lang.hitch(this, function (result) {
                var url = ModuleSettings.exportingUrl + "?token=" + result.Token;
                this._classicalDownload(url)
                if (callback) {
                    callback();
                }
            }));
        }
    };
});