import QtQuick 2.2
import Material 0.1

NGApplicationWindow {
    id: win

    height: 400
    width: 400

    initialItem: firstPage

    NGPage {
        id: firstPage
        title: "Test Page"
        actions: [
            Action {
                name: "blaz"
                iconName: "social/cake"
            },
            Action {
                name: "slopz"
                iconName: "social/location_city"
            }
        ]

        Rectangle {
            anchors.fill: parent
            Column {
                spacing: units.dp(10)
                anchors.centerIn: parent
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: i18n.tr("Demo!")
                }

                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Open sub page!"
                    elevation: 1
                    onTriggered: firstPage.push( Qt.createComponent("SubPage.qml") );
                }
            }
        }

        Component.onCompleted: win.show()
    }
}
