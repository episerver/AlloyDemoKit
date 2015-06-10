dojo.require("epi-cms/ErrorDialog");
dojo.require("dojo/_base/array");
dojo.require('dojo.data.ItemFileReadStore');
dojo.require('dojo.store.DataStore');

(function () {
    // TECHNOTE: because we don't want to use ASPX page to render this script, this path will be hardcode here as the ModuleName
    var MODULE_ROOT_PATH = '../../EPiServer.ConnectForMarketingAutomation';


    return {
        createUI: function (namingContainer, container, settings, containerCallback) {
            var self = this;

            this.prototype.createUI.apply(this, arguments);
        },

        uiCreated: function(namingContainer, settings) {

            var modelSelection = dijit.byId(namingContainer + 'Model');
            modelSelection.set('searchAttr', 'Key');
            modelSelection.set('required', true);
            modelSelection.set('missingMessage', 'Model selection is required');
            dojo.connect(modelSelection, 'onChange', this, function (item) {
                                                    if (!loadingComplete || !modelSelection.isValid())
                                                        return;
                                                    loadRanks({ Model: item });
                                                });
            modelSelection.set('selectOnClick', true);

            var rankSelection = dijit.byId(namingContainer + 'Rank');
            rankSelection.set('searchAttr', 'Key');
            rankSelection.set('disabled', true);

            function loadScoringModels(settings, callback) {
                dojo.xhrGet({
                    url: MODULE_ROOT_PATH + '/ScoringRank/GetScoringModels',
                    handleAs: 'json',
                    error: epi.cms.ErrorDialog.showXmlHttpError,
                    load: function (jsonData) {
                        var store = new dojo.data.ItemFileReadStore({ data: jsonData });
                        modelSelection.store = dojo.store.DataStore({ store: store });
                            
                        if (settings) {
                            if (settings.Model && dojo.some(jsonData.items, function (item) { return item.Value == settings.Model })) {
                                modelSelection.set('value', settings.Model);
                            }
                            loadRanks(settings, callback);
                        } else {
                            if (callback) {
                                callback();
                            }
                        }
                    }
                });
            }

            function loadRanks(settings, callback) {
                if (!settings) {
                    if (callback) {
                        callback();
                    }
                    return;
                }

                dojo.xhrGet({
                    url: MODULE_ROOT_PATH + '/ScoringRank/GetScoringModels?scoringModelId=' + settings.Model,
                    handleAs: 'json',
                    error: epi.cms.ErrorDialog.showXmlHttpError,
                    load: function (jsonData) {
                        var store = new dojo.data.ItemFileReadStore({ data: jsonData });
                        rankSelection.store = dojo.store.DataStore({ store: store });
                        rankSelection.set('disabled', false);
                        
                        if (settings && settings.Rank && dojo.some(jsonData.items, function (item) { return item.Value == settings.Rank })) {
                            rankSelection.set('value', settings.Rank);
                            loadingComplete = true;
                        } else {
                            rankSelection.set('value', jsonData.items[0] ? jsonData.items[0].Value : "");
                            loadingComplete = true;
                        }
                    }
                });
            }

            var loadingComplete = false;

            // Load initial values and use selections from settings, and set loadingComplete to true after everything's complete.
            loadScoringModels(settings, function () {
                loadingComplete = true;
                //containerCallback(namingContainer, container);
            });
        },

        getSettings: function (namingContainer) {
            return {
                Model: dijit.byId(namingContainer + 'Model').get('value'),
                Rank: dijit.byId(namingContainer + 'Rank').get('value'),
            };
        }
    };
})();