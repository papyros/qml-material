/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014-2015 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import Material 0.1

/*!
   \qmltype Standard
   \inqmlmodule Material.ListItems 0.1

   \brief A simple list item with a single line of text and optional primary and secondary actions.
 */
BaseListItem {
    id: listItem

    implicitHeight: Units.dp(48)
    height: Units.dp(48)

    property alias text: label.text
    property alias valueText: valueLabel.text

    property alias action: actionItem.children
    property alias iconName: icon.name
    property alias iconSource: icon.source
    property alias secondaryItem: secondaryItem.children
    property alias content: contentItem.children

    property alias itemLabel: label

    property alias textColor: label.color
    property alias iconColor: icon.color

    dividerInset: actionItem.visible ? listItem.height : 0 

    interactive: contentItem.children.length === 0

    implicitWidth: {
        var width = listItem.margins * 2

        if (actionItem.visible)
            width += actionItem.width + row.spacing

        if (contentItem.visible)
            width += contentItem.implicitWidth + row.spacing
        else
            width += label.implicitWidth + row.spacing

        if (valueLabel.visible)
            width += valueLabel.width + row.spacing

        if (secondaryItem.visible)
            width += secondaryItem.width + row.spacing

        return width
    }

    RowLayout {
        id: row
        anchors.fill: parent

        anchors.leftMargin: listItem.margins
        anchors.rightMargin: listItem.margins

        spacing: Units.dp(16)

        Item {
            id: actionItem

            Layout.preferredWidth: Units.dp(40)
            Layout.preferredHeight: width
            Layout.alignment: Qt.AlignCenter

            visible: children.length > 1 || icon.valid

            Icon {
                id: icon

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }

                visible: valid
                color: listItem.selected ? Theme.primaryColor : Theme.light.iconColor
                size: Units.dp(24)
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

            visible: children.length > 0
        }
    }
}
