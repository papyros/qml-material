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

ButtonStyle {
    id: style

    padding {
        left: 0
        right: 0
        top: 0
        bottom: 0
    }

    property bool darkBackground: control.hasOwnProperty("darkBackground")
                ? control.darkBackground : Theme.isDarkColor(controlBackground)

    property int controlElevation: control.hasOwnProperty("elevation") ? control.elevation : 1

    property color controlBackground: control.hasOwnProperty("backgroundColor")
            ? control.backgroundColor : controlElevation == 0 ? "transparent" : "white"

    property string context: control.hasOwnProperty("context") ? control.context : "default"

    background: View {
        id: background

        implicitHeight: 36 * Units.dp

        radius: 2 * Units.dp

        backgroundColor: control.enabled || controlElevation === 0
                ? controlBackground
                : darkBackground ? Qt.rgba(1, 1, 1, 0.12)
                                 : Qt.rgba(0, 0, 0, 0.12)

        elevation: {
            var elevation = controlElevation

            if (elevation > 0 && (control.focus || mouseArea.currentCircle))
                elevation++;

            if(!control.enabled)
                elevation = 0;

            return elevation;
        }

        tintColor: mouseArea.currentCircle || control.focus || control.hovered
           ? Qt.rgba(0,0,0, mouseArea.currentCircle ? 0.1
                            : elevation > 0 ? 0.03
                            : 0.05)
           : "transparent"

        Ink {
            id: mouseArea

            anchors.fill: parent
            focused: control.focus && background.context !== "dialog"
                    && background.context !== "snackbar"
            focusWidth: parent.width - 30 * Units.dp
            focusColor: Qt.darker(background.backgroundColor, 1.05)

            Connections {
                target: control.__behavior
                onPressed: mouseArea.onPressed(mouse)
                onCanceled: mouseArea.onCanceled()
                onReleased: mouseArea.onReleased(mouse)
            }
        }
    }
    label: Item {
        implicitHeight: Math.max(36 * Units.dp, label.height + 16 * Units.dp)
        implicitWidth: context == "dialog"
                ? Math.max(64 * Units.dp, label.width + 16 * Units.dp)
                : context == "snackbar" ? label.width + 16 * Units.dp
                                        : Math.max(88 * Units.dp, label.width + 32 * Units.dp)

        Label {
            id: label
            anchors.centerIn: parent
            text: control.text
            style: "button"
            color: control.enabled ? control.hasOwnProperty("textColor")
                                     ? control.textColor : darkBackground ? Theme.dark.textColor
                                                                          : Theme.light.textColor
                    : control.darkBackground ? Qt.rgba(1, 1, 1, 0.30)
                                             : Qt.rgba(0, 0, 0, 0.26)
        }
    }
}
