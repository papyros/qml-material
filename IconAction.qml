import QtQuick 2.0

Icon {
    id: icon

    signal triggered

    Ink {
        id: ink

        anchors.centerIn: parent

        endSize: width * 3

        width: Math.max(parent.width, units.dp(48))
        height: Math.max(parent.height, units.dp(48))

        onClicked: {
            ink.focused = true
            icon.triggered()
        }
    }
}
