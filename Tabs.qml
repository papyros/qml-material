import QtQuick 2.0

Row {
    id: tabbar

    property var tabs: []

    height: units.dp(48)

    property int selectedIndex: 0

    property color color: theme.blackColor("text")
    property color highlight: theme.blackColor("text")

    Repeater {
        id: repeater
        model: tabbar.tabs

        delegate: View {
            id: tabItem
            width:units.dp(48) + row.width
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

                height: units.dp(2)
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
                spacing: units.dp(10)

                Icon {
                    anchors.verticalCenter: parent.verticalCenter
                    name: modelData.hasOwnProperty("icon") ? modelData.icon : ""
                    color: "white"
                    visible: name != ""
                }

                Label {
                    id: label
                    text: modelData.hasOwnProperty("text") ? modelData.text : ""
                    color: tabbar.color
                    fontStyle: "body2"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
