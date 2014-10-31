import QtQuick 2.2

ListView {
    id: tabView

    orientation: Qt.Horizontal

    highlightMoveDuration: 400
    clip: true

    snapMode: ListView.SnapOneItem
    interactive: false
}
