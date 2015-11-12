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
import Material 0.1

SliderStyle {
    id: style

    property color color: control.hasOwnProperty("color")
            ? control.color : Theme.light.accentColor

    property bool darkBackground: control.hasOwnProperty("darkBackground")
            ? control.darkBackground : false

    property bool numericValueLabel: control.hasOwnProperty("numericValueLabel")
            ? control.numericValueLabel : false

    property Component knob : Item {
        implicitHeight: control.pressed || control.focus ? Units.dp(32) : 0
        implicitWidth: control.pressed || control.focus ? Units.dp(32) : 0

        Label {
            anchors.fill: parent
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            text: control.value
            color: Theme.lightDark(styleColor,
                                            Theme.light.textColor,
                                            Theme.dark.textColor)
            opacity: control.pressed || control.focus ? 1 : 0
            z: 1

            property color styleColor: control.hasOwnProperty("color")
                    ? control.color : Theme.light.accentColor

            Behavior on opacity {
                NumberAnimation { duration: 200}
            }
        }

        Rectangle {
            id: roundKnob
            implicitHeight: parent.height
            implicitWidth: parent.width
            radius: implicitWidth / 2
            color: style.color
            antialiasing: true
            clip: true

            Rectangle {
                implicitHeight: parent.height / 2
                implicitWidth: parent.width / 2
                color: style.color
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                antialiasing: true
            }

            transform: [
                Rotation {
                    origin { x: parent.width / 2; y: parent.height / 2 }
                    angle: 45;
                }
            ]
        }

        Behavior on implicitHeight {
            NumberAnimation { duration: 200}
        }

        Behavior on implicitWidth {
            NumberAnimation { duration: 200}
        }
    }

    groove: Rectangle {
        implicitWidth: 200
        implicitHeight: Units.dp(2)

        anchors.verticalCenter: parent.verticalCenter

        color: style.darkBackground ? Theme.alpha("#FFFFFF", 0.3)
                                    : Theme.alpha("#000000", 0.26)

        Rectangle {
            height: parent.height
            width: styleData.handlePosition
            implicitHeight: Units.dp(2)
            implicitWidth: 200
            color: style.color
        }
    }

    handle: Item {
        anchors.centerIn: parent
        implicitHeight: Units.dp(8)
        implicitWidth: Units.dp(8)

        Loader {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: Units.dp(16)
            sourceComponent: style.numericValueLabel ? knob : null
        }

        Rectangle {
            anchors.centerIn: parent
            implicitHeight: Units.dp(32)
            implicitWidth: Units.dp(32)
            color: control.focus ?
                       Theme.alpha(style.color, 0.20) :
                       "transparent"
            radius: implicitHeight / 2
            Rectangle {
                property var diameter: control.enabled ? Units.dp(16) : Units.dp(12)
                anchors.centerIn: parent
                color: control.value === control.minimumValue ?
                           Theme.backgroundColor : style.color

                border.color: control.value === control.minimumValue
                              ? style.darkBackground ? Theme.alpha("#FFFFFF", 0.3)
                                                       : Theme.alpha("#000000", 0.26)
                              : style.color

                border.width: Units.dp(2)

                implicitHeight: control.pressed && !control.focus && !style.numericValueLabel ?
                                    diameter + Units.dp(8) :
                                    diameter

                implicitWidth: control.pressed && !control.focus && !style.numericValueLabel ?
                                   diameter + Units.dp(8) :
                                   diameter

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

    tickmarks: Repeater {
        id: repeater
        model: control.stepSize > 0 ? 1 + (control.maximumValue - control.minimumValue) / control.stepSize : 0

        Rectangle {
            color: style.darkBackground ? "#FFFFFF" : "#000000"
            width: Math.round(Units.dp(2)); height: Units.dp(2)
            y: repeater.height / 2
            x: styleData.handleWidth / 2 + index * ((repeater.width - styleData.handleWidth) / (repeater.count-1))
        }
    }

    panel: Item {
        id: root
        property int handleWidth: handleLoader.width
        property int handleHeight: handleLoader.height

        property bool horizontal : control.orientation === Qt.Horizontal
        property int horizontalSize: grooveLoader.implicitWidth + padding.left + padding.right
        property int verticalSize: Math.max(handleLoader.implicitHeight, grooveLoader.implicitHeight) + padding.top + padding.bottom

        implicitWidth: horizontal ? horizontalSize : verticalSize
        implicitHeight: horizontal ? verticalSize : horizontalSize

        y: horizontal ? 0 : height
        rotation: horizontal ? 0 : -90
        transformOrigin: Item.TopLeft

        Item {
            anchors.fill: parent

            Loader {
                id: grooveLoader
                property QtObject styleData: QtObject {
                    readonly property int handlePosition: handleLoader.x + handleLoader.width/2
                }
                x: padding.left + control.__panel.handleWidth / 2
                sourceComponent: groove
                width: (horizontal ? parent.width : parent.height) - padding.left - padding.right - (control.__panel.handleWidth)
                y:  Math.round(padding.top + (Math.round(horizontal ? parent.height : parent.width - padding.top - padding.bottom) - grooveLoader.item.height - control.__panel.handleHeight) / (style.numericValueLabel ? 1 : 2))
            }

            Loader {
                id: tickMarkLoader
                x: padding.left
                width: (horizontal ? parent.width : parent.height) - padding.left - padding.right
                y:  grooveLoader.y
                sourceComponent: control.tickmarksEnabled ? tickmarks : null
                property QtObject styleData: QtObject { readonly property int handleWidth: control.__panel.handleWidth }
            }

            Loader {
                id: handleLoader
                sourceComponent: handle
                anchors.verticalCenter: grooveLoader.verticalCenter
                x: Math.round((control.__handlePos - control.minimumValue) / (control.maximumValue - control.minimumValue) * ((horizontal ? root.width : root.height) - item.width))

                Behavior on x {
                    NumberAnimation { duration: 100 }
                    enabled: control.tickmarksEnabled
                }
            }
        }
    }
}
