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
import QtQuick.Layouts 1.1

import Material 0.1
import Material.ListItems 0.1

/*!
   \qmltype MenuField
   \inqmlmodule Material 0.1

   \brief A input field similar to a text field but that opens a dropdown menu.
 */
Item {
    id: field

    implicitHeight: hasHelperText ? helperTextLabel.y + helperTextLabel.height + Units.dp(4)
                                  : underline.y + Units.dp(8)
    implicitWidth: spinBoxContents.implicitWidth

    activeFocusOnTab: true

    property color accentColor: Theme.accentColor
    property color errorColor: "#F44336"

    property alias model: listView.model

    property string textRole

    readonly property string selectedText: (listView.currentItem) ? listView.currentItem.text : ""

    property alias selectedIndex: listView.currentIndex
    property int maxVisibleItems: 4

    property alias placeholderText: fieldPlaceholder.text
    property alias helperText: helperTextLabel.text

    property bool floatingLabel: false
    property bool hasError: false
    property bool hasHelperText: helperText.length > 0

    readonly property rect inputRect: Qt.rect(spinBox.x, spinBox.y, spinBox.width, spinBox.height)

    signal itemSelected(int index)

    Ink {
        anchors.fill: parent
        onClicked: {
            listView.positionViewAtIndex(listView.currentIndex, ListView.Center)
            var offset = listView.currentItem.itemLabel.mapToItem(menu, 0, 0)
            menu.open(label, 0, -offset.y)
        }
    }

    Item {
        id: spinBox

        height: Units.dp(24)
        width: parent.width

        y: {
            if(!floatingLabel)
                return Units.dp(16)
            if(floatingLabel && !hasHelperText)
                return Units.dp(40)
            return Units.dp(28)
        }

        RowLayout {
            id: spinBoxContents

            height: parent.height
            width: parent.width + Units.dp(5)

            Label {
                id: label

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter

                text: (listView.currentItem) ? listView.currentItem.text : ""
                style: "subheading"
                elide: Text.ElideRight
            }

            Icon {
                id: dropDownIcon

                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                Layout.preferredWidth: Units.dp(24)
                Layout.preferredHeight: Units.dp(24)

                name: "navigation/arrow_drop_down"
                size: Units.dp(24)
            }
        }

        Dropdown {
            id: menu

            anchor: Item.TopLeft

            width: spinBox.width

            //If there are more than max items, show an extra half item so
            // it's clear the user can scroll
            height: Math.min(maxVisibleItems*Units.dp(48) + Units.dp(24), listView.contentHeight)

            ListView {
                id: listView

                width: menu.width
                height: count > 0 ? menu.height : 0

                interactive: true

                delegate: Standard {
                    id: delegateItem

                    text: textRole ? model[textRole] : modelData

                    onClicked: {
                        itemSelected(index)
                        listView.currentIndex = index
                        menu.close()
                    }
                }
            }

            Scrollbar {
                flickableItem: listView
            }
        }
    }

    Label {
        id: fieldPlaceholder

        text: field.placeholderText
        visible: floatingLabel

        font.pixelSize: Units.dp(12)

        anchors.bottom: spinBox.top
        anchors.bottomMargin: Units.dp(8)

        color: Theme.light.hintColor
    }

    Rectangle {
        id: underline

        color: field.hasError ? field.errorColor : field.activeFocus ? field.accentColor : Theme.light.hintColor

        height: field.activeFocus ? Units.dp(2) : Units.dp(1)

        anchors {
            left: parent.left
            right: parent.right
            top: spinBox.bottom
            topMargin: Units.dp(8)
        }

        Behavior on height {
            NumberAnimation { duration: 200 }
        }

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }

    Label {
        id: helperTextLabel

        anchors {
            left: parent.left
            right: parent.right
            top: underline.top
            topMargin: Units.dp(4)
        }

        visible: hasHelperText
        font.pixelSize: Units.dp(12)
        color: field.hasError ? field.errorColor : Qt.darker(Theme.light.hintColor)

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
}
