/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
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
import Material.ListItems 0.1 as ListItem

BottomSheet {
    id: bottomSheet

    property list<Action> actions

    property string title

    implicitHeight: title !== "" ? header.height + listViewContainer.implicitHeight 
                                 : listViewContainer.implicitHeight

    Column {
        id: column

        anchors.fill: parent

        ListItem.Header {
            id: header
            text: title
            visible: title !== ""
            height: units.dp(56)
            style: "subheading"
            backgroundColor: "white"
            elevation: listView.atYBeginning ? 0 : 1
            z: 2
        }

        Item {
            id: listViewContainer
            
            width: parent.width
            height: title !== "" ? parent.height - header.height : parent.height
            
            implicitHeight: listView.contentHeight + listView.topMargin + listView.bottomMargin
                
            Flickable {
                id: listView
                width: parent.width
                height: parent.height

                interactive: bottomSheet.height < bottomSheet.implicitHeight
                
                topMargin: title !== "" ? 0 : units.dp(8)
                bottomMargin: units.dp(8)

                contentWidth: width
                contentHeight: subColumn.height

                Column {
                    id: subColumn
                    width: parent.width

                    Repeater {
                        model: actions

                        delegate: Column {
                            width: parent.width

                            ListItem.Standard {
                                id: listItem
                                text: modelData.name
                                iconSource: modelData.iconSource
                                visible: modelData.visible
                                enabled: modelData.enabled
                                
                                onClicked: {
                                    actionSheet.close()
                                    modelData.triggered(listItem)
                                }
                            }

                            Item {
                                width: parent.width
                                height: units.dp(16)
                                visible: modelData.hasDividerAfter

                                ThinDivider {
                                    anchors.centerIn: parent
                                    width: parent.width
                                }
                            }
                        }
                    }
                }
            }

            Scrollbar {
                flickableItem: listView
            }
        }
    }
}
