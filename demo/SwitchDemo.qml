import QtQuick 2.0
import Material 0.1

Item {

    Grid {
        anchors.centerIn: parent
        spacing: units.dp(40)
        columns: 3

        // Empty filler
        Item { width: 1; height: 1 }

        Label {
            text: "Normal"
        }

        Label {
            text: "Disabled"
        }

        Label {
            text: "On"
        }

        Switch {
            checked: true
        }

        Switch {
            checked: true
            enabled: false
        }

        Label {
            text: "Off"
        }

        Switch {
        }

        Switch {
            enabled: false
        }
    }
}
