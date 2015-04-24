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
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import Material 0.1

BaseListItem {
    id: listItem

    height: units.dp(48)

    property alias text: label.text
    property alias valueText: valueLabel.text

    property alias action: actionItem.children
    property alias iconName: icon.name
    property alias secondaryItem: secondaryItem.children
    property alias content: contentItem.children

    property alias itemLabel: label

    property alias textColor: label.color
    property alias iconColor: icon.color

    dividerInset: actionItem.visible ? listItem.height : 0 

    interactive: contentItem.children.length == 0

    RowLayout {
        anchors.fill: parent

        anchors.leftMargin: listItem.margins
        anchors.rightMargin: listItem.margins

        spacing: units.dp(16)

        Item {
            id: actionItem

            Layout.preferredWidth: units.dp(40)
            Layout.preferredHeight: width
            Layout.alignment: Qt.AlignCenter

            visible: children.length > 1 || iconName != ""

            Icon {
                id: icon

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }

                visible: name != ""
                color: listItem.selected ? Theme.primaryColor : Theme.light.iconColor
                size: units.dp(24)
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredHeight: parent.height

            Item {
                id: contentItem

                Layout.fillWidth: true
                Layout.preferredHeight: parent.height

                visible: children.length > 0
            }

            Label {
                id: label

                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true

                elide: Text.ElideRight
                style: "subheading"

                color: listItem.selected ? Theme.primaryColor : Theme.light.textColor

                visible: !contentItem.visible
            }
        }

        Label {
            id: valueLabel

            Layout.alignment: Qt.AlignVCenter

            color: Theme.light.subTextColor
            elide: Text.ElideRight
            style: "body1"

            visible: text != ""
        }

        Item {
            id: secondaryItem

            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: childrenRect.width
            Layout.preferredHeight: parent.height

            visible: childrenRect.width > 0
        }
    }
}
