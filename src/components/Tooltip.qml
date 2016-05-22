/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2015 Jordan Neidlinger <jneidlinger@gmail.com>
 *               2015-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import Material 0.3
import Material.Extras 0.1

/*!
   \qmltype Tooltip
   \inqmlmodule Material

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

    width: tooltipLabel.paintedWidth + 32 * Units.dp
    implicitHeight: Device.isMobile ? 44 * Units.dp : 40 * Units.dp

    backgroundColor: Qt.rgba(0.2, 0.2, 0.2, 0.9)

    Timer {
        id: timer

        interval: 1000
        onTriggered: open(mouseArea, 0, 4 * Units.dp)
    }

    Connections {
        target: mouseArea

        onReleased: {
            if(showing)
                close()
        }

        onPressAndHold: {
            if(text !== "" && !showing)
                open(mouseArea, 0, 4 * Units.dp)
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
