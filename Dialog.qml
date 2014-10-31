import QtQuick 2.2

View {
    width: 270
    height: 300
    elevation: 5

    property string title

    Label {
        text: title

        fontStyle: "title"

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: units.dp(24)
        }
    }

    Button {
        anchors {
            right: acceptButton.left
            bottom: parent.bottom
            bottomMargin: units.dp(16)
        }

        text: "CANCEL"
    }

    Button {
        id: acceptButton

        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: units.dp(16)
        }

        style: "primary"
        text: "ACCEPT"
    }
}
