QML Material CHANGELOG
======================

### Version 0.2.0 (January 16, 2016)

**Features**
 * General:
   * Add a showError() function for easily displaying errors
   * Import the Material.Extras module from a separate git repository
   * Add details about Material.Extras
   * Use Settings from QtQuick.Controls for mobile characteristics
   * Support using simple names for theme colors
 * Action: Have Action extend QtQuick's Action object
 * ActionButton: Follow Action iconName & visible
 * CircleImage: Expose the fillMode property
 * DatePicker: Initial add of the Material DatePicker
 * Platform extensions:
   * Implement platform extensions for Papyros
   * Material Design window decorations for Papyros
 * Demo:
   * Use the new-style simple color names for the theme
   * Replace account_child with account_circle in the form demo
   * Modify snackbar demo to show wide and multi-line examples
   * Set the window title of the demo app
   * Use async loader for demo components for better performance
   * Use Flow instead of Grid with variable columns for the icon demo
   * Add date picker to demo
   * Change between list and icon view on the icon demo
   * Update dialog demo to show better examples
   * Add example customized slider to demo
 * Dialog:
   * Allow hiding the primary button
   * Update dialog to latest MD spec
 * Icons:
   * Add all the new and updated Material icons
   * Add new and updated Material icons
   * Update the FontAwesome icons to 4.5.0
   * Update the Material Design icons
 * ListItem: Expose the list item labels to allow customization
 * MenuField: Simple implementation of a textRole
 * NavigationDrawer: Add NavigationDrawerPage for easy use of nav drawers
 * PageStack:
   * Add a goBack signal to Page to allow overriding the default back behavior
   * Allow the page stack to be popped to an arbitrary page
 * ProgressCircle: HiDPI support for ProgressCircle
 * RadioButton and CheckBox: Trigger the click event
 * Slider:
   * Add customization options to the slider's label knob
   * Support custom slider tooltips via a valueInfo function
 * Tabs:
   * Improved tabs support using a TabbedPage
   * Support disabled tabs
 * TextField:
   * Support borderless textfields
   * Update to latest MD spec, add multi-line support
 * TimePicker: Implement a time picker component
 * Tooltip: Improve the tooltip class and split it into a base Popover

**Bug Fixes**
 * General: Fix a bug causing units to be calculated incorrectly
 * ActionBar: Only support plain text in the action bar title
 * BottomSheet: Fix wrong ID
 * Button:
   * Fix the style of disabled buttons
   * Fix typo in button width calculation
 * CheckBox: Update the size of the checkbox
 * Demo:
   * Don't load the demo page twice initially
   * Properly display the demo window when loading from C++
 * Dropdown:
   * Close an open dropdown when resizing the app window
   * Fix Dropdown positioning in window edges
 * IconButton: Fix alignment of the icon in the icon button
 * Ink: Allow concurrent Ink animations
 * ListItem:
   * Fix content item not showing when it should
   * Fix divider insets on subtitled list items
   * Show the list item's sub text when the content item is hidden
   * Subtitled - Fix invisible secondary item
 * MenuField:
   * Fix bug that MenuField cannot scroll menu items
   * Fix TypeError when no item is selected
 * PageSidebar: Properly push and pop the right sidebar actionbar
 * Page: Disable the left action when it is hidden
 * ProgressBar: Fixup style to allow use in async loader
 * ProgressCircle:
   * Fixup style to allow use in async loader
   * Fix a incorrect reference to the canvas
   * Suppress meaningless error
 * RadioButton: centered the checked indicator
 * SimpleMenu: Fix all the binding loop warnings
 * Switch: Fix the groove background to match the spec
 * Tabs:
   * Fix tabbar when navigating back up the page stack
   * Initialize tabs to empty
   * Properly support changing the number of tabs in a TabbedPage
 * TextField:
   * Fix errors in the text field style
   * Fixes bad Roboto font rendering on Windows


### Version 0.1.0 (May 6, 2015)

 * Create a style for theming QtQuick.Controls apps
 * Components
   * [ActionBar] Control the overflow menu with Android hardware keys
   * [ActionBar] Elide titles displayed in the action bar
   * [ActionBar] Hide non-visible actions in the action bar
   * [ActionBar] Support disabling actions in the action bar
   * [ActionButton] Add support for the mini and default FAB sizes
   * [Button] Properly handle dark background for flat buttons
   * [Dialog] Active focus is passed off when Dialog closes
   * [Dialog] Add support for full-width content
   * [Dialog] Correctly handle back button on Android devices
   * [Icon] Add a valid property to Icon and AwesomeIcon
   * [Icon] Support custom icons with an iconSource property
   * [Icon] Update the FontAwesome icon table
   * [Icon] Update the FontAwesome parsing script to pull from the website
   * [IconButton] Add animation on mouse over
   * [InputDialog] Expose the text field and input method
   * [ListItem] Add a new expandable section header list item
   * [ListItem] Correctly calculate the width of a simple menu item
   * [NavigationDrawer] Update the nav drawer to work properly
   * [PageStack] Pop pages when the Android back button is tapped
   * [Popup] Support preventing a popup from being dismissed
   * [RadioButton] Improve selection support
   * [Tabs] Allow switching tabs programmatically in a page
   * [Tabs] Capitalize tab titles
   * [Tabs] Implement the MD spec for coloring tab text
   * [TextField] Port to QtQuick.Controls
 * Documentation
   * Publish documentation to http://papyros.io/qml-material
   * Write brief summaries for all the components
   * Fix qdoc warnings
 * Demo
   * Add a Typography section to the demo
   * Organize the different demos into tabs
   * Display all the Material Design icons in the Icons demo
   * Update radio button demo with grouping
 * Testing
   * Add UI tests for the ActionBar component


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
 * [BottomSheet] Add a basic bottom sheet and an action list subclass


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
