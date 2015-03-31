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

Row {
    id: tabbar

    property var tabs: []

    height: Units.dp(48)

    property int selectedIndex: 0

    property color color: Theme.dark.textColor
    property color highlight: Theme.dark.accentColor

    Repeater {
        id: repeater
        model: tabbar.tabs

        delegate: View {
            id: tabItem
            width:Units.dp(48) + row.width
            height: tabbar.height

            property bool selected: index == tabbar.selectedIndex

            Ink {
                anchors.fill: parent

                onClicked: tabbar.selectedIndex = index
            }

            Rectangle {
                id: selectionIndicator
                anchors {
                    bottom: parent.bottom
                }

                height: Units.dp(2)
                color: tabbar.highlight
                opacity: tabItem.selected ? 1 : 0
                //x: index < tabbar.selectedIndex ? tabItem.width : 0
                //width: index == tabbar.selectedIndex ? tabItem.width : 0
                width: parent.width

                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }

                Behavior on x {
                    NumberAnimation { duration: 200 }
                }

                Behavior on width {
                    NumberAnimation { duration: 200 }
                }
            }

            Row {
                id: row
                anchors.centerIn: parent
                spacing: Units.dp(10)

                Icon {
                    anchors.verticalCenter: parent.verticalCenter
                    name: modelData.hasOwnProperty("icon") ? modelData.icon : ""
                    color: Theme.dark.iconColor
                    visible: name != ""
                }

                Label {
                    id: label
                    text: modelData.hasOwnProperty("text") ? modelData.text : modelData
                    color: Theme.dark.textColor
                    style: "body2"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
