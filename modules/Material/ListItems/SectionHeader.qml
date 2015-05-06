/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
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
import QtQuick 2.4
import QtQuick.Layouts 1.1
import Material 0.1

/*!
   \qmltype SectionHeader
   \inqmlmodule Material.ListItems 0.1

   \brief A list item that serves as the the header for an expandable list section.
 */
BaseListItem {
    id: listItem

    property alias text: label.text
    property alias iconName: icon.name
    property bool expanded: false

    height: Units.dp(48)

    RowLayout {
        anchors.fill: parent

        anchors.leftMargin: listItem.margins
        anchors.rightMargin: listItem.margins

        spacing: Units.dp(16)

        Item {
            Layout.preferredWidth: Units.dp(40)
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
                color: listItem.expanded ? Theme.primaryColor : Theme.light.iconColor
                size: Units.dp(24)
            }
        }

        Label {
            id: label

            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true

            elide: Text.ElideRight
            style: "subheading"

            color: listItem.expanded ? Theme.primaryColor : Theme.light.textColor
        }

        Item {
            Layout.preferredWidth: Units.dp(40)
            Layout.preferredHeight: width
            Layout.alignment: Qt.AlignRight

            Icon {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }

                name: "navigation/expand_more"
                rotation: listItem.expanded ? 180 : 0
                size: Units.dp(24)

                Behavior on rotation {
                    NumberAnimation { duration: 200 }
                }
            }
        }
    }

    onClicked: listItem.expanded = !listItem.expanded
}
