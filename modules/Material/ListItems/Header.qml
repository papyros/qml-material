/*
 * QML Air - A lightweight and mostly flat UI widget collection for QML
 * Copyright (C) 2014 Michael Spencer
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
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
    id: listItem

    //----- STYLE PROPERTIES -----//

    height: Units.dp(48)
    property int margins: Units.dp(16)

    anchors {
        left: parent.left
        right: parent.right
    }

    property int spacing

    property alias text: label.text

    Label {
        id: label

        style: "body1"

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            margins: margins
        }

        color: Theme.light.subTextColor
    }

    property bool showDivider: false

    ThinDivider {
        anchors.bottom: parent.bottom
        visible: showDivider
    }
}
