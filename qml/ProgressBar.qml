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
import QtQuick 2.0
import Quantum.Controls 1.0

Item {

    property real progress
    property alias color: bar.color
    implicitWidth: 100
    implicitHeight: 30

    height: progress > 0 && progress < 1 ? Units.dp(4) : 0

    Behavior on height {
        NumberAnimation { duration: 200 }
    }

    Rectangle {
        radius: Units.dp(2)
        color: Theme.backgroundColor(Theme.SecondaryColor)

        opacity: 0.2

        anchors.fill: parent
    }

    Rectangle {
        id: bar

        radius: Units.dp(2)
        height: parent.height
        width: parent.width * progress
        color: Theme.backgroundColor(Theme.SecondaryColor)
    }
}
