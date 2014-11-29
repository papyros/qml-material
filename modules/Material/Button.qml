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

View {
    id: button
    height: units.dp(36)
    width: Math.max(units.dp(64), label.width + units.dp(16))

    radius: units.dp(2)

    property bool raised

    property string text
    property color textColor: Theme.lightDark(backgroundColor, Theme.light.textColor,
                                                                  Theme.dark.textColor)

    signal triggered

    tintColor: mouseArea.pressed ? Qt.rgba(0,0,0, 0.1) : "transparent"

    Ink {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            button.triggered()
        }
    }

    Label {
        id: label

        anchors.centerIn: parent
        text: button.text.toUpperCase()

        color: button.textColor

        style: "button"
    }
}
