import QtQuick 2.0
import Material 0.1

Subtitled {
    id: listItem

    property alias model: listView.model
    property alias selectedIndex: listView.currentIndex

    subText: listView.currentItem.text

    onClicked: menu.open(listItem, Units.dp(16), 0)

    Dropdown {
        id: menu

        anchor: Item.TopLeft

        width: Math.max(Units.dp(56 * 2), Math.min(listItem.width - 2 * x, listView.contentWidth))
        height: Math.min(10 * Units.dp(48) + Units.dp(16), listView.contentHeight + Units.dp(16))

        ListView {
            id: listView

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: Units.dp(8)
            }

            interactive: false
            height: count > 0 ? contentHeight : 0

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
