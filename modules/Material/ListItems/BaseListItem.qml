import QtQuick 2.0
import ".."

View {
    id: listItem
    anchors {
        left: parent.left
        right: parent.right
    }

    property int margins: units.dp(16)

    property bool selected
    property bool interactive: true

    property int dividerInset: 0
    property bool showDivider: false

    signal clicked()
    signal pressAndHold()

    ThinDivider {
        anchors.bottom: parent.bottom
        anchors.leftMargin: dividerInset

        visible: showDivider
    }

    Ink {
        id: ink

        onClicked: listItem.clicked()
        onPressAndHold: listItem.pressAndHold()

        anchors.fill: parent

        enabled: listItem.interactive
        z: -1
    }

    tintColor: selected ? Theme.alpha("#000", 0.05)
                        : ink.containsMouse ? Theme.alpha("#000", 0.03)
                                            : "transparent"
}
