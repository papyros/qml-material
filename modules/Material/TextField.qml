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
import Material 0.1

Item {
	id: textField
	
	property bool floatingLabel: false
	
	property string hintText
	property color color: Theme.accentColor
	property alias text: field.text
	
	height: floatingLabel ? units.dp(72) : units.dp(48)
	width: units.dp(200)
	
	property bool empty: field.text == ""
	
	TextInput {
		id: field
		width: parent.width
		font.pixelSize: units.dp(16)
		y: textField.floatingLabel ? units.dp(37.0) : units.dp(16)
		
		color: Theme.light.textColor
		font.family: "Roboto"
	}

	Label {
		id: fieldPlaceholder
		text: textField.hintText
		font.pixelSize: !textField.empty && textField.floatingLabel ? units.dp(12) : units.dp(16)
		
		y: !textField.empty && textField.floatingLabel ? units.dp(16) : field.y
		
		opacity: !textField.empty && !textField.floatingLabel ? 0 : 1
		color: Theme.light.hintColor
		
		Behavior on y {
			NumberAnimation { duration: 200}
		}
		
		Behavior on font.pixelSize {
			NumberAnimation { duration: 200}
		}
	}
	
	Rectangle {
		color: field.activeFocus ? textField.color : Theme.light.hintColor
		
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
			bottomMargin: units.dp(8) - height/2
		}
	}
}
