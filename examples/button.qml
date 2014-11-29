import QtQuick 2.0
import Material 0.1 as Material

Rectangle {
    height: 400
    width: 400
    Grid {
        anchors.fill: parent
        rows: 3
        columns: 3

        Material.Button {
            id: button1
            text: "Button 1"
            isDefault: true
        }
        Material.Button {
            id: button2
            text: "Button 2"
            checkable: true
        }
        Material.Button {
            id: button3
            text: "Button 3"
        }
        Material.Button {
            id: button4
            text: "Button 4"
        }
        Material.Button {
            id: button5
            text: "Button 5"
        }
        Material.Button {
            id: button6
            text: "Button 6"
        }
    }
}
