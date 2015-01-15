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
    property bool floatingLabel: false

    height: floatingLabel ? units.dp(72) : units.dp(48)
	width: units.dp(200)
    verticalAlignment: Text.AlignBottom

	style: ControlStyles.TextFieldStyle {
		textColor: Theme.light.textColor
        padding { top: 0; left: 0; right: 0; bottom: units.dp(16) }

        font {
            family: echoMode == TextInput.Password && field.text.length > 0 ? "" : "Roboto"
            pixelSize: units.dp(16)
        }

        placeholderTextColor: field.floatingLabel ? Qt.rgba(0,0,0,0) : Theme.light.hintColor
		selectedTextColor: "white"
		selectionColor: Qt.darker(field.accentColor, 1)

		background: Rectangle {
            color: "transparent"
            implicitHeight: height
            implicitWidth: width

            Label {
                id: fieldPlaceholder
                text: field.placeholderText
                visible: field.floatingLabel
                font.pixelSize: field.text.length > 0 && field.floatingLabel ? units.dp(12) : units.dp(16)
                y: field.text.length > 0 && field.floatingLabel ? units.dp(16) : field.height / 2
                opacity: field.text.length > 0 && !field.floatingLabel ? 0 : 1
                color: Theme.light.hintColor

                Behavior on y {
                    NumberAnimation { duration: 200}
                }

                Behavior on font.pixelSize {
                    NumberAnimation { duration: 200}
                }
            }

			Rectangle {
                id: underline
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
