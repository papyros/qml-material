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
import "../Base/"

ToolButtonStyle {
	panel: View {
		radius: units.dp(2)

		implicitHeight: Math.max(units.dp(36), label.height + units.dp(16))
        implicitWidth: Math.max(units.dp(64), label.width + units.dp(16))

        tintColor: control.pressed || control.focus || control.hovered 
        		? Qt.rgba(0,0,0, control.pressed ? 0.2 : 0.1) : "transparent"

        Ink {
            id: mouseArea
            
            anchors.fill: parent

            circular: contrl.text == ""

	        width: parent.width + units.dp(8)
	        height: parent.height + units.dp(8)
            
            Connections {
                target: control.__behavior
                onPressed: mouseArea.onPressed(mouse)
                onCanceled: mouseArea.onCanceled()
                onReleased: mouseArea.onReleased(mouse)
            }
        }

        Row {
            anchors.centerIn: parent

            spacing: units.dp(8)

            Image {
	            id: label
	            anchors.verticalCenter: parent.verticalCenter
	            source: control.iconSource
	        }

        	Label {
	            id: label
	            anchors.verticalCenter: parent.verticalCenter
	            text: control.text
	            style: "button"
	            color: Theme.dark.textColor
	        }
	    }
    }
}