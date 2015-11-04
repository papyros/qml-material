import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1 as Controls
import Material 0.1

Item {
    implicitHeight: column.height

    ColumnLayout {
        id: column
        anchors.centerIn: parent
        spacing: Units.dp(32)

        TextField {
            text: "Big Field with text"
            font.pixelSize: Units.dp(32)
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField {
            placeholderText: "Search..."
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField {
            text: "Text under label"
            placeholderText: "Floating label"
            floatingLabel: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField {
            placeholderText: "Character limit"
            floatingLabel: true
            characterLimit: 10
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField {
            placeholderText: "Text Field with Menu"
            anchors.horizontalCenter: parent.horizontalCenter
            menu: Controls.Menu {
                Controls.MenuItem {
                    text: "Print \"awesome\""
                    onTriggered: console.log("awesome");
                }
            }
        }

        TextField {
            id: passwordField
            placeholderText: "Password"
            floatingLabel: true
            echoMode: TextInput.Password
            helperText: "Hint: It's not password."
            anchors.horizontalCenter: parent.horizontalCenter

            onAccepted: {
                if (passwordField.text === "password") {
                    passwordField.helperText = "Told ya."
                    passwordField.hasError = true
                }
            }
        }
    }
}
