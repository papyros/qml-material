/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Bogdan Cuza <bogdan.cuza@hotmail.com>
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
import QtQuick.Controls.Styles 1.2 as ControlStyles
import Material 0.1


Controls.TextField {
	id: field

	property color accentColor: Theme.accentColor
	
	height: units.dp(48)
	width: units.dp(200)
	y: units.dp(16)

	style: ControlStyles.TextFieldStyle {
		textColor: "black"
		font {
			family: "Roboto"
			pixelSize: units.dp(16)
		}
		placeholderTextColor: Theme.light.hintColor
		selectedTextColor: "white"
		selectionColor: Qt.darker(field.accentColor, 1)
		background: Rectangle {
			Rectangle {
				color: field.activeFocus ? field.accentColor : Theme.light.hintColor
				
				height: field.activeFocus ? units.dp(2) : units.dp(1)
				
				Behavior on height {
					NumberAnimation { duration: 200}
				}
				
				Behavior on color {
					ColorAnimation { duration: 200}
				}
				
				anchors {
					left: parent.left
					right: parent.right
					bottom: parent.bottom
					bottomMargin: units.dp(8)
				}
			}
		}
	}
}
