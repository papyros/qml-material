import QtQuick 2.0

View {
    id: button
    height: 36
    width: Math.max(88, label.width + 32)

    radius: units.dp(2)

    property bool raised

    property string text
    property color textColor: style == 'default' ? theme.blackColor("text") : theme.styleColor(style)

    signal triggered

    tintColor: mouseArea.pressed ? Qt.rgba(0,0,0, 0.1) : "transparent"

    Ink {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            mouseArea.focused = true
            button.triggered()
        }
    }

    Label {
        id: label

        anchors.centerIn: parent
        text: button.text.toUpperCase()

        color: button.textColor

        fontStyle: "button"
    }
}
