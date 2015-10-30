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
import QtQuick 2.4
import Material 0.1
import Material.ListItems 0.1 as ListItem

/*!
   \qmltype BottomActionSheet
   \inqmlmodule Material 0.1

   \brief Represents a bottom sheet displaying a list of actions with an optional title.

 */
BottomSheet {
    id: bottomSheet

    property list<Action> actions

    property string title

    implicitHeight: title !== "" ? header.height + listViewContainer.implicitHeight 
                                 : listViewContainer.implicitHeight

    Column {
        id: column

        anchors.fill: parent

        ListItem.Subheader {
            id: header
            text: title
            visible: title !== ""
            height: Units.dp(56)
            style: "subheading"
            backgroundColor: "white"
            elevation: listView.atYBeginning ? 0 : 1
            fullWidth: true
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
                
                topMargin: title !== "" ? 0 : Units.dp(8)
                bottomMargin: Units.dp(8)

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
                                    bottomSheet.close()
                                    modelData.triggered(listItem)
                                }
                            }

                            ListItem.Divider {
                                visible: modelData.hasDividerAfter
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
