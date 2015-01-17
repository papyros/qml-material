import QtQuick 2.0
import Material 0.1

Item {

    Button {
        text: "Push subpage"
        elevation: 1
        anchors.centerIn: parent
        onClicked: pageStack.push(Qt.resolvedUrl("SubPage.qml"))
    }
}
