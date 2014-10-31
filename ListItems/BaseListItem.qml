import QtQuick 2.0
import ".."

View {
    anchors {
        left: parent.left
        right: parent.right
    }

    property int margins: units.dp(16)

    property int dividerInset: 0
    property bool showDivider: false

    ThinDivider {
        anchors.bottom: parent.bottom
        anchors.leftMargin: dividerInset

        visible: showDivider
    }
}
