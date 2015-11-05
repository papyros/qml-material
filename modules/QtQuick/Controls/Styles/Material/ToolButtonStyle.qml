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

import QtQuick 2.4
import QtQuick.Controls.Styles 1.3
import Material 0.1
import "../Base/"

ToolButtonStyle {
    panel: View {
        radius: Units.dp(2)

        implicitHeight: label.text == "" 
                ? Units.dp(44) : Math.max(Units.dp(36), label.height + Units.dp(16))
        implicitWidth: label.text == "" 
                ? Units.dp(44) : Math.max(Units.dp(64), label.width + Units.dp(16))

        Ink {
            id: mouseArea
            
            anchors.fill: parent

            centered: true
            circular: label.text == ""

            width: parent.width + Units.dp(8)
            height: parent.height + Units.dp(8)
            
            Connections {
                target: control.__behavior
                onPressed: mouseArea.onPressed(mouse)
                onCanceled: mouseArea.onCanceled()
                onReleased: mouseArea.onReleased(mouse)
            }
        }

        Row {
            anchors.centerIn: parent

            spacing: Units.dp(8)

            Image {
                id: image
                anchors.verticalCenter: parent.verticalCenter
                source: control.iconSource
                width: Units.dp(24)
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
