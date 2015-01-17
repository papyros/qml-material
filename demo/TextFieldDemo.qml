import QtQuick 2.0
import Material 0.1

Item {

    Column {
        anchors.centerIn: parent
        spacing: units.dp(20)

        TextField {
            text: "Text Field with text"
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
            placeholderText: "Floating placeholder label"
            floatingLabel: true

            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
