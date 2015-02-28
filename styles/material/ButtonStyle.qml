/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtQuick.Controls.Styles 1.3
import Material 0.1

ButtonStyle {
    padding {
        left: 0
        right: 0
        top: 0
        bottom: 0
    }

    background: View {
        id: background

        radius: units.dp(2)

        elevation: {
            var elevation = control.hasOwnProperty("elevation") ? control.elevation : 1

            if (elevation > 0 && (control.focus || mouseArea.currentCircle))
                elevation++;

            if(!control.enabled)
                elevation = 0;

            return elevation;
        }

        property bool darkBackground: control.hasOwnProperty("darkBackground") 
                ? control.darkBackground : false

        property string context: control.hasOwnProperty("context") ? control.context : "default"

        backgroundColor: (control.enabled || elevation === 0)  
                ? control.hasOwnProperty("backgroundColor") ? button.backgroundColor
                                                            : "transparent"
                : darkBackground ? Qt.rgba(1, 1, 1, 0.12)
                                 : Qt.rgba(0, 0, 0, 0.12)

        tintColor: mouseArea.currentCircle || control.focus || control.hovered
           ? Qt.rgba(0,0,0, mouseArea.currentCircle ? 0.1
                            : elevation > 0 ? 0.03
                            : 0.05)
           : "transparent"

        Ink {
            id: mouseArea

            anchors.fill: parent
            focused: control.focus && background.context != "dialog" 
                    && background.context != "snackbar"
            focusWidth: parent.width - units.dp(30)
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
        property string context: control.hasOwnProperty("context") ? control.context : "default"


        implicitHeight: Math.max(units.dp(36), label.height + units.dp(16))
        implicitWidth: context == "dialog" ? Math.max(units.dp(64), label.width + units.dp(16))
                     : context == "snackbar" ? label.width + units.dp(16)
                     : Math.max(units.dp(88), label.width + units.dp(32))

        Label {
            id: label
            anchors.centerIn: parent
            text: control.text
            style: "button"
            color: control.enabled ? control.hasOwnProperty("textColor")
                                     ? control.textColor : Theme.light.textColor 
                    : control.darkBackground ? Qt.rgba(1, 1, 1, 0.30)
                                             : Qt.rgba(0, 0, 0, 0.26)
        }
    }
}