# Google Maps Editor
Dojo widget for selecting map coordinates using Google Maps in Episerver.
Author: Ted Nyberg, Ted & Gustaf AB (http://tedgustaf.com)
Released under the MIT license (http://opensource.org/licenses/MIT)

## Release notes

### 1.0.11
* Support for Episerver 11, requires .NET 4.6.2

### 1.0.10
* Fix for incorrect version path in module zip

### 1.0.9
* Support for Episerver 10

### 1.0.7
* Starting with version 1.0.7, the Google Maps Editor is packaged as an add-on.
  Please uninstall any previous version by removing the 'googlemaps' folder in 'ClientResources'.
* If you have previously set the widget class explicitly, such as in an editor descriptor, please
  update the widget class to 'googlemapseditor/Editor'
* The UI hint should be set using the UIHint constant of the new GoogleMapsEditorDescriptor class
* Editor attaches automatically to any property type implementing the new IGoogleMapsCoordinates interface
  (for example a block type used as a property type)