import QtQuick 2.0
import Material 0.1

Item {

    Column {
        anchors.centerIn: parent
        spacing: units.dp(20)

        Button {
            text: "Simple Button"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: snackbar.open("Simple, isn't it?")
        }

        Button {
            text: "Raised Button"
            elevation: 1
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: snackbar.open("This is a snackbar")
        }

        Button {
            text: "Disabled Raised Button"
            elevation: 1
            enabled: false
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: "Wide Button"

            width: units.dp(200)
            elevation: 1
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: snackbar.open("That button is too wide!")
        }

        Button {
            id: focusableButton
            text: "Focusable with really long text"
            elevation: 1
            activeFocusOnPress: true
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: snackbar.open("The text is really long")
        }

        Button {
            text: "Colored button"
            textColor: Theme.accentColor
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: snackbar.open("That button is colored!")
        }

        Button {
            text: "Focusable button #2"
            elevation: 1
            activeFocusOnPress: true
            backgroundColor: Theme.primaryColor
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: snackbar.open("That button is colored!")
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

    Snackbar {
        id: snackbar
    }
}
