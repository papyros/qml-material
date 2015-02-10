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
import QtQuick.Controls 1.2 as Controls
import QtQuick.Window 2.0
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
Controls.ApplicationWindow {
    id: app

    /*!
       A grouped property that allows the application to customize the the primary color, the
       primary dark color, and the accent color. See \l Theme for more details.
     */
    property alias theme: __theme

    /*!
       The initial page shown when the application starts.
     */
    property alias initialPage: __pageStack.initialItem

    /*!
       The \l PageStack used for controlling pages and transitions between pages.
     */
    property alias pageStack: __pageStack

    property bool clientSideDecorations: false

    AppTheme {
        id: __theme
    }

    Toolbar {
        id: __toolbar
        width: parent.width
        backgroundColor: Theme.primaryColor
        z: 1

        clientSideDecorations: app.clientSideDecorations
    }

    PageStack {
        id: __pageStack
        anchors {
            left: parent.left
            right: parent.right
            top: __toolbar.bottom
            bottom: parent.bottom
        }

        onPushed: __toolbar.push( page )
        onPopped: __toolbar.pop(  )
        onReplaced: __toolbar.replace( page )
    }


    Rectangle {
        id: overlayLayer
        objectName: "overlayLayer"

        anchors.fill: parent
        z: 100

        property Item currentOverlay
        color: "transparent"

        states: State {
            name: "ShowState"
            when: overlayLayer.currentOverlay != null

            PropertyChanges {
                target: overlayLayer
                color: currentOverlay.backdropColor
            }
        }

        transitions: Transition {
            ColorAnimation {
                duration: 300
                easing.type: Easing.InOutQuad
            }

        }

        MouseArea {
            anchors.fill: parent
            enabled: overlayLayer.currentOverlay != null
            hoverEnabled: enabled
            onClicked: overlayLayer.currentOverlay.close()
            onWheel: wheel.accepted = true
        }
    }

    width: units.dp(800)
    height: units.dp(600)

    Component.onCompleted: {
        if (clientSideDecorations)
            flags |= Qt.FramelessWindowHint

      units.pixelDensity = Qt.binding( function() { return Screen.pixelDensity } );
      Device.type = Qt.binding( function () {
        var diagonal = Math.sqrt(Math.pow((Screen.width/Screen.pixelDensity), 2) + Math.pow((Screen.height/Screen.pixelDensity), 2)) * 0.039370;
        if (diagonal >= 3.5 && diagonal < 5) { //iPhone 1st generation to phablet
          units.multiplier = 1;
          return Device.phone;
        } else if (diagonal >= 5 && diagonal < 6.5) {
          units.multiplier = 1;
          return Device.phablet;
        } else if (diagonal >= 6.5 && diagonal < 10.1) {
          units.multiplier = 1;
          return Device.tablet;
        } else if (diagonal >= 10.1 && diagonal < 29) {
          return Device.desktop;
        } else if (diagonal >= 29 && diagonal < 92) {
          return Device.tv;
        } else {
          return Device.unknown;
        }
      } );
    }
}
