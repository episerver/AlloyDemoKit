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
     "dijit/registry"],
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
        registry) {

        return declare([], {

            globalMenu: null,
            cookieName: "menupinV2.2",
            menuPinButton: null,
            _initHandle: null,

            initialize: function () {

                this.inherited(arguments);

                // The context changes after the UI has been loaded so we can be sure that registry contains the global meny container
                _initHandle = topic.subscribe("/epi/shell/context/current", lang.hitch(this, "_onContextCurrent"));
            },

            _onContextCurrent: function (ctx) {
                _initHandle.remove();
                this._init();
            },

            _init: function () {
                // Set up the references for the items we are going to interact with
                this.menuPinButton = dom.byId("menuPin");
                this.globalMenu = registry.byId("globalMenuContainer");

                topic.subscribe("/menupin/pinclicked", lang.hitch(this, "_pinClicked"));

                // Ensure the menu does not hide if the menu is pinned
                aspect.around(this.globalMenu, "_hideMenu",
                    function (originalMethod) {
                        return function () {
                            // Stop the menu from being hidden
                            if (cookie("menupinV2.2") === "true") {
                                return null;
                            } else {
                                originalMethod.apply(this);
                            }
                        }
                    }
                );

                // Pin out the menu if needed
                if (this._isMenuPinned()) {
                    this._pinMenu();
                }

                on(this.menuPinButton.parentNode, "click", function (e) {
                    topic.publish("/menupin/pinclicked");
                });

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

                // Toggle the cookie to be set or unset
                this._toggleCookie(false);

                // Mark the menu pin as un-selected
                domClass.remove(this.menuPinButton.parentNode.parentNode, "epi-navigation-selected");

                // Make the menu float again
                this.globalMenu.setAttribute("style", "position: absolute; ");

                // Hide the menu
                this.globalMenu._hideMenu();

                // Show the hint button
                domStyle.set(this._getHintButton(), "display", "block");

            },

            _pinMenu: function () {

                // Toggle the cookie to be set or unset
                this._toggleCookie(true);

                // Mark the menu pin as selected
                domClass.add(this.menuPinButton.parentNode.parentNode, "epi-navigation-selected");

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
                return cookie(this.cookieName) === "true";
            },

            _toggleCookie: function (pinned) {
                if (pinned === false) {
                    cookie(this.cookieName, "false", { path: "/" });
                } else {
                    cookie(this.cookieName, "true", { expires: 365, path: "/" });
                }
            }

        });
    });