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

    property int dividerInset: 0
    property bool showDivider: false

    signal triggered()

    ThinDivider {
        anchors.bottom: parent.bottom
        anchors.leftMargin: dividerInset

        visible: showDivider
    }

    Ink {
        id: ink
        onClicked: listItem.triggered()
        anchors.fill: parent
    }

    tintColor: selected ? Qt.rgba(0,0,0,0.07) : ink.containsMouse ? Qt.rgba(0,0,0,0.03) : Qt.rgba(0,0,0,0)
}
