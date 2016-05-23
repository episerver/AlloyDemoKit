define([
    "dojo/_base/array",
    "dojo/_base/declare",
    "dojo/_base/lang",
    "dojo/_base/connect",

    "dojo/aspect",

    "dojo/dom-construct",
    "dojo/dom-class",
    "dojo/dom-style",
    "dojo/string",
    "dojo/when",
// dijit
    "dijit/_TemplatedMixin",
    "dijit/_WidgetsInTemplateMixin",
    "dijit/_Widget",

    "dijit/layout/ContentPane", // used in template
    "dijit/layout/StackContainer", // used in template

    "dijit/form/Button", // used in template
// dojox
    "dojox/widget/Standby",

    "dojox/charting/Chart",
    "dojox/charting/themes/MiamiNice",
    "dojox/charting/plot2d/Columns",
    "dojox/charting/plot2d/Markers",
    "dojox/charting/axis2d/Default",
    "dojox/charting/action2d/Tooltip",

// dgrid
    "dgrid/OnDemandGrid",
    "dgrid/Selection",
    "dgrid/Keyboard",
    "dgrid/extensions/ColumnResizer",
    "dgrid/selector",
// epi
    "epi/datetime",
    "epi/shell/widget/_ModelBindingMixin",
    "epi/shell/dgrid/Formatter",
    "epi/shell/dgrid/util/misc",
    "epi-cms/contentediting/ContentActionSupport",
    "epi-cms/contentediting/StandardToolbar",
    "epi/shell/widget/SearchBox",
    "epi/shell/widget/DateTimeSelectorDropDown",
    "epi/shell/widget/dialog/Confirmation",
    "epi/shell/layout/CardContainer",
    "epi/shell/layout/PreserveRatioBorderContainer",
// epi-addons
    "epi-forms/dgrid/Formatters",
    "epi-forms/ModuleSettings",
    "epi-forms/widget/ExportDropDownButton",
    "epi-forms/widget/viewmodels/FormsDataViewModel",
// resources
    "epi/i18n!epi/cms/nls/episerver.forms.formdataview",
    "dojo/text!./templates/FormsData.html"
],
function (
    array,
    declare,
    lang,
    connect,

    aspect,

    domConstruct,
    domClass,
    domStyle,
    string,
    when,
// dijit
    _TemplatedMixin,
    _WidgetsInTemplateMixin,
    _Widget,

    ContentPane, // used in template
    StackContainer, // used in template

    Button, // used in template
// dojox
    Standby,
    Chart,
    theme,
    Columns,
    Markers,
    Default,
    Tooltip,

// dgrid
    OnDemandGrid,
    DgridSelection,
    Keyboard,
    ColumnResizer,
    selector,

// epi
    epiDateTime,
    _ModelBindingMixin,
    Formatter,
    GridMiscUtil,
    ContentActionSupport,
    StandardToolbar,
    SearchBox,
    DateTimeSelectorDropDown,
    Confirmation,
    CardContainer,
    PreserveRatioBorderContainer,

// epi-addons
    Formatters,
    ModuleSettings,
    ExportDropDownButton,
    FormsDataViewModel,
// resources
    res,
    template
 ) {

    return declare([_Widget, _TemplatedMixin, _WidgetsInTemplateMixin, _ModelBindingMixin], {

        res: res,

        templateString: template,

        modelClass: FormsDataViewModel,

        _dateTimeFormatType: "DateTime",

        //_datetimeFormatType: "DateTime",
        _linkFormatType: "Link",

        _checkedFormatType: "Checked",

        // modelBindingMap: [protected] Object
        //      Contains information which is used for mapping properties between View and ViewModel.
        modelBindingMap: {
            "query": ["query"],
            "chartData": ["chartData"],
            "beginDate": ["beginDate"],
            "endDate": ["endDate"],
            "finalizedOnly": ["finalizedOnly"]
        },

        postCreate: function () {
            this.inherited(arguments);

            this.toolbar = new StandardToolbar();
            this.toolbar.placeAt(this.toolbarArea, "first");

            var model = new this.modelClass();
            this.set("model", model);

            this._setupExportDropDownButton();

            this.deleteSelectedButton.set('disabled', true);

            this.own(
                this.deleteSelectedButton.on("click", lang.hitch(this, function () { this._onDelete(); })),

                connect.connect(this, "resize", lang.hitch(this, function () {
                    this.mainLayoutContainer.resize();
                    this.tabContainer.resize();
                    this.contentPane.resize();
                })),

                connect.connect(this.contentPane, "resize", lang.hitch(this, function () {
                    if (this._chart) {
                        this._chart.resize();
                    }
                }))
            );
        },

        updateView: function (data, context, additionalParams) {

            when(this.model.contentDataStore.get(context.id), lang.hitch(this, function (content) {
                if (!ContentActionSupport.hasAccess(content.accessMask, ModuleSettings.minimumAccessRightLevelToReadFormData)) {
                    this._updateToolbar(data, context);
                    this._toggleMessageContentPane(true);

                    this.messageContentPane.set("content", string.substitute("<span class='dijitContentPaneError'><span class='dijitInline dijitIconError'></span>${accessdenied}</span>", this.res));

                    return;
                }

                if (data && data.skipUpdateView) {
                    return;
                }

                this._updateToolbar(data, context);
                this._toggleMessageContentPane(false);

                // need to redraw chart when the view is shown
                if (data && data.forceContextChange === true) {
                    this._updateChart(null, null);
                } else {
                    var beginDate = epiDateTime.transformDate(this.beginDate.get("value")),
                        endDate = epiDateTime.transformDate(this.endDate.get("value"));

                    this._updateChart(beginDate, endDate);
                }

            }));

        },

        destroy: function () {
            // summary:
            //      Destroy the object.
            // tags:
            //      public, extensions

            this._destroyChildWidgets();

            this.inherited(arguments);
        },

        _destroyChildWidgets: function () {
            // summary:
            //      Destroy children widget
            // tags:
            //      private

            if (this._standby) {
                this._standby.destroyRecursive();
                this._standby = null;
            }

            if (this._grid) {
                this._grid.destroy();
                this._grid = null;
            }
        },

        _setupExportDropDownButton: function () {
            // summary:
            //      Build menu items for export drop-down button.
            // tags:
            //      private

            this.exportSelector.set("menuItems", [
                {
                    exportType: "xml",
                    label: res.exportasxml,
                    description: res.exportasxmldesc,
                    onExport: lang.hitch(this, this._onExport)
                },
                {
                    exportType: "csv",
                    label: res.exportascsv,
                    description: res.exportascsvdesc,
                    onExport: lang.hitch(this, this._onExport)
                },
                {
                    exportType: "json",
                    label: res.exportasjson,
                    description: res.exportasjsondesc,
                    onExport: lang.hitch(this, this._onExport)
                }
            ]);
        },

        _refresh: function (query) {
            // summary:
            //      Destroy the old dgrid, get new data and re-render dgrid
            // tags:
            //      private

            if (this._grid) {
                this._grid.cleanup();
                this._grid.destroy();
            }

            if (this._standby) {
                this._standby.destroyRecursive();
                this._standby = null;
            }

            when(this.model.getColumns(), lang.hitch(this, function (columns) {

                if (!columns) {
                    return;
                }

                columns.forEach(function (item) {
                    lang.mixin(item, { sortable: false });

                    if (item.formatType == this._dateTimeFormatType) {
                        // inject formater for SubmitTime field
                        lang.mixin(item, { formatters: [Formatters.dateTimeFormatter, GridMiscUtil.ellipsis] });
                    } else if (item.formatType == this._linkFormatType) {
                        // inject formater for link field
                        lang.mixin(item, { formatters: [Formatters.embededLinksFormatter] });
                    } else if (item.formatType == this._checkedFormatType) {
                        lang.mixin(item, { formatters: [Formatters.checkedFormatter] });
                    } else {
                        lang.mixin(item, { formatters: [Formatters.removeNullValueFormatter, Formatters.encodeAndEllipsisFormatter] });
                    }
                }, this);

                // insert checkbox column at 0
                columns.splice(0, 0, selector({
                    label: "",
                    selectorType: "checkbox",
                    className: "epi-columnVeryNarrow"
                }));

                var gridClass = declare([OnDemandGrid, DgridSelection, Keyboard, Formatter, ColumnResizer]);
                this._grid = new gridClass({
                    store: this.model.store,
                    columns: columns,
                    minWidth: 100,
                    noDataMessage: this._getNoDataMessage(),
                    selectionMode: "none",
                    allowSelectAll: true
                });
                this._grid.styleColumn("SYSTEMCOLUMN_SubmissionId", "display: none;"); // hide the submissionId column through its Id
                domConstruct.place(this._grid.domNode, this.gridContainerNode);

                aspect.after(this._grid, "_processScroll", lang.hitch(this, function () {
                    this._showStandby(false);
                }));

                this._standby = new Standby({ target: this.stackContainer, color: "#fff" }).placeAt(document.body);
                this._standby.startup();

                this._grid.on('dgrid-refresh-complete', lang.hitch(this, function (event) {
                    this._resizeChart();
                    // show/hide Export, Delete buttons depend on data
                    domStyle.set(this.trailingNode, "display", this._grid._total == 0 ? "none" : "");
                }));

                this.own(
                    this._grid.on('dgrid-select', lang.hitch(this, this._toggleButtonsState)),
                    this._grid.on('dgrid-deselect', lang.hitch(this, this._toggleButtonsState))
                );

                this._grid.set("query", query);
            }));
        },

        _toggleButtonsState: function (/*Object*/event) {
            // summary:
            //      Toggle state of buttons.
            // event: [Object]
            //      Event object of dgrid: 'dgrid-select' and 'dgrid-deselect'.
            // tags:
            //      private

            var isActive = false,
                selection = event && event.grid && event.grid.selection;
            if (selection) {
                isActive = Object.keys(event.grid.selection).length > 0;
            }

            this.deleteSelectedButton.set('disabled', !isActive);
        },

        _onSearch: function () {
            // summary:
            //      Search submission in a specified date time range
            // tags:
            //      private

            // TECHNOTE:
            //      Defers clicking on the Search button multiple times.
            this.searchButton.set('disabled', true);
            setTimeout(lang.hitch(this, function () {
                this.searchButton.set('disabled', false);
            }), 1000);

            this._showStandby(true);

            when(this.model.getCurrentContext(), lang.hitch(this, function (context) {
                var beginDate = epiDateTime.transformDate(this.beginDate.get("value")),
                    endDate = epiDateTime.transformDate(this.endDate.get("value")),
                    finalizedOnly = this.finalizedOnly.checked;


                this._updateChart(beginDate, endDate, finalizedOnly);
                this._refresh({ parent: context.id, beginDate: beginDate, endDate: endDate, finalizedOnly: finalizedOnly });
            }));
        },

        _onExport: function (contentType) {
            // summary:
            //      Exporting submission data within a specified date time range
            // tags:
            //      private

            this._showStandby(true);
            var hideStandby = lang.hitch(this, function () {
                this._showStandby(false);
            });

            // exporting bases on filter, selected items take higher priority
            var selection = this._getSelectedItems();
            if (selection.length > 0) {
                this.model.exportData(contentType, selection, null, null, false, hideStandby);
            }
            else {
                var beginDate = epiDateTime.transformDate(this.beginDate.get("value")),
                    endDate = epiDateTime.transformDate(this.endDate.get("value")),
                    finalizedOnly = this.finalizedOnly.checked;

                this.model.exportData(contentType, null, beginDate, endDate, finalizedOnly, hideStandby);
            }
        },

        _onDelete: function () {
            // summary:
            //      Deleting submission data for checked items
            // tags:
            //      private

            var selection = this._getSelectedItems();
            if (!(selection instanceof Array) || selection.length < 1) {
                return;
            }

            this._showConfirmationDialog(this.res.deleteconfirmation, lang.hitch(this, function (confirm) {
                if (confirm) {
                    this._showStandby(true);

                    when(this.model.deleteData(selection), lang.hitch(this, function (result) {
                        if (result.isSuccess == true) {
                            this._onSearch();
                        }

                        this._showStandby(false);
                    }));
                }
            }));
        },

        _getNoDataMessage: function () {
            // summary:
            //      Get message in case have no data.
            // tags:
            //      private

            return '<span><span class="dijitReset dijitInline">' + res.nodata + '</span></span>';
        },

        _setQueryAttr: function (/*Object*/value) {
            // summary:
            //      Set the query for fetching data from the store and fill into grid.
            // parameters:
            //      query: the query paramenter will be sent to rest store.
            // tags:
            //      private

            var query = value ? value : { "parent": null };
            this._refresh(query);
        },

        _setBeginDateAttr: function (value) {
            // summary:
            //      set value for begin date

            this.beginDate && this.beginDate.domNode && this.beginDate.set("value", value);
        },

        _setEndDateAttr: function (value) {
            // summary:
            //      set value for end date

            this.endDate && this.endDate.domNode && this.endDate.set("value", value);
        },

        _setFinalizedOnlyAttr: function (value) {
            // summary:
            //      set value for finalizedOnly

            this.finalizedOnly && this.finalizedOnly.domNode && this.finalizedOnly.set("checked", value);
        },

        _updateChart: function (beginDate, endDate, finalizedOnly) {
            // summary:
            //      Redraw chart with new data.

            if (this._chart) {
                this._chart.destroy();
                this._chart = null;
            }

            when(this.model.getChartData(beginDate, endDate, finalizedOnly), lang.hitch(this, function (data) {

                if (!data) {
                    return;
                }

                var itemsContainData = array.filter(data, function (item) {
                    return item.value > 0;
                });

                // hide grid node if there is no data
                domStyle.set(this.chartContainerNode, "display", itemsContainData.length == 0 ? "none" : "");

                var xAxisData = [];
                var labels = [];
                for (var i = 0; i < data.length; i++) {
                    xAxisData.push(data[i].value);
                    labels.push({ value: i + 1, text: data[i].key });
                }

                var chart = new Chart(this.chartContainerNode);
                chart.addPlot("default", { type: Columns, markers: true, gap: 5 })
                    .addAxis("x", { labels: labels, fixLower: "major", fixUpper: "major", majorTickStep: 1, minorTicks: false, rotation: -90 })
                    .addAxis("y", { vertical: true, fixLower: "major", fixUpper: "major", min: 0, minorTicks: false })
                    .setTheme(theme)
                    .addSeries("Form Submissions", xAxisData)
                    .render();
                var tip = new Tooltip(chart, "default");
                // must call chart resize to rebind tool tip to the chart
                chart.resize();

                this._chart = chart;
            }));
        },

        _resizeChart: function () {
            // summary:
            //      Resize chart to fit with parent
            // tags:
            //      private

            if (this._chart) {
                this._chart.resize();
            }
        },

        _showStandby: function (visible) {
            // summary:
            //      Set standby visibility.
            // tags:
            //      private

            if (!this._standby) {
                return;
            }

            if (visible) {
                if (!this._standby.isVisible()) {
                    this._standby.show();
                }
            } else {
                this._standby.hide();
            }
        },

        _getSelectedItems: function () {
            // summary:
            //    Iterate the grid items and return the selected submission id.

            var selection = [],
                selected = this._grid.selection;
            if (selected) {
                var row;
                for (rowId in selected) {
                    if (selected[rowId] == true) {
                        row = this._grid.row(rowId);
                        selection.push(row.data.systemcolumn_SubmissionId);
                    }
                }
            }

            return selection;
        },

        _showConfirmationDialog: function (/*String*/message, /*Function*/fnConfirmCallback) {
            // summary:
            //    Configure and open the confirmation dialog.
            //
            // fnConfirmCallback:
            //    Callback function.
            //
            // tags:
            //    private

            var dialog = new Confirmation({
                description: message,
                title: this.res.heading,
                onAction: fnConfirmCallback
            });

            dialog.show();
        },

        _updateToolbar: function (data, context) {
            // summary:
            //      Update global toolbar with
            //      - Current context
            //      - View configuration
            // tags:
            //      private

            this.toolbar.update({
                currentContext: context,
                viewConfigurations: {
                    availableViews: data.availableViews,
                    viewName: data.viewName
                }
            });
        },

        _toggleMessageContentPane: function (/*Boolean*/show) {
            // summary:
            //      Toggle display of the message content pane
            // tags:
            //      private

            if (show) {
                domClass.remove(this.contentPane.domNode, "dijitVisible");
                domClass.add(this.contentPane.domNode, "dijitHidden");
                domClass.add(this.messageContentPane.domNode, "dijitVisible");
            } else {
                domClass.remove(this.messageContentPane.domNode, "dijitVisible");
                domClass.add(this.messageContentPane.domNode, "dijitHidden");
                domClass.add(this.contentPane.domNode, "dijitVisible");
            }
        }

    });

});