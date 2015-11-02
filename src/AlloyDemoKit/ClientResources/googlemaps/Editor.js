/** @license
 * Dojo widget for selecting map coordinates using Google Maps when editing a string property in EPiServer 7.5
 * Author: Ted Nyberg (http://tedgustaf.com/ted)
 * Released under the MIT license (http://opensource.org/licenses/MIT)
 */

/* HOW TO USE
 * Put the entire 'googlemaps' folder inside the /ClientResources folder in the site root.
 * Ensure you have a modules.config file in the site root containing:
 *   <dojoModules>   
 *     <add name="tedgustaf" path="" />  
 *   </dojoModules>
 * Create an EditorDesctriptor class setting ClientEditingClass to 'tedgustaf.googlemaps.Editor' and use it for any string property, or a complex type with "Longitude" and "Latitude" properties.
  */

define([
    "dojo/on", // To connect events
    "dojo/_base/declare", // Used to declare the actual widget

    "dojo/aspect", // Used to attach to events in an aspect-oriented way to inject behaviors

    "dijit/registry", // Used to get access to other dijits in the app
    "dijit/WidgetSet", // To be able to use 'byClass' when querying the dijit registry

    "dijit/_Widget", // Base class for all widgets
    "dijit/_TemplatedMixin", // Widgets will be based on an external template (string literal, external file, or URL request)
    "dijit/_WidgetsInTemplateMixin", // The widget will in itself contain additional widgets

    "epi/epi", // For example to use areEqual to compare property values
    "epi/shell/widget/_ValueRequiredMixin", // In order to check if the property is in a readonly state
    "epi/shell/widget/dialog/LightWeight", // Used to display the help message

    "dojo/i18n!./nls/Labels", // Localization files containing translations

    'xstyle/css!./WidgetTemplate.css',

    "tedgustaf/googlemaps/Async!https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places" // Use async module to load external asyncronously loaded script for Google Maps
],
function (
    on,
    declare,

    aspect,

    registry,
    WidgetSet,

    _Widget,
    _TemplatedMixin,
    _WidgetsInTemplateMixin,

    epi,
    _ValueRequiredMixin,
    LightWeight,

    localized
) {
    return declare([_Widget, _TemplatedMixin, _WidgetsInTemplateMixin, _ValueRequiredMixin], {
       
        // The Google Maps object of this widget instance
        map: this.canvas,

        // The map marker of this widget instance
        marker: null,

        // Load HTML template from the same location as the widget
        templateString: dojo.cache("tedgustaf.googlemaps", "WidgetTemplate.html"),

        // Event used to notify EPiServer that the property value has changed
        onChange: function (value) {
            console.log('onchange');
            this.parent.save(value); // HACK Otherwise value won't be saved when Google Places search result item is clicked (instead of using Enter to select it)
        },

        // Dojo function invoked before rendering
        postMixInProperties: function () {
            this.inherited(arguments);

            this.localized = localized; // To be able to access translations from template
        },

        // Dojo event fired after all properties of a widget are defined, but before the fragment itself is added to the main HTML document
        postCreate: function () {

            // Call base implementation of postCreate, passing on any parameters
            this.inherited(arguments);

            // Use internal value setter with the value passed in by EPiServer through the widget constructor
            this._setValue(this.value);

            // Set coordinate textboxes to current property value
            if (this.hasCoordinates()) {
                if (typeof this.value === "string") {
                    var coordinates = this.value.split(',');
                    this.longitudeTextbox.set('value', coordinates[0]);
                    this.latitudeTextbox.set('value', coordinates[1]);
                } else if (typeof this.value === "object") {
                    this.longitudeTextbox.set('value', this.value.longitude);
                    this.latitudeTextbox.set('value', this.value.latitude);
                }
            }

            // When the editor switches tabs in the UI we trigger a map resize to ensure it aligns properly
            var that = this;
            registry.byClass("dijit.layout.TabContainer").forEach(function (tab, i) {
                aspect.after(tab, "selectChild", function () {
                    that.alignMap();
                });
            });

            // Display help when help icon is clicked
            on(this.helpIcon, "click", function (e) {
                e.preventDefault();

                var dialog = new LightWeight({
                    style: "width: 540px",
                    closeIconVisible: true,
                    showButtonContainer: false,
                    onButtonClose: function() {
                        dialog.hide();
                    },
                    _endDrag: function () {
                        // HACK Avoid EPiServer bug, "Cannot read property 'userSetTransformId' of null" when close icon is clicked
                    },
                    title: that.localized.help.dialogTitle,
                    content: that.localized.help.dialogHtml
                });

                dialog.show();
            });
        },

        // Dojo event triggered after 'postCreate', for example when JS resizing needs to be done
        startup: function () {
            this.initializeMap();

            var that = this;

            // HACK Give EPiServer UI some time to load the view before resizing the map to ensure it aligns even after being hidden/displayed
            // TODO Replace with event/aspect for when the edit view changes in the UI
            setTimeout(function () {
                that.alignMap();
            }, 250);
        },

        // Dojo event triggered when widget is removed
        destroy: function() {
            this.inherited(arguments); // Important to ensure inherited widgets are destroyed properly, failure to do this risks memory leaks

            // Clean up Google Maps (as much as possible, but there is a known issue with Google Maps: https://code.google.com/p/gmaps-api-issues/issues/detail?id=3803)
            if (this.marker) {
                this.marker.setMap(null);
            }

            if (this.map && this.map.parentNode) {
                google.maps.event.clearListeners(this.map, 'rightclick');
                this.map.parentNode.removeChild(this.map);
                this.map = null;
            }
        },

        // Checks if the current property value is valid (invoked by EPiServer)
        isValid: function () {
            // summary:
            //    Check if widget's value is valid.
            // tags:
            //    protected, override

            if (!this.value || this.value === '' || this.value == undefined || (typeof this.value === "object" && (isNaN(this.value.longitude) || isNaN(this.value.latitude)))) {
                return !this.required; // Making use of _ValueRequiredMixin to check if a property value is required
            }

            if (typeof this.value === "string") {
                var coordinates = this.value.split(',');

                if (coordinates.length != 2) { // Valid value is longitude and latitude, separated by a comma
                    return false;
                }

                for (var i = 0; i < 1; i++) {
                    if (isNaN(coordinates[0]) || coordinates[0].toString().indexOf('.') == -1) {
                        return false; // The coordinate is not a float number
                    }
                }

                return true;
            } else if (typeof this.value === "object") { // Complex type, ensure coordinates are numbers
                var isValidCoordinatesObject = this.value.longitude !== undefined &&
                                               this.value.latitude !== undefined &&
                                               !isNaN(this.value.longitude) &&
                                               !isNaN(this.value.latitude) &&
                                               this.value.longitude !== 0 &&
                                               this.value.latitude !== 0;

                return isValidCoordinatesObject;
            }

            return false;
        },

        // Checks if the current value is valid coordinates
        hasCoordinates: function () {

            if (!this.isValid() || !this.value || this.valueOf === '' || (typeof this.value === "object" && (isNaN(this.value.longitude) || isNaN(this.value.latitude)))) {
                return false;
            }

            if (typeof this.value === "string") {
                return this.value.split(',').length == 2; // String value with comma-separated coordinates
            } else if (typeof this.value === "object") { // Complex type with separate properties for latitude and longitude
                return this.value.longitude !== undefined &&
                       this.value.latitude !== undefined &&
                       !isNaN(this.value.longitude) &&
                       !isNaN(this.value.latitude) &&
                       this.value.longitude !== 0 &&
                       this.value.latitude !== 0;
            }

            return false;
        },

        // Setter for value property (invoked by EPiServer on load)
        _setValueAttr: function (value) {
            this._setValue(value, true);
        },

        // Set whether the property is readonly (invoked by EPiServer on load)
        _setReadOnlyAttr: function (value) {
            this._set("readOnly", value);
        },

        // Update widget value when a coordinate is changed
        _onCoordinateChanged: function () {

            var longitude = this.longitudeTextbox.get('value');
            var latitude = this.latitudeTextbox.get('value');

            if (longitude === undefined || latitude === undefined) {
                return;
            }

            // Update the widget (i.e. property) value
            if (this.value != null && typeof this.value === "object") { // Property is complex type, such as a local block
                var coordinatesObject = { latitude: parseFloat(latitude), longitude: parseFloat(longitude) };
                this._setValue(coordinatesObject);
            } else { // Assume string value type
                var coordinatesAsString = latitude + "," + longitude;
                this._setValue(coordinatesAsString);
            }
        },

        // Used to set the widget (property) value
        _setValue: function (value) {

            // Skip if the new property value is identical to the current one
            if (this._started && epi.areEqual(this.value, value)) {
                return;
            }

            // Update the widget (i.e. property) value
            this._set("value", value);

            if (this._started && this.validate()) {
                // Trigger change event to notify EPiServer (and possibly others) that the value has changed
                this.onChange(value);
            }
        },

        // Clears the coordinates, i.e. the property value (the clear button's click event is wired up through a 'data-dojo-attach-event' attribute in the HTML template)
        clearCoordinates: function () {
            
            // Clear coordinate checkboxes
            this.longitudeTextbox.set('value', '', false); // Change value without triggering onChange event as we will explicitly null the property value
            this.latitudeTextbox.set('value', '');

            // Clear search box
            this.searchTextbox.set("value", '');

            // Remove the map marker, if any
            if (this.marker) {
                this.marker.setMap(null);
                this.marker = null;
            }

            // Null the widget (i.e. property) value
            this._setValue(null);
        },

        // Setup the Google Maps canvas
        initializeMap: function () {

            var defaultCoordinates = new google.maps.LatLng(59.336, 18.063);

            // Center on current coordinates (i.e. property value), or a default location if no coordinates are set
            if (this.hasCoordinates()) {
                if (typeof this.value === "string") {
                    var coordinates = this.value.split(',');
                    defaultCoordinates = new google.maps.LatLng(parseFloat(coordinates[0]), parseFloat(coordinates[1]));
                }
                else if (typeof this.value === "object") {
                    defaultCoordinates = new google.maps.LatLng(this.value.latitude, this.value.longitude);
                }
            }

            // Render the map, but disable interaction if property is readonly
            var mapOptions = {
                zoom: 5,
                disableDefaultUI: true,
                center: defaultCoordinates,
                disableDoubleClickZoom: this.readOnly,
                scrollwheel: !this.readOnly,
                draggable: !this.readOnly
            };

            // Load the map
            this.map = new google.maps.Map(this.canvas, mapOptions);

            // Display grayscale map if property is readonly
            if (this.readOnly) {
                
                var grayStyle = [{
                    featureType: "all",
                    elementType: "all",
                    stylers: [{ saturation: -100 }]
                }];

                var mapType = new google.maps.StyledMapType(grayStyle, { name: "Grayscale" });

                this.map.mapTypes.set('disabled', mapType);

                this.map.setMapTypeId('disabled');
            }

            // Add a marker to indicate the current coordinates, if any
            if (this.hasCoordinates()) {
                this.marker = new google.maps.Marker({
                    position: this.map.getCenter(),
                    map: this.map
                });
            }

            // Allow user to change coordinates unless property is readonly
            if (!this.readOnly) {

                var that = this;

                // Update map marker and coordinate textboxes when map is right-clicked
                google.maps.event.addListener(this.map, "rightclick", function (event) {
                    that.setMapLocation(event.latLng, null, false);
                });

                // Add search textbox and when a place is selected, move pin and center map
                var searchBox = new google.maps.places.SearchBox(this.searchTextbox.textbox);

                // Remove Google Maps Searchbox default placeholder, as it won't recognize the placeholder attribute placed on the Textbox dijit
                this.searchTextbox.textbox.setAttribute('placeholder', '');

                google.maps.event.addListener(searchBox, 'places_changed', function () {
                    var places = searchBox.getPlaces();

                    if (places.length == 0) {
                        return;
                    }

                    that.setMapLocation(places[0].geometry.location, 15, true);
                });
            } else {
                // Disable search box and clear button
                this.searchTextbox.set("disabled", true);
                this.clearButton.set("disabled", true);
            }
        },

        // Triggers a map resize, for example when the map is hidden/displayed to ensure it aligns properly
        alignMap: function () {
            var center = this.map.getCenter();
            google.maps.event.trigger(this.map, "resize");
            this.map.setCenter(center);
        },

        // Updates map marker location, centers on it (optional), sets the zoom level (optional) and updates coordinate textboxes for longitude and latitude values
        setMapLocation: function (/* google.maps.LatLng */ location, zoom, center) {

            // Set the values of the coordinate textboxes to longitude and latitude, respectively
            this.longitudeTextbox.set('value', location.lng());
            this.latitudeTextbox.set('value', location.lat());

            // Set the marker's position
            if (!this.marker) { // No marker yet, create one
                this.marker = new google.maps.Marker({
                    map: this.map
                });
            }

            this.marker.setPosition(location);

            // Center on the location (optional)
            if (center) {
                this.map.setCenter(location);
            }
        
            // Set map zoom level (optional)
            if (zoom) {
                this.map.setZoom(zoom);
            }

            // Trigger event to update the widget (i.e. property) value
            this._onCoordinateChanged();
        }
    });
});
