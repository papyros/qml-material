import QtQuick 2.0
import Material 0.1

Item {

    Column {
        anchors.centerIn: parent
        spacing: units.dp(20)

        Button {
            text: "Simple Button"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: "Raised Button"
            elevation: 1
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: "Wide Button"

            width: units.dp(200)
            elevation: 1
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: "Button with really long text"
            elevation: 1
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: "Colored button"
            textColor: Theme.accentColor
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    ActionButton {
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: units.dp(32)
        }

        iconName: "content/add"
    }
}
