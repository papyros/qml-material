/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014-2015 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import Material 0.1

/*!
   \qmltype Page
   \inqmlmodule Material 0.1

   \brief Represents a page on the navigation page stack.

   Example:

   \qml
   import QtQuick 2.0
   import Material 0.1

   Page {
       title: "Application Name"

       actions: [
           Action {
               name: "Print"

               // Icon name from the Google Material Design icon pack
               iconName: "action/print"
           }
       ]

       actionBar {
           // Set a custom background color, if you don't want to use
           // the theme's primary color
           backgroundColor: Palette.colors.red["500"]

           // You can also set a custom content view instead of the title
           customContent: TextField {
               placeholderText: "Search..."
               anchors {
                   left: parent.left
                   right: parent.right
                   verticalCenter: parent.verticalCenter
               }
           }
       }
   }
   \endqml
 */
FocusScope {
    id: page

    /*
      \qmlproperty ActionBar actionBar

      The action bar for this page. Use it as a group property to customize
      this page's action bar. See the \l Page example for details on how to use
      this property.
     */
    property alias actionBar: __actionBar

    /*!
       The page's actions shown in the action bar.
     */
    property list<Action> actions

    /*!
       The action shown to the left of the title in the action bar. By default,
       this is a back button which shows when there is a page behind the current
       page in the page stack. However, you can replace it with your own action,
       for example, an icon to open a navigation drawer when on your root page.
     */
    property Action backAction: Action {
        name: "Back"
        iconName: "navigation/arrow_back"
        onTriggered: page.pop()
        visible: canGoBack
    }

    /*!
       The background color of the page. Defaults to the global background color
       defined in \l Theme::backgroundColor
     */
    property color backgroundColor: Theme.backgroundColor

    /*!
       \internal
       Set by the page stack to true if there is a page behind this page on the
       page stack.
     */
    property bool canGoBack: false

    /*!
       \internal
       The default property is set to the content view so the page's content
       properly fits in with left or right sidebars.
     */
    default property alias data: content.data

    /*!
       \qmlproperty PageSidebar rightSidebar
       A sidebar to show on the right of the page. This will have its own
       action bar and title, which will split the toolbar into two action bars.
     */
    property Item rightSidebar

    /*!
       The index of the selected tab. This will be an index from the \l tabs
       property.
     */
    property alias selectedTab: __actionBar.selectedTab

    /*!
       The tab bar displayed below the actions in the action bar. Exposed for
       additional customization.
     */
    property alias tabBar: __actionBar.tabBar

    /*!
       The model to use as the tab items in the action bar. This can either be a Javascript
       array wih an object for each tab, or it can be a TabView object to display tabs for.

       If it is a Javascript array, each object represents one tab, and can either be a simple
       string (used as the tab title), or an object with title, iconName, and/or iconSource 
       properties.
       
       If it is a TabView component, the title of each Tab object will be used, as well as
       iconName and iconSource properties if present (as provided by the Material subclass of Tab).
     */
    property alias tabs: __actionBar.tabs

    /*!
       The title of the page shown in the action bar.
     */
    property string title

    /*!
        This signal is emitted when the Back button is released.
        When handling this signal, use the \l {KeyEvent::}{accepted} property of the \a event
        parameter to control whether this Page override the default behaviour.
        The default is to ignore the event and pop the \l PageStack if this isn't a top level \l Page,
        or exit the application if it is a top level \l Page.
        If \e accepted is set to \c true, the default behaviour is overriden and this \l Page stays on the \l PageStack.
        The corresponding handler is \c onBackReleased.
    */
    signal backReleased(var event)

    /*!
       Pop this page from the page stack. This does nothing if this page is not
       the current page on the page stack.
     */
    function pop() {
        if (Controls.Stack.view.currentItem === page)
            return Controls.Stack.view.pop();
    }

    /*!
       Push the specified component onto the page stack.
     */
    function push(component, properties) {
        return Controls.Stack.view.push({item: component, properties: properties});
    }

    onRightSidebarChanged: {
        if (rightSidebar)
            rightSidebar.mode = "right"
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            // When the Android back button is tapped
            if (__actionBar.overflowMenuShowing) {
                // Close the action bar overflow menu if it's open
                __actionBar.closeOverflowMenu();
                event.accepted = true;
            } else {
                // or signal the back button has been tapped
                backReleased(event);
                // and pop the page from the page stack if no handlers accepted the event
                if (!event.accepted && pop()) {
                    event.accepted = true;
                }
            }
        } else if (event.key === Qt.Key_Menu) {
            // Display or hide the action bar overflow menu when the Android menu button is tapped
            if (__actionBar.overflowMenuAvailable) {
                if (__actionBar.overflowMenuShowing) {
                    __actionBar.closeOverflowMenu();
                } else {
                    __actionBar.openOverflowMenu();
                }
                event.accepted = true;
            }
        }
    }

    ActionBar {
        id: __actionBar

        title: page.title
        backAction: page.backAction
        actions: page.actions
    }

    Rectangle {
        anchors.fill: parent
        color: backgroundColor
    }

    Item {
        id: content

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: rightSidebarContent.left
        }
    }

    Item {
        id: rightSidebarContent

        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }

        children: [rightSidebar]

        width: rightSidebar
               ? rightSidebar.width + rightSidebar.anchors.rightMargin
               : 0
    }
}
