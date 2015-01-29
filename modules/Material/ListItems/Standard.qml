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
import ".."

BaseListItem {
    id: listItem

    height: units.dp(48)

    property alias text: label.text
    property alias valueText: valueLabel.text

    property alias action: actionItem.children
    property alias secondaryItem: secondaryItem.children

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
            leftMargin: actionItem.children.length == 0 ? listItem.margins : units.dp(52) + listItem.margins
        }

        elide: Text.ElideRight
        style: "subheading"

        width: (valueLabel.text ? parent.width * 0.8 : parent.width)
                - label.leftMargin - listItem.margins
    }

    Label {
        id: valueLabel

        color: Theme.light.subTextColor
        elide: Text.ElideRight
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: label.right
        anchors.leftMargin: units.dp(16)
        anchors.right: parent.right
        anchors.rightMargin: listItem.margins
        horizontalAlignment: Text.AlignRight

        style: "body1"
        visible: text != ""
    }

    Item {
        id: secondaryItem
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: listItem.margins
        height: parent.height
        width: parent.width * 0.2
    }
}
