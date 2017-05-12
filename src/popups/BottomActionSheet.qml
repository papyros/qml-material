/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2015-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1 as ListItem

/*!
   \qmltype BottomActionSheet
   \inqmlmodule Material

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
            height: 56 * Units.dp
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

                topMargin: title !== "" ? 0 : 8 * Units.dp
                bottomMargin: 8 * Units.dp

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
