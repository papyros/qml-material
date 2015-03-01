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
import QtQuick.Controls.Styles 1.2
import Material 0.1

Controls.CheckBox {
    id: checkBox

    /*!
       The checkbox color. By default this is the app's accent color
     */
    property color color: darkBackground ? Theme.dark.accentColor
                                         : Theme.light.accentColor

    /*!
       Set to \c true if the checkbox is on a dark background
     */
    property bool darkBackground

    style: CheckBoxStyle {
        id: checkboxStyle

        spacing: units.dp(2)

        label: Item {
            implicitWidth: text.implicitWidth + 2
            implicitHeight: text.implicitHeight

            baselineOffset: text.baselineOffset

            Label {
                id: text

                anchors.centerIn: parent

                style: "button"
                color: control.enabled ? darkBackground ? Theme.dark.textColor
                                                        : Theme.light.textColor
                                       : darkBackground ? Theme.alpha("#fff", 0.30)
                                                        : Theme.alpha("#000", 0.26)
                text: control.text
            }
        }

        indicator: Item {
            id: parentRect

            implicitWidth: units.dp(54)
            implicitHeight: units.dp(54)

            Rectangle {
                id: indicatorRect

                anchors.centerIn: parent

                property color __internalColor: control.enabled ? control.color
                                                                : darkBackground ? Theme.alpha("#fff", 0.30)
                                                                                 : Theme.alpha("#000", 0.26)

                width: units.dp(24)
                height: units.dp(24)
                radius: units.dp(2)

                border.width: units.dp(2)

                border.color: control.enabled ? control.checked ? control.color
                                                                : darkBackground ? Theme.alpha("#fff", 0.70)
                                                                                 : Theme.alpha("#000", 0.54)
                                              : darkBackground ? Theme.alpha("#fff", 0.30)
                                                               : Theme.alpha("#000", 0.26)

                color: control.checked ? __internalColor : "transparent"

                Behavior on color {
                    ColorAnimation {
                        easing.type: Easing.InOutQuad
                        duration: 200
                    }
                }

                Behavior on border.color {
                    ColorAnimation {
                        easing.type: Easing.InOutQuad
                        duration: 200
                    }
                }

                Item {
                    id: container

                    anchors.centerIn: indicatorRect

                    height: parent.height
                    width: parent.width

                    opacity: control.checked ? 1 : 0

                    property int thickness: units.dp(4)

                    Behavior on opacity {
                        NumberAnimation {
                            easing.type: Easing.InOutQuad
                            duration: 200
                        }
                    }

                    Rectangle {
                        id: vert

                        anchors {
                            top: parent.top
                            right: parent.right
                            bottom: parent.bottom
                        }

                        color: darkBackground ? Theme.light.textColor
                                              : Theme.dark.textColor
                        width: container.thickness * 2
                    }
                    Rectangle {
                        anchors {
                            left: parent.left
                            right: vert.left
                            bottom: parent.bottom
                        }

                        color: darkBackground ? Theme.light.textColor
                                              : Theme.dark.textColor
                        height: container.thickness
                    }

                    transform: [
                        Scale {
                            origin { x: container.width / 2; y: container.height / 2 }
                            xScale: 0.5
                            yScale: 1
                        },
                        Rotation {
                            origin { x: container.width / 2; y: container.height / 2 }
                            angle: 45;
                        },
                        Scale {
                            id: widthScale

                            origin { x: container.width / 2; y: container.height / 2 }
                            xScale: control.checked ? 0.6 : 0.2
                            yScale: control.checked ? 0.6 : 0.2

                            Behavior on xScale {
                                NumberAnimation {
                                    easing.type: Easing.InOutQuad
                                    duration: 200
                                }
                            }

                            Behavior on yScale {
                                NumberAnimation {
                                    easing.type: Easing.InOutQuad
                                    duration: 200
                                }
                            }
                        },
                        Translate { y: -(container.height - (container.height * 0.9)) }
                    ]
                }
            }
        }
    }

    Ink {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
        }

        width: units.dp(54)
        height: units.dp(54)
        color: checkBox.checked ? Theme.alpha(checkBox.color, 0.20)
                                : Theme.alpha("#000", 0.1)
        enabled: checkBox.enabled

        circular: true
        centered: true

        onClicked: checkBox.checked = !checkBox.checked
    }
}
