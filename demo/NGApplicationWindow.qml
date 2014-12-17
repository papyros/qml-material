import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import QtQuick.Window 2.0 as Windows
import Material 0.1

Controls.ApplicationWindow {
    id: mainWin

    property alias initialItem: __pageStack.initialItem

    toolBar: NGToolbar {
        id: __toolbar
        width: parent.width
        backgroundColor: Theme.primaryDarkColor
    }

    NGPageStack {
        id: __pageStack
        anchors.fill: parent;
        onPushed: __toolbar.push( page )
        onPopped: __toolbar.pop(  )
    }

}

