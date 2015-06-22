import QtQuick 2.0
import Material 0.1

Item {

    Column {
        anchors.centerIn: parent
        spacing: Units.dp(20)

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

            width: Units.dp(200)
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

            onClicked: snackbar.open("The text is really very very very long")
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

    MenuActionButton {
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: Units.dp(32)
        }

        iconName: "content/add"
        actions: [
            Action {
                iconName: "action/alarm"
                backgroundColor: Palette.colors['blue']['500']
            },
            Action {
                iconName: "action/alarm"
                backgroundColor: Palette.colors['blue']['500']
            },
            Action {
                iconName: "action/alarm"
                backgroundColor: Palette.colors['blue']['500']
            },
            Action {
                iconName: "action/alarm"
                backgroundColor: Palette.colors['blue']['500']
            },
            Action {
                iconName: "action/alarm"
                backgroundColor: Palette.colors['blue']['500']
            },
            Action {
                iconName: "action/alarm"
                backgroundColor: Palette.colors['blue']['500']
            }
        ]
    }

    Snackbar {
        id: snackbar
    }
}
