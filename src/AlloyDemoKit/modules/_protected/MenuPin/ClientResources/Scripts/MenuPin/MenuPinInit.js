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
     "dojox/gesture/tap",
     "dijit/registry",
     "epi/dependency"
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
        tap,
        registry,
        dependency
        ) {

        return declare([], {
            globalMenu: null,
            keyName: "menupinV3.3",
            menuPinButtons: null,
            _initHandle: null,

            initialize: function () {

                this.inherited(arguments);

                // The context changes after the UI has been loaded so we can be sure that registry contains the global meny container
                this._initHandle = topic.subscribe("/epi/shell/context/current", lang.hitch(this, "_onContextCurrent"));
            },

            _onContextCurrent: function (ctx) {
                this._initHandle.remove();
                this._init();
            },

            _init: function () {

                // Set up the references for the items we are going to interact with
                this.menuPinButtons = query(".menuPinButton");

                this.globalMenu = registry.byId("globalMenuContainer");

                if (!this.globalMenu) {
                    return;
                }

                topic.subscribe("/menupin/pinclicked", lang.hitch(this, "_pinClicked"));
                topic.subscribe("/menupin/pinheld", lang.hitch(this, "_pinHeld"));

                // Ensure the menu does not hide if the menu is pinned
                aspect.around(this.globalMenu, "_hideMenu",
                    function (originalMethod) {
                        return function () {
                            // Stop the menu from being hidden
                            var profile = epi.dependency.resolve("epi.shell.Profile");
                            if (profile && profile.get("menupinV3.3") && profile.get("menupinV3.3") === true) {
                                return null;
                            } else {
                                originalMethod.apply(this);
                            }
                        }
                    }
                );

                this._profile = dependency.resolve("epi.shell.Profile");

                // Pin out the menu if needed
                if (this._isMenuPinned()) {
                    this._pinMenu();
                }

                for (var i = 0; i < this.menuPinButtons.length; i++) {
                    var button = this.menuPinButtons[i];

                    on(button.parentNode, "click", function (e) {
                        topic.publish("/menupin/pinclicked");
                        event.stop(e);
                    });

                    on(button.parentNode, tap.hold, function (e) {
                        topic.publish("/menupin/pinheld");
                        event.stop(e);
                    });
                }
            },

            _pinHeld: function () {
                if (this._isMenuPinned()) {

                    topic.publish("/epi/layout/pinnable/navigation/toggle", false);
                    topic.publish("/epi/layout/pinnable/tools/toggle", false);

                    this._unpinMenu();
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

                // Make sure the main content container is a height of 100%
                var root = registry.byId("rootContainer");
                var newHeight = "100%";
                domStyle.set(root.domNode, "height", newHeight);
                root.resize();

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

                // Make sure the main content container is 100% high minus the height of the menu
                var root = registry.byId("rootContainer");
                var newHeight = "calc(100% - " + this.globalMenu._getContentHeight() + "px)";
                domStyle.set(root.domNode, "height", newHeight);
                root.resize();
            },

            _getHintButton: function () {
                var hintButton = query(".epi-navigation-expandcollapseBtn")[0];
                return hintButton;
            },

            _isMenuPinned: function () {
                var pinned = this._profile.get(this.keyName);
                if (pinned && pinned === true) {
                    return pinned;
                } else {
                    return false;
                }
            },

            _toggleState: function (pinned) {
                if (pinned === false) {
                    this._profile.set(this.keyName, false);
                } else {
                    this._profile.set(this.keyName, true);
                }
            }

        });
    });