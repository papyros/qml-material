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

Controls.Slider {
    id: dataPercentSlider
    tickmarksEnabled: false
    implicitHeight: units.dp(32)
    implicitWidth: units.dp(200)
    style: ControlStyles.SliderStyle {
//                        property Component knob : Item {
//                                implicitHeight: Material.units.dp(32)
//                                implicitWidth: Material.units.dp(32)

//                                Material.Label {
//                                    anchors.fill: parent
//                                    horizontalAlignment: Qt.AlignHCenter
//                                    verticalAlignment: Qt.AlignVCenter
//                                    text: control.value
//                                    color: Material.Theme.lightDark(Material.Theme.primaryColor,
//                                                           Material.Theme.light.textColor,
//                                                           Material.Theme.dark.textColor)
//                                    z: 1
//                                }

//                                Rectangle {
//                                id: roundKnob
//                                implicitHeight: Material.units.dp(32)
//                                implicitWidth: Material.units.dp(32)
//                                radius: implicitWidth / 2
//                                color: Material.Theme.primaryColor

//                                Rectangle {
//                                    implicitHeight: Material.units.dp(16)
//                                    implicitWidth: Material.units.dp(16)
//                                    color: Material.Theme.primaryColor
//                                    anchors.right: roundKnob.right
//                                    anchors.bottom: roundKnob.bottom
//                                }

//                                transform: [
//                                    Rotation {
//                                        origin { x: Material.units.dp(16); y: Material.units.dp(16)}
//                                        angle: 45;
//                                    }
//                                ]
//                            }
//                        }
        groove: Rectangle {
            implicitWidth: 200
            implicitHeight: units.dp(2)
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.alpha("#000000", 0.26)
            Rectangle {
                height: parent.height
                width: styleData.handlePosition
                implicitHeight: units.dp(2)
                implicitWidth: 200
                color: Theme.primaryColor
            }
        }
        handle: Item {
            anchors.centerIn: parent
            implicitHeight: units.dp(8)
            implicitWidth: units.dp(8)

//                            Loader {
//                                anchors.horizontalCenter: parent.horizontalCenter
//                                anchors.bottom: parent.top
//                                sourceComponent: knob
//                            }

            Rectangle {
                anchors.centerIn: parent
                implicitHeight: units.dp(32)
                implicitWidth: units.dp(32)
                color: control.activeFocus ?
                           Theme.alpha(Theme.primaryColor, 0.20) :
                           "transparent"
                radius: implicitHeight / 2
                Rectangle {
                    anchors.centerIn: parent

                    color: control.value === control.minimumValue ?
                               Theme.backgroundColor :
                               Theme.primaryColor

                    border.color: control.value === control.minimumValue ?
                                      Theme.alpha("#000000", 0.26) :
                                      Theme.primaryColor

                    border.width: units.dp(2)

                    implicitHeight: control.pressed && !control.activeFocus ?
                                units.dp(24) :
                                units.dp(16)

                    implicitWidth: control.pressed && !control.activeFocus ?
                               units.dp(24) :
                               units.dp(16)

                    radius: implicitWidth / 2

                    Behavior on implicitHeight {
                        NumberAnimation { duration: 200}
                    }

                    Behavior on implicitWidth {
                        NumberAnimation { duration: 200}
                    }
                }
            }
        }

//                        tickmarks: Repeater {
//                            id: repeater
//                            model: control.stepSize > 0 ? 1 + (control.maximumValue - control.minimumValue) / control.stepSize : 0
//                            Rectangle {
//                                color: "#000000"
//                                width: Material.units.dp(2)
//                                height: Material.units.dp(2)
//                                x: Math.round(styleData.handleWidth / 2 + index * ((repeater.width - styleData.handleWidth) / (repeater.count-1)))
//                                anchors.verticalCenter: parent.verticalCenter
//                            }
//                        }
    }
}
