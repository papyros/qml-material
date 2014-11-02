import QtQuick 2.0
import ".."

Item {
    id: trans
    anchors.fill: parent

    Component.onCompleted: parent = pageStack

    default property alias content: background.children

    property Item page

    property int targetHeight

    property bool showing

    Rectangle {
        id: background
        parent: toolbar.parent
        z: 5

        y: toolbar.height
        width: trans.width
        height: trans.height
        opacity: showing ? 1 : 0

        color: theme.defaultBackground

        Behavior on opacity {
            NumberAnimation { duration: animations.pageTransition }
        }
    }

    Card {
        id: card
        z: 20
        anchors.horizontalCenter: parent.horizontalCenter
        parent: toolbar.parent

        y: showing ? toolbar.implicitHeight : parent.height
        height: pageStack.height + toolbar.implicitHeight
        width: parent.width * 3/4
        opacity: showing ? 1 : 0

        Behavior on y {
            NumberAnimation { duration: animations.pageTransition }
        }

        Behavior on opacity {
            NumberAnimation { duration: animations.pageTransition }
        }

        ActionBar {
            id: actionBar
            page: trans.page
            showContents: true
            height: implicitHeight - 1
            color: "gray"

            Rectangle {
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                height: 1
                color: theme.blackColor('divider')
            }
        }

        Item {
            id: contents

            anchors {
                left: parent.left
                right: parent.right
                top: actionBar.bottom
                bottom: parent.bottom
            }
        }
    }
    function transitionTo(page, args) {
        print("Transitioning...")

        trans.page = page

        page.color = "transparent"
        page.cardStyle = true
        page.parent = contents
        page.visible = true

        targetHeight = toolbar.parent.height

        trans.z = pageStack.count

        showing = true
    }

    function transitionBack() {
        print("Transition back...")
        showing = false
    }
}
