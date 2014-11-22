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
import QtQuick 2.2
import QtQuick.Window 2.0
import "ListItems" as ListItem

Rectangle {
    width: units.dp(300)
    height: units.dp(72) * 4
    color: Qt.rgba(0.9,0.9,0.9,1)

    property alias theme: theme

    Theme {
        id: theme
    }

    ListView {
        anchors.centerIn: parent
        width: units.dp(300)
        height: count * units.dp(72)

        model: 4
        delegate: ListItem.Subtitled {
            text: "Two line item"
            subText: units.dp(72) + " == " + (6 * 8)

            action: Rectangle {
                anchors.fill: parent
                color: "gray"
                radius: width/2
            }
        }
    }

    property alias units: units


    property real scale: Screen.pixelDensity // pixels/mm

    QtObject {
        id: units

        function mm(number) {
            return number * scale
        }

        function dp(number) {
            return number * scale * 0.15
        }
    }
}
