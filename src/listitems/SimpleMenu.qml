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
import Material 0.3
import Material.Extras 0.1

/*!
   \qmltype SimpleMenu
   \inqmlmodule Material.ListItems

   \brief A list item that opens a dropdown menu when tapped.
 */
Subtitled {
    id: listItem

    property var model
    property alias selectedIndex: listView.currentIndex

    subText: listView.currentItem.text

    onClicked: menu.open(listItem, 16 * Units.dp, 0)

    property int __maxWidth: 0

    Label {
        id: hiddenLabel
        style: "subheading"
        visible: false

        onContentWidthChanged: {
            __maxWidth = Math.max(contentWidth + 33 * Units.dp, __maxWidth)
        }
    }

    onModelChanged: {
        var longestString = 0;
        for (var i = 0; i < model.length; i++) {
            if(model[i].length > longestString)
            {
                longestString = model[i].length
                hiddenLabel.text = model[i]
            }
        }
    }

    Dropdown {
        id: menu

        anchor: Item.TopLeft

        width: Math.max(56 * 2 * Units.dp, Math.min(listItem.width - 32 * Units.dp, __maxWidth))
        height: Math.min(10 * 48 * Units.dp + 16 * Units.dp, model.length * 48 * Units.dp + 16 * Units.dp)

        Rectangle {
            anchors.fill: parent
            radius: 2 * Units.dp
        }

        ListView {
            id: listView

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: 8 * Units.dp
            }

            interactive: false
            height: count > 0 ? contentHeight : 0
            model: listItem.model

            delegate: Standard {
                id: delegateItem

                text: modelData

                onClicked: {
                    listView.currentIndex = index
                    menu.close()
                }
            }
        }
    }
}
