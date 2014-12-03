import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem
import QtQuick.Controls 1.2 as Controls
NGPage {
    id: page

    title: "Sub Page"

    property int index: Controls.Stack ? Controls.Stack.index : 0

    actions: [
        Action {
            name: "blaz"
            iconName: "social/cake"
        }
    ]
    Rectangle {
        anchors.fill: parent
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
        NGButton {
            id: button
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }


            text: "Open sub sub page!"
            elevation: 1
            onTriggered: page.push( Qt.createComponent("SubSubPage.qml"), {coolness: 'coolness %1'.arg(page.index)} );
        }
    }
}


