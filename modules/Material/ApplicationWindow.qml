/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer
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
import QtQuick.Window 2.2
import Material 0.1

/*!
   \qmltype ApplicationWindow
   \inqmlmodule Material 0.1
   \ingroup material

   \brief A subclass of \l Window that provides some additional features for developing Applications
   that conform to Material Design.

   This is normally what you should use as your root component. It provides a \l Toolbar and
   \l PageStack to provide access to standard features used by Material Design applications.

   Here is a short working example of an application:

   \qml
   import QtQuick 2.0
   import Material 0.1

   ApplicationWindow {
       title: "Application Name"

       initialPage: page

       Page {
           id: page
           title: "Page Title"

           Label {
               anchors.centerIn: parent
               text: "Hello World!"
           }
       }
   }
   \endqml
*/
Window {
    id: app

    default property alias content: __pageStack.children

    /*!
       The initial page shown when the application starts.
     */
    property alias initialPage: __pageStack.initialPage

    /*!
       The \l PageStack used for controlling pages and transitions between pages.
     */
    property alias pageStack: __pageStack

    /*!
       The \l Toolbar used to display the current page's title, actions, and back button. See
       \l ActionBar and \l Page for more details.
     */
    property alias toolbar: __toolbar


    width: units.dp(800)
    height: units.dp(600)

    Component.onCompleted: units.__pixelDensity = Screen.pixelDensity

    Toolbar {
        id: __toolbar
        z: 2

        backgroundColor: __pageStack.currentPage ? __pageStack.currentPage.actionBar.backgroundColor
                                                    : Theme.primaryColor

        tabs: __pageStack.currentPage.tabs
        expanded: __pageStack.currentPage.cardStyle
    }

    PageStack {
        id: __pageStack

        anchors {
            left: parent.left
            right: parent.right
            top: toolbar.bottom
            bottom: parent.bottom
        }

        onPagePushed: toolbar.pushActionBar(newPage, oldPage)
        onPagePopped: toolbar.popActionBar(previousPage, currentPage)
    }
}
