dojo.require("epi-cms/ErrorDialog");
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

        uiCreated: function (namingContainer, settings) {
            require([
                // Dojo
                "dojo/_base/array",
                "dojo/dom-style"
            ], function (
                // Dojo
                array,
                domStyle
            ) {

                var databaseSelection = dijit.byId(namingContainer + 'Database'),
                    databaseRowNode = dijit.getEnclosingWidget(databaseSelection.domNode).domNode.parentNode;
                databaseSelection.set('searchAttr', 'Key');
                databaseSelection.set('required', true);
                databaseSelection.set('missingMessage', 'Database selection is required');
                dojo.connect(databaseSelection, 'onChange', this, function (item) {
                    if (!loadingComplete || !databaseSelection.isValid())
                        return;
                    loadColumns({ Database: item });
                });
                databaseSelection.set('selectOnClick', true);

                var columnSelection = dijit.byId(namingContainer + 'Column');
                columnSelection.set('searchAttr', 'Key');
                columnSelection.set('disabled', true);

                var conditionSelection = dijit.byId(namingContainer + "Condition"),
                    conditionValue = conditionSelection.get("value"),
                    valueInput = dijit.byId(namingContainer + "Value"),
                    valueRowNode = dijit.getEnclosingWidget(valueInput.domNode).domNode.parentNode;
                dojo.connect(conditionSelection, "onChange", this, updateUIElements);

                function loadDatabases(settings, callback) {
                    dojo.xhrGet({
                        url: MODULE_ROOT_PATH + '/Database/GetDatabaseRecords',
                        handleAs: 'json',
                        error: epi.cms.ErrorDialog.showXmlHttpError,
                        load: function (jsonData) {
                            if (jsonData.items == null || jsonData.items.length == 0) {
                                // In case there are no database returned, there might only 1 common database existing,
                                // hide the database row and try to load the columns.
                                domStyle.set(databaseRowNode, 'display', 'none');
                                loadColumns({ Database: -1 });
                                return;
                            }

                            var store = new dojo.data.ItemFileReadStore({ data: jsonData });
                            databaseSelection.store = dojo.store.DataStore({ store: store });

                            if (settings) {
                                if (settings.Database && array.some(jsonData.items, function (item) { return item.Value == settings.Database })) {
                                    databaseSelection.set('value', settings.Database);
                                }
                                loadColumns(settings, callback);
                            } else {
                                if (callback) {
                                    callback();
                                }
                            }
                        }
                    });
                }

                function loadColumns(settings, callback) {
                    if (!settings) {
                        if (callback) {
                            callback();
                        }
                        return;
                    }

                    dojo.xhrGet({
                        url: MODULE_ROOT_PATH + '/Database/GetDatabaseColumnRecords?databaseId=' + settings.Database,
                        handleAs: 'json',
                        error: epi.cms.ErrorDialog.showXmlHttpError,
                        load: function (jsonData) {
                            var store = new dojo.data.ItemFileReadStore({ data: jsonData });
                            columnSelection.store = dojo.store.DataStore({ store: store });
                            columnSelection.set('disabled', false);
                            if (settings.Column && array.some(jsonData.items, function (item) { return item.Value == settings.Column })) {
                                columnSelection.set('value', settings.Column);
                                loadingComplete = true;
                            } else {
                                columnSelection.set('value', '*');
                            }
                        }
                    });
                }

                function updateUIElements(value) {
                    // Update UI when condition is changed.
                    if (value == '3' || value == '4') {
                        domStyle.set(valueRowNode, 'display', 'none');
                        valueInput.set('value', '');
                    } else {
                        domStyle.set(valueRowNode, 'display', '');
                    }
                }

                var loadingComplete = false;

                // Load initial values and use selections from settings, and set loadingComplete to true after everything's complete.
                loadDatabases(settings, function () {
                    loadingComplete = true;
                    //containerCallback(namingContainer, container);
                });

                // initialize UI
                updateUIElements(conditionValue);
            });
        },

        getSettings: function (namingContainer) {
            return {
                Database: dijit.byId(namingContainer + 'Database').get('value'),
                Column: dijit.byId(namingContainer + 'Column').get('value'),
                Condition: dijit.byId(namingContainer + 'Condition').get('value'),
                Value: dijit.byId(namingContainer + 'Value').get('value')
            };
        }
    };
})();