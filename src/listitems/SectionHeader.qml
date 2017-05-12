/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2015 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
 *               2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Layouts 1.1
import Material 0.3

/*!
   \qmltype SectionHeader
   \inqmlmodule Material.ListItems

   \brief A list item that serves as the the header for an expandable list section.
 */
BaseListItem {
    id: listItem

    property alias text: label.text
    property alias iconName: icon.name
    property bool expanded: false

    height: 48 * Units.dp

    RowLayout {
        anchors.fill: parent

        anchors.leftMargin: listItem.margins
        anchors.rightMargin: listItem.margins

        spacing: 16 * Units.dp

        Item {
            Layout.preferredWidth: 40 * Units.dp
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
                color: listItem.expanded ? Theme.primaryColor
                        : darkBackground ? Theme.dark.iconColor : Theme.light.iconColor
                size: 24 * Units.dp
            }
        }

        Label {
            id: label

            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true

            elide: Text.ElideRight
            style: "subheading"

            color: listItem.expanded ? Theme.primaryColor
                    : darkBackground ? Theme.dark.textColor : Theme.light.textColor
        }

        Item {
            Layout.preferredWidth: 40 * Units.dp
            Layout.preferredHeight: width
            Layout.alignment: Qt.AlignRight

            Icon {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }

                name: "navigation/expand_more"
                rotation: listItem.expanded ? 180 : 0
                size: 24 * Units.dp
                color: darkBackground ? Theme.dark.iconColor : Theme.light.iconColor

                Behavior on rotation {
                    NumberAnimation { duration: 200 }
                }
            }
        }
    }

    onClicked: listItem.expanded = !listItem.expanded
}
