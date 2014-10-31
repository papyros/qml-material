import QtQuick 2.0

View {
    width: units.dp(320)
    fullHeight: true

    objectName: "navDrawer"
    z: 15

    anchors {
        left: parent.left
        top: parent.top
        bottom: parent.bottom

        leftMargin: showing ? 0 : -width

        Behavior on leftMargin {
            NumberAnimation { duration: 200 }
        }
    }

    backgroundColor: "white"
    elevation: 3

    property bool showing

    function open() {
        showing = true
    }

    function close() {
        showing = false
    }
}
