QML Material CHANGELOG
======================

 * Initial work on a QtQuick.Controls theme
 * [Demo] Add a Typography section to the demo
 * [Button] Properly handle dark background for flat buttons
 * [Tabs] Allow switching tabs programmatically in a page
 * [Demo] Organize the different demos into tabs
 * [Tabs] Implement the MD spec for coloring tab text
 * [Icon] Add a valid property to Icon and AwesomeIcon
 * [Demo] Display all the Material Design icons in the Icons demo
 * Move the QtQuick.Controls style into the modules directory
 * [Icon] Update the FontAwesome icon table
 * [RadioButton] Improve selection support
 * [Demo] Update radio button demo with grouping


### Version 0.0.6 (April 16, 2015)

 * Add a ProgressCircle component following the Google spec
 * Add a tooltip component and use it in the ActionBar
 * Add an OverlayView component for view transitions  
 * [Snackbar] Bug fixes and style improvements
 * [Button] Remove default Qt Quick Controls padding
 * [SimpleMenu/MenuField] Fixes some binding loops
 * [TextField] Fixes floating label behavior on devices
 * [Action] Support for keybindings in Action
 * [ListItem] Fix bug with Subtitled action not showing
 * [ListItem] Add support for a custom view in the subtitled list item
 * [Button] Add disabled state to button
 * General bug fixing and code refactoring


### Version 0.0.5 (March 4, 2015)

 * Move popovers as necessary to prevent them being clipped by the window
 * [PageStack] Add support for a divided page and toolbar
 * Rename list item and IconButton onTriggered to onClicked
 * [Toolbar] Add support for custom and extended content in the toolbar
 * [PageStack] Make Page a FocusScope
 * [Dialog] Refactor the dialog code to use anchors
 * [Snackbar] Improve the snackbar and add support for mobile layouts
 * [PageStack] Fix going back from a pushed page
 * [ListItems] Add direct support for icons to Standard
 * [Ink] Polished the ink animations
 * [Dialog] Improved the dialog component
 * [Icon] Switch to using SVGs instead of PNGs
 * [Demo] Add the color palette to the demo
 * [ProgressBar] Port ProgressBar to inherit from QtQuick Controls
 * Minor bug fixes and code improvements


### Version 0.0.4 (February 20, 2015)

 * Hide the CSD window controls when client-side decorations are disabled
 * Improve the dialog component to better follow Material Design
 * Add the Material Design Checkbox component
 * Support replacing the current page in a PageStack
 * Improve the layout of the Subtitled list item
 * Add the Material Design menu field component
 * Improve the layout of the Standard list item
 * Add an equals symbol to the "extra" icon collection
 * Add a right mode to the navigation drawer
 * Allow pages to customize the action count in the toolbar
 * [Palette] Update with color swatches from Material Design
 * [Demo] Add color picker to change theme colors
 * [Dialog] Fix an issue preventing popovers from working
 * [MenuField] Fix issues with the menu not being the right size
 * [Demo] Clean up and refactor the demo
 * [Slider] change check for activeFocus to focus so we can set it
 * [Ink] Remove PRESSED debug message
 * [Theme] Add a method for determining if a color is dark or light
 * [PageStack] Fixes and improvements to the page stack and toolbar
