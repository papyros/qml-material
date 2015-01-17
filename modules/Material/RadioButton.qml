/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Jordan Neidlinger
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

Controls.RadioButton {
    id: radioButton
    style: ControlStyles.RadioButtonStyle {
        label :
            Label {
                text: control.text
                style: "button"
        }

        background: Rectangle {
            color: "transparent"
        }

        indicator: Rectangle {
            implicitWidth: units.dp(48)
            implicitHeight: units.dp(48)
            radius: implicitHeight / 2
            color: control.activeFocus ? Theme.alpha(Theme.accentColor, 0.20) : "transparent"

            Rectangle {
                anchors.centerIn: parent
                implicitWidth: units.dp(16)
                implicitHeight: units.dp(16)
                radius: implicitHeight / 2
                color: "transparent"
                border.color: control.checked ? Theme.accentColor : Theme.light.textColor
                border.width: units.dp(2)
                antialiasing: true

                Behavior on border.color {
                    ColorAnimation { duration: 200}
                }

                Rectangle {
                    anchors.centerIn: parent
                    implicitWidth: control.checked ? units.dp(16) : 0
                    implicitHeight: control.checked ? units.dp(16) : 0
                    color: Theme.accentColor
                    radius: implicitHeight / 2
                    antialiasing: true

                    Behavior on implicitWidth {
                        NumberAnimation { duration: 200}
                    }

                    Behavior on implicitHeight {
                        NumberAnimation { duration: 200}
                    }
                }
            }
        }

        spacing: 0
    }

    Ink {
        anchors.left: parent.left
        width: units.dp(48)
        height: units.dp(48)
        color: radioButton.checked ? Qt.rgba(0,0,0,0.1) : Theme.alpha(Theme.accentColor, 0.20)
        onClicked: radioButton.checked = !radioButton.checked
    }
}
