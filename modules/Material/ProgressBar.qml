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
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0
import Material 0.1

Item {

    property real progress
    property alias color: bar.color

    property bool alwaysShow

    width: units.dp(200)
    height: alwaysShow || (progress > 0 && progress < 1) ? units.dp(4) : 0

    Behavior on height {
        NumberAnimation { duration: 200 }
    }

    Rectangle {
        radius: units.dp(2)
        color: bar.color
        opacity: 0.2

        anchors.fill: parent
    }

    Rectangle {
        id: bar

        radius: units.dp(2)
        height: parent.height
        width: parent.width * progress
        color: Theme.accentColor
    }
}
