import QtQuick 2.0
import Material 0.1
import Material.Extras 0.1

Subtitled {
    id: listItem

    property var model
    property alias selectedIndex: listView.currentIndex

    subText: listView.currentItem.text

    onClicked: menu.open(listItem, units.dp(16), 0)

    Label {
        id: hiddenLabel
        style: "subheading"
        visible: false
    }

    property int columnWidth: {
        var maxWidth = 0

        for (var i = 0; i < model.length; i++) {
            hiddenLabel.text = model[i]
            
            maxWidth = Math.max(maxWidth, hiddenLabel.implicitWidth + units.dp(33))
        }

        return maxWidth
    }

    Dropdown {
        id: menu

        anchor: Item.TopLeft

        width: Math.max(units.dp(56 * 2), Math.min(listItem.width - units.dp(32), columnWidth))
        height: Math.min(10 * units.dp(48) + units.dp(16), model.length * units.dp(48) + units.dp(16))

        Rectangle {
            anchors.fill: parent
            radius: units.dp(2)
        }

        ListView {
            id: listView

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: units.dp(8)
            }

            interactive: false
            height: contentHeight
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
