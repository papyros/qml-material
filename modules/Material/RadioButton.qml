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

    /*!
       The switch color. By default this is the app's accent color
     */
    property color color: darkBackground ? Theme.dark.accentColor : Theme.light.accentColor

    /*!
       Set to \c true if the switch is on a dark background
     */
    property bool darkBackground

    style: ControlStyles.RadioButtonStyle {
        label :Label {
            text: control.text
            style: "button"
            color: control.enabled ? radioButton.darkBackground ? Theme.dark.textColor
                                                                : Theme.light.textColor
                                   : radioButton.darkBackground ? Theme.alpha("#fff", 0.30)
                                                                : Theme.alpha("#000", 0.26)
        }

        background: Rectangle {
            color: "transparent"
        }

        indicator: Rectangle {
            implicitWidth: units.dp(48)
            implicitHeight: units.dp(48)
            radius: implicitHeight / 2
            color: control.activeFocus ? Theme.alpha(radioButton.color, 0.20) : "transparent"

            Rectangle {
                anchors.centerIn: parent
                implicitWidth: units.dp(20)
                implicitHeight: units.dp(20)
                radius: implicitHeight / 2
                color: "transparent"
                border.color: control.enabled ? control.checked ? radioButton.color
                              : radioButton.darkBackground ? Theme.alpha("#fff", 0.70) : Theme.alpha("#000", 0.54)
                              : radioButton.darkBackground ? Theme.alpha("#fff", 0.30) : Theme.alpha("#000", 0.26)
                border.width: units.dp(2)
                antialiasing: true

                Behavior on border.color {
                    ColorAnimation { duration: 200}
                }

                Rectangle {
                    anchors.centerIn: parent
                    implicitWidth: control.checked ? units.dp(10) : 0
                    implicitHeight: control.checked ? units.dp(10) : 0
                    color: control.enabled ? radioButton.color
                                           : radioButton.darkBackground ? Theme.alpha("#fff", 0.30)
                                                                        : Theme.alpha("#000", 0.26)
                    radius: implicitHeight / 2
                    antialiasing: true

                    Behavior on implicitWidth {
                        NumberAnimation { duration: 200 }
                    }

                    Behavior on implicitHeight {
                        NumberAnimation { duration: 200 }
                    }
                }
            }
        }

        spacing: 0
    }

    Ink {
        anchors {
            left: parent.left
            leftMargin: units.dp(4)
            verticalCenter: parent.verticalCenter
        }

        width: units.dp(40)
        height: units.dp(40)
        color: radioButton.checked ? Theme.alpha(radioButton.color, 0.20) : Qt.rgba(0,0,0,0.1)
        onClicked: radioButton.checked = !radioButton.checked

        circular: true
        centered: true
    }
}
