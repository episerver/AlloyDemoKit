define(
    ["dojo/_base/declare",
     "dojo/dom",
     "dojo/_base/lang",
     "dojo/topic",
     "dojo/query",
     "dojo/cookie",
     "dojo/dom-class",
     "dojo/dom-style",
     "dojo/aspect",
     "dojo/on",
     "dojo/_base/event",
     "dijit/registry"
    ],
    function (
        declare,
        dom,
        lang,
        topic,
        query,
        cookie,
        domClass,
        domStyle,
        aspect,
        on,
        event,
        registry
        ) {

        return declare([], {

            globalMenu: null,
            cookieName: "menupinFindV10.1",
            menuPinButtons: null,
            _initHandle: null,

            initialize: function () {

                this.inherited(arguments);

                // Only initialise once
                this._initHandle = topic.subscribe("/dojo/hashchange", lang.hitch(this, "_init"));

                // Assess the state of MenuPin every time the hash changes
                topic.subscribe("/dojo/hashchange", lang.hitch(this, "_onHashChange"));
            },

            _init: function () {

                this._initHandle.remove();

                // Set up the references for the items we are going to interact with
                this.menuPinButtons = query(".menuPinButton");

                this.globalMenu = registry.byId("globalMenuContainer");

                topic.subscribe("/menupin/pinclicked", lang.hitch(this, "_pinClicked"));

                // Ensure the menu does not hide if the menu is pinned
                aspect.around(this.globalMenu, "_hideMenu",
                    function (originalMethod) {
                        return function () {
                            // Stop the menu from being hidden
                            if (cookie("menupinFindV10.1") === "true") {
                                return null;
                            } else {
                                originalMethod.apply(this);
                            }
                        }
                    }
                );

                for (var i = 0; i < this.menuPinButtons.length; i++) {
                    var button = this.menuPinButtons[i];

                    on(button.parentNode, "click", function (e) {
                        topic.publish("/menupin/pinclicked");
                        event.stop(e);
                    });

                }

                this._onHashChange();
            },

            _onHashChange: function (ctx) {
                // Pin out the menu if needed
                if (this._isMenuPinned()) {
                    this._pinMenu();
                }
            },

            _pinClicked: function () {
                if (this._isMenuPinned()) {
                    this._unpinMenu();
                } else {
                    this._pinMenu();
                }
            },

            _unpinMenu: function () {

                this.globalMenu.shadowClass = "epi-globalNavigation--shadow";

                // Toggle the state to be set or unset
                this._toggleState(false);

                // Mark the menu pin as un-selected
                for (var i = 0; i < this.menuPinButtons.length; i++) {
                    var button = this.menuPinButtons[i];
                    domClass.remove(button.parentNode.parentNode, "epi-navigation-selected");
                }

                // Make the menu float again
                this.globalMenu.setAttribute("style", "position: absolute; ");

                // Hide the menu
                this.globalMenu._hideMenu();

                // Show the hint button
                domStyle.set(this._getHintButton(), "display", "block");
            },

            _pinMenu: function () {

                // Toggle the cookie to be set or unset
                this._toggleState(true);

                // Mark the menu pin as selected
                for (var i = 0; i < this.menuPinButtons.length; i++) {
                    var button = this.menuPinButtons[i];
                    domClass.add(button.parentNode.parentNode, "epi-navigation-selected");
                }

                // Open the menu
                this.globalMenu._showMenu();

                // Make sure the menu doesn't float
                this.globalMenu.setAttribute("style", "position: relative; ");

                // Remove the shadow effect
                domClass.remove(this.globalMenu.domNode, this.globalMenu.shadowClass);

                // Stop the shadow getting re-added
                this.globalMenu.shadowClass = "menupin--noshadow";

                //Hide the hint button
                domStyle.set(this._getHintButton(), "display", "none");
            },

            _getHintButton: function () {
                var hintButton = query(".epi-navigation-expandcollapseBtn")[0];
                return hintButton;
            },

            _isMenuPinned: function () {
                return cookie(this.cookieName) === "true";
            },

            _toggleState: function (pinned) {
                if (pinned === false) {
                    cookie(this.cookieName, "false", { path: "/" });
                } else {
                    cookie(this.cookieName, "true", { expires: 365, path: "/" });
                }
            }

        });
    });