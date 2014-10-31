import QtQuick 2.0

View {
    id: toolbar

    implicitHeight: device.mode == "mobile" ? units.dp(48)
                                            : device.mode == "tablet" ? units.dp(56)
                                                                      : units.dp(64)
    height: implicitHeight + (tabs.length > 0 ? tabbar.height : 0)

    anchors {
        left: parent.left
        right: parent.right
    }

    elevation: 2
    fullWidth: true

    property string color: "white"

    property alias title: label.text

    property alias tabs: tabbar.tabs
    property alias selectedTab: tabbar.selectedIndex

    property NavigationDrawer drawer

    property list<Action> actions

    property int maxActionCount: (device.mode == "desktop"
                                  ? 5 : device.mode.tablet ? 4 : 3) - (drawer ? 1 : 0)

    Item {
        id: actionBar

        width: parent.width
        height: parent.implicitHeight

        IconAction {
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: units.dp(16)
            }

            name: "navigation/menu"
            color: toolbar.color
            size: units.dp(27)
            visible: drawer

            onTriggered: drawer.open()
        }

        Row {
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: units.dp(16)
            }

            spacing: units.dp(24)

            Repeater {
                model: actions.length > maxActionCount ? maxActionCount - 1 : actions.length

                delegate: IconAction {
                    property Action action: actions[index]

                    name: action.iconName
                    color: toolbar.color
                    size: name == "content/add" ? units.dp(30) : units.dp(27)
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            IconAction {
                name: "navigation/more_vert"
                color: toolbar.color
                size: units.dp(27)
                visible: actions.length > maxActionCount
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Label {
            id: label

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: drawer ? units.dp(72) : units.dp(16)
            }

            fontStyle: "title"
            color: toolbar.color
        }
    }

    Tabs {
        id: tabbar
        anchors {
            top: actionBar.bottom
        }
        color: toolbar.color
        highlight: theme.secondary
    }
}
