import QtQuick 2.0
import "Transitions"

Page {
    id: page
    cardStyle: true

    property alias title: label.text

    function show() {
        transition.transitionTo(page)
        card.parent = toolbar.parent
    }

    property bool showing: currentPage

    transition: SlideTransition {

    }

    default property alias content: contents.data

    Card {
        id: card
        z: 20
        anchors.horizontalCenter: parent.horizontalCenter

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

        Item {
            id: actionBar
            height: toolbar.implicitHeight - 1
            anchors {
                left: parent.left
                right: parent.right
            }

            Label {
                id: label

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: units.dp(16)

                    Behavior on leftMargin {
                        NumberAnimation { duration: 200 }
                    }
                }

                fontStyle: "title"
                color: theme.blackColor('secondary')
            }

            Row {
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: units.dp(16)
                }

                spacing: units.dp(24)

                Repeater {
                    model: actions.length > toolbar.maxActionCount ? toolbar.maxActionCount - 1 : actions.length

                    delegate: IconAction {
                        id: iconAction

                        property Action action: actions[index]

                        name: action.iconName
                        //color:
                        size: name == "content/add" ? units.dp(30) : units.dp(27)
                        anchors.verticalCenter: parent ? parent.verticalCenter : undefined

                        onTriggered: action.triggered(iconAction)
                    }
                }

                IconAction {
                    name: "navigation/more_vert"
                    size: units.dp(27)
                    visible: actions.length > toolbar.maxActionCount
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

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
}
