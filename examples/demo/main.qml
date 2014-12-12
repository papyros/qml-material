import QtQuick 2.2
import Material 0.1

ApplicationWindow {
    initialPage: page

    Page {
        id: page

        title: "Test Page"

        Column {
            anchors.centerIn: parent
            spacing: units.dp(10)

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: i18n.tr("Demo!")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Open sub page!"
                onClicked: pageStack.push(Qt.resolvedUrl("SubPage.qml"))
            }
        }
    }
}
