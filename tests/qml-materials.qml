/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.4
import QtQuick.Window 2.2
import "ListItems" as ListItem

Rectangle {
    width: Units.dp(300)
    height: Units.dp(72) * 4
    color: Qt.rgba(0.9,0.9,0.9,1)

    property alias theme: theme

    Theme {
        id: theme
    }

    ListView {
        anchors.centerIn: parent
        width: Units.dp(300)
        height: count * Units.dp(72)

        model: 4
        delegate: ListItem.Subtitled {
            text: "Two line item"
            subText: Units.dp(72) + " == " + (6 * 8)

            action: Rectangle {
                anchors.fill: parent
                color: "gray"
                radius: width/2
            }
        }
    }

    property alias Units: Units


    property real scale: Screen.pixelDensity * 1.2 // pixels/mm

    QtObject {
        id: Units

        function mm(number) {
            return number * scale
        }

        function dp(number) {
            return number * scale * 0.15
        }
    }
}
