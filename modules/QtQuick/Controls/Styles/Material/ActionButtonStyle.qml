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
import QtGraphicalEffects 1.0

ButtonStyle {
    id: style

    padding {
        left: 0
        right: 0
        top: 0
        bottom: 0
    }

    background: Item {
        RectangularGlow {

            anchors.centerIn: parent
            anchors.verticalCenterOffset: control.elevation == 1 ? Units.dp(1.5)
                                                         : Units.dp(1)

            width: parent.width
            height: parent.height

            glowRadius: control.elevation == 1 ? Units.dp(0.75) : Units.dp(0.3)
            opacity: control.elevation == 1 ? 0.6 : 0.3
            spread: control.elevation == 1 ? 0.7 : 0.85
            color: "black"
            cornerRadius: height/2
        }

        View {
            anchors.fill: parent
            radius: width/2

            backgroundColor: control.backgroundColor

            tintColor: control.pressed ||
                       (control.focus && !control.elevation) ||
                       (control.hovered && !control.elevation) ?
                       Qt.rgba(0,0,0, control.pressed ? 0.1 : 0.05) : "transparent"

            Ink {
                id: mouseArea
                anchors.fill: parent

                Connections {
                    target: control.__behavior
                    onPressed: mouseArea.onPressed(mouse)
                    onCanceled: mouseArea.onCanceled()
                    onReleased: mouseArea.onReleased(mouse)
                    onEntered: control.containsMouse = true
                    onExited: control.containsMouse = false
                }

                circular: true
            }
        }
    }
    label: Item {
        implicitHeight: control.isMiniSize ? Units.dp(40) : Units.dp(56)
        implicitWidth: implicitHeight
        Icon {
            id: icon

            anchors.centerIn: parent
            source: control.iconSource
            color: control.iconColor
            size: Units.dp(24)
        }
    }
}
