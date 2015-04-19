/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Jordan Neidlinger <jneidlinger@gmail.com>
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
import Material 0.1
import Material.Extras 0.1

/*!
   \qmltype Tooltip
   \inqmlmodule Material 0.1

   \brief A tooltip is a label that appears on hover and explains a non-text UI element.

   To display a tooltip for your view, simply create an instance of Tooltip, 
   set the text property to your tooltip text, and then set the mouseArea property
   to your MouseArea or Ink that will trigger the tooltip. If you use a MouseArea,
   make sure hoverEnabled is set to true.

   See the Material Design guidelines for more details: 
   http://www.google.com/design/spec/components/tooltips.html
 */
PopupBase {
    id: dropdown

    property alias text: tooltipLabel.text

    property MouseArea mouseArea
    
    overlayLayer: "tooltipOverlayLayer"
    globalMouseAreaEnabled: false

    width: tooltipLabel.paintedWidth + (Device.isMobile ? units.dp(32) : units.dp(16))
    height: Device.isMobile ? units.dp(44) : units.dp(22)

    visible: view.opacity > 0

    function open(caller, offsetX, offsetY) {
        parent = Utils.findRootChild(dropdown, overlayLayer)

        if(typeof offsetX === "undefined")
            offsetX = 0

        if(typeof offsetY === "undefined")
            offsetY = 0

        var position = caller.mapToItem(dropdown.parent, 0, 0)
        var globalPos = caller.mapToItem(null, 0, 0)
        var root = Utils.findRoot(dropdown)

        dropdown.x = position.x + (caller.width / 2 - dropdown.width / 2)
        dropdown.y = position.y + caller.height//    - dropdown.height

        if(dropdown.x + width > root.width)
            offsetX = -(((dropdown.x + width) - root.width) + units.dp(8))

        dropdown.x += offsetX
        dropdown.y += offsetY

        showing = true
        parent.currentOverlay = dropdown

        opened()
    }

    function close() {
        showing = false
        parent.currentOverlay = null
    }

    Timer {
        id: timer

        interval: 1000
        onTriggered: open(mouseArea, 0, units.dp(4))
    }

    Connections {
        target: mouseArea

        onReleased: {
            if(showing)
                close()
        }

        onPressAndHold: {
            if(text !== "" && !showing)
                open(mouseArea, 0, units.dp(4))
        }

        onEntered: {
            if(text !== "" && !showing)
                timer.start()    
        }

        onExited: {
            timer.stop()

            if(showing)
                close()
        }
    }

    View {
        id: view

        elevation: 2
        radius: units.dp(2)
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            topMargin: dropdown.showing ? 0 : -dropdown.height/4

            Behavior on topMargin {
                NumberAnimation { duration: 200 }
            }
        }

        height: dropdown.height

        backgroundColor: Qt.rgba(0.2, 0.2, 0.2, 0.9)

        opacity: dropdown.showing ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        Label {
            id: tooltipLabel
            style: "tooltip"
            color: Theme.dark.textColor
            anchors.centerIn: parent
        }
    }
}
