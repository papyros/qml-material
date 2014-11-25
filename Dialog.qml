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

View {
    width: 270
    height: 300
    elevation: 5

    property string title

    Label {
        text: title

        fontStyles: "title"

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: units.dp(24)
        }
    }

    Button {
        anchors {
            right: acceptButton.left
            bottom: parent.bottom
            bottomMargin: units.dp(16)
        }

        text: "CANCEL"
    }

    Button {
        id: acceptButton

        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: units.dp(16)
        }

        style: "primary"
        text: "ACCEPT"
    }
}
