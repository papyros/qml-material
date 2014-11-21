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
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0
import ".."

BaseListItem {
    id: listItem

    height: units.dp(48)

    property alias text: label.text

    property alias action: actionItem.children

    Item {
        id: actionItem

        anchors {
            left: parent.left
            leftMargin: listItem.margins
            verticalCenter: parent.verticalCenter
        }

        height: width
        width: units.dp(36)
    }

    dividerInset: actionItem.children.length == 0 ? 0 : listItem.height

    Label {
        id: label

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            rightMargin: listItem.margins
            leftMargin: actionItem.children.length == 0 ? listItem.margins : units.dp(52) + listItem.margins
        }

        elide: Text.ElideRight
        style: "subheading"

        width: parent.width
    }
}
