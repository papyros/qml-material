/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Bogdan Cuza <bogdan.cuza@hotmail.com>
 * Copyright (C) 2015 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
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
import QtQuick.Controls 1.3 as Controls
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.3
import Material 0.1

Controls.TextField {

    property color color: Theme.primaryColor
    property color errorColor: Palette.colors["red"]["500"]
    property string helperText
    property bool floatingLabel: false
    property bool hasError: characterLimit && length > characterLimit
    property int characterLimit

    style: TextFieldStyle {

        padding {
            left: 0
            right: 0
            top: 0
            bottom: 0
        }
        font {
            family: "Roboto"
            pixelSize: units.dp(16)
        }
        placeholderTextColor: "transparent"
        selectedTextColor: "white"
        selectionColor: control.color
        textColor: Theme.light.textColor

        background : Item {

            Rectangle {
                id: underline
                color: control.hasError ? control.errorColor
                                        : control.activeFocus ? control.color
                                                              : Theme.light.hintColor

                height: control.activeFocus ? units.dp(2) : units.dp(1)

                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                Behavior on height {
                    NumberAnimation { duration: 200 }
                }

                Behavior on color {
                    ColorAnimation { duration: 200 }
                }
            }


            Label {
                id: fieldPlaceholder

                anchors.verticalCenter: parent.verticalCenter
                text: control.placeholderText
                font.pixelSize: units.dp(16)
                anchors.margins: -units.dp(12)
                color: underline.color

                states: [
                    State {
                        name: "floating"
                        when: control.displayText.length > 0 && floatingLabel
                        AnchorChanges {
                            target: fieldPlaceholder
                            anchors.verticalCenter: undefined
                            anchors.top: parent.top
                        }
                        PropertyChanges {
                            target: fieldPlaceholder
                            font.pixelSize: units.dp(12)
                        }
                    },
                    State {
                        name: "hidden"
                        when: control.displayText.length > 0 && !floatingLabel
                        PropertyChanges {
                            target: fieldPlaceholder
                            visible: false
                        }
                    }
                ]

                transitions: [
                    Transition {
                        id: floatingTransition
                        enabled: false
                        AnchorAnimation {
                            duration: 200
                        }
                        NumberAnimation {
                            duration: 200
                            property: "font.pixelSize"
                        }
                    }
                ]

                Component.onCompleted: floatingTransition.enabled = true
            }

            RowLayout {
                anchors {
                    left: parent.left
                    right: parent.right
                    top: underline.top
                    topMargin: units.dp(4)
                }

                Label {
                    id: helperTextLabel
                    visible: control.helperText
                    text: control.helperText
                    font.pixelSize: units.dp(12)
                    color: control.hasError ? control.errorColor : Qt.darker(Theme.light.hintColor)

                    Behavior on color {
                        ColorAnimation { duration: 200 }
                    }
                }

                Label {
                    id: charLimitLabel
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                    visible: control.characterLimit
                    text: control.length + " / " + control.characterLimit
                    font.pixelSize: units.dp(12)
                    color: control.hasError ? control.errorColor : Theme.light.hintColor
                    horizontalAlignment: Text.AlignLeft

                    Behavior on color {
                        ColorAnimation { duration: 200 }
                    }
                }
            }
        }
    }
}
