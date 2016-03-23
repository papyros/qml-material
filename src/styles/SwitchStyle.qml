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
import Material 0.3

SwitchStyle {
    id: style

    property color color: control.hasOwnProperty("color")
            ? control.color : Theme.light.accentColor

    property bool darkBackground: control.hasOwnProperty("darkBackground")
            ? control.darkBackground : false

    handle: View {
        width: 22 * Units.dp
        height: 22 * Units.dp

        radius: height/2

        elevation: 2
        backgroundColor: control.enabled ? control.checked ? color : darkBackground ? "#BDBDBD"
                                                                                    : "#FAFAFA"
                                         : darkBackground ? "#424242" : "#BDBDBD"
    }

    groove: Item {
        width: 40 * Units.dp
        height: 22 * Units.dp

        Rectangle {

            anchors.centerIn: parent

            width: parent.width - 2 * Units.dp
            height: 16 * Units.dp

            radius: height/2

            color: control.enabled ? control.checked ? Theme.alpha(style.color, 0.5)
                                                     : darkBackground ? Qt.rgba(1, 1, 1, 0.26)
                                                                      : Qt.rgba(0, 0, 0, 0.30)
                                   : darkBackground ? Qt.rgba(1, 1, 1, 0.12)
                                                    : Qt.rgba(0, 0, 0, 0.12)

            Behavior on color {

                ColorAnimation {
                    duration: 200
                }
            }
        }
    }
}
