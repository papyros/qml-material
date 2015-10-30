/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Jordan Neidlinger <jneidlinger@gmail.com>
 *               2015 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtQuick 2.4
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
Popover {
    id: dropdown

    property alias text: tooltipLabel.text

    property MouseArea mouseArea
    
    overlayLayer: "tooltipOverlayLayer"
    globalMouseAreaEnabled: false

    width: tooltipLabel.paintedWidth + Units.dp(32)
    implicitHeight: Device.isMobile ? Units.dp(44) : Units.dp(40)

    backgroundColor: Qt.rgba(0.2, 0.2, 0.2, 0.9)

    Timer {
        id: timer

        interval: 1000
        onTriggered: open(mouseArea, 0, Units.dp(4))
    }

    Connections {
        target: mouseArea

        onReleased: {
            if(showing)
                close()
        }

        onPressAndHold: {
            if(text !== "" && !showing)
                open(mouseArea, 0, Units.dp(4))
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

    Label {
        id: tooltipLabel
        style: "tooltip"
        color: Theme.dark.textColor
        anchors.centerIn: parent
    }
}
