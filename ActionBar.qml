import QtQuick 2.0

Item {
    id: actionBar

    implicitHeight: device.mode === "mobile"
                    ? units.dp(48) : device.mode == "tablet"
                      ? units.dp(56) : units.dp(64)

    anchors {
        left: parent.left
        right: parent.right
    }

    property string color: "white"

    property Item page

    property int maxActionCount: toolbar.maxActionCount

    property bool showContents: !page.cardStyle

    property color background: theme.primary

    IconAction {
        id: leftItem

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: leftItem.show ? units.dp(16) : -leftItem.width

            Behavior on leftMargin {
                NumberAnimation { duration: 200 }
            }
        }

        color: actionBar.color
        size: units.dp(27)
        name: page.backAction ? page.backAction.iconName : ""

        onTriggered: page.backAction.triggered(leftItem)

        opacity: show ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        property bool show: (page.backAction && page.backAction.visible) &&
                            (!page.cardStyle || !showContents)
    }

    Label {
        id: label

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: leftItem.show ? units.dp(72) : units.dp(16)

            Behavior on leftMargin {
                NumberAnimation { duration: 200 }
            }
        }

        text: showContents ? page.title : ""
        fontStyle: "title"
        color: actionBar.color
    }

    Row {
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: units.dp(16)
        }

        spacing: units.dp(24)

        Repeater {
            model: !showContents ? []
                                : page.actions.length > maxActionCount
                                  ? maxActionCount - 1 : actions.length

            delegate: IconAction {
                id: iconAction

                property Action action: page.actions[index]

                name: action.iconName
                color: actionBar.color
                size: name == "content/add" ? units.dp(30) : units.dp(27)
                anchors.verticalCenter: parent ? parent.verticalCenter : undefined

                onTriggered: action.triggered(iconAction)
            }
        }

        IconAction {
            name: "navigation/more_vert"
            size: units.dp(27)
            color: actionBar.color
            visible: showContents && page.actions.length > maxActionCount
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}

