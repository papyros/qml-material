/*
 * QML Material - An application framework implementing Material Design.
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
import QtQuick.Layouts 1.1
import ".."

BaseListItem {
    id: listItem

    height: units.dp(72)

    property alias text: label.text
    property alias subText: subLabel.text
    property alias valueText: valueLabel.text

    property alias action: actionItem.children
    property alias secondaryItem: secondaryItem.children

    dividerInset: actionItem.children.length === 0 ? 0 : listItem.height

    GridLayout {
        anchors.fill: parent
        anchors.leftMargin: actionItem.children.length === 0 ? listItem.margins : 0
        anchors.rightMargin: listItem.margins
        columns: 4
        rows: 1
        columnSpacing: 0

        Item {
            id: actionItem
            Layout.preferredWidth: children.length === 0 ? 0 : units.dp(72)
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: parent.height
            Layout.column: 1
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.column: 2
            spacing: units.dp(3)

            Label {
                id: label
                Layout.fillWidth: true

                elide: Text.ElideRight
                style: "subheading"
            }

            Label {
                id: subLabel
                Layout.fillWidth: true

                color: Theme.light.subTextColor
                elide: Text.ElideRight
                width: parent.width
                wrapMode: Text.WordWrap
                style: "body1"
                visible: text != ""
                maximumLineCount : 2
            }
        }

        Label {
            id: valueLabel
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: visible ? implicitWidth + units.dp(32) : 0
            Layout.column: 3

            color: Theme.light.subTextColor
            elide: Text.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            style: "body1"
            visible: text != ""
        }

        Item {
            id: secondaryItem
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: childrenRect.width
            Layout.preferredHeight: parent.height
            Layout.column: 4
        }
    }
}
