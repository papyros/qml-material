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
