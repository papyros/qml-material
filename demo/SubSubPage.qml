import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem

NGPage {
    id: page

    property string coolness: ''
    title: "Sub Sub Page"

    actions: [
        Action {
            name: "blaz"
            iconName: "social/cake"
        },
        Action {
            name: "blaz"
            iconName: "social/cake"
        },
        Action {
            name: "blaz"
            iconName: "social/cake"
        },
        Action {
            name: "blaz"
            iconName: "social/cake"
        },
        Action {
            name: "blaz"
            iconName: "social/cake"
        },
        Action {
            name: "blaz"
            iconName: "social/cake"
        },
        Action {
            name: "blaz"
            iconName: "social/cake"
        },
        Action {
            name: "blaz"
            iconName: "social/cake"
        }

    ]
    Rectangle {
        ListView {
            id: list
            model: 3
            delegate: ListItem.Standard {
                text: "List Item #" + modelData
            }
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: button.top
            }
        }
        Button {
            id: button
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            text: page.coolness
            elevation: 1
            onTriggered: page.push( Qt.createComponent("SubPage.qml") );
        }
    }
}


