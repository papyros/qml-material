/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2015-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Controls.Styles 1.3
import Material 0.3
import "../Base/"

ToolButtonStyle {
    panel: View {
        radius: 2 * Units.dp

        implicitHeight: label.text == ""
                ? 44 * Units.dp : Math.max(36 * Units.dp, label.height + 16 * Units.dp)
        implicitWidth: label.text == ""
                ? 44 * Units.dp : Math.max(64 * Units.dp, label.width + 16 * Units.dp)

        Ink {
            id: mouseArea

            anchors.fill: parent

            centered: true
            circular: label.text == ""

            width: parent.width + 8 * Units.dp
            height: parent.height + 8 * Units.dp

            Connections {
                target: control.__behavior
                onPressed: mouseArea.onPressed(mouse)
                onCanceled: mouseArea.onCanceled()
                onReleased: mouseArea.onReleased(mouse)
            }
        }

        Row {
            anchors.centerIn: parent

            spacing: 8 * Units.dp

            Image {
                id: image
                anchors.verticalCenter: parent.verticalCenter
                source: control.iconSource
                width: 24 * Units.dp
                height: width
            }

            Label {
                id: label
                anchors.verticalCenter: parent.verticalCenter
                text: control.iconSource !== "" ? "" : control.text
                style: "button"
                color: Theme.lightDark(Theme.primaryColor, Theme.light.textColor,
                                                           Theme.dark.textColor)
                visible: text == ""
            }
        }
    }
}
