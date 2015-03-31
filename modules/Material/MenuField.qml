import QtQuick 2.2
import QtQuick.Layouts 1.1

import Material 0.1
import Material.ListItems 0.1


Item {
    id: field

    implicitHeight: hasHelperText ? helperTextLabel.y + helperTextLabel.height + Units.dp(4)
                                  : underline.y + Units.dp(8)
    implicitWidth: spinBoxContents.implicitWidth

    activeFocusOnTab: true

    property color accentColor: Theme.accentColor
    property color errorColor: "#F44336"

    property alias model: listView.model
    readonly property string selectedText: listView.currentItem.text
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

                text: listView.currentItem.text
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
            height: Math.min(maxVisibleItems*Units.dp(48) + Units.dp(24), listView.height)

            ListView {
                id: listView

                width: menu.width
                height: count > 0 ? contentHeight : 0

                interactive: true

                delegate: Standard {
                    id: delegateItem

                    text: modelData

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
