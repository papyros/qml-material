import QtQuick 2.0
import Material 0.1

Item {

    Column {
        anchors.centerIn: parent
        spacing: units.dp(20)

        Repeater {
            model: 2

            Rectangle {
                color: index == 0 ? "#EEE" : "#333"
                width: grid.implicitWidth + units.dp(50)
                height: grid.implicitHeight + units.dp(50)
                radius: units.dp(2)

                Grid {
                    id: grid
                    anchors.centerIn: parent
                    spacing: units.dp(40)
                    columns: 3

                    // Empty filler
                    Item { width: 1; height: 1 }

                    Label {
                        text: "Normal"
                        color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                    }

                    Label {
                        text: "Disabled"
                        color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                    }

                    Label {
                        text: "On"
                        color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                    }

                    Switch {
                        checked: true
                        darkBackground: index == 1
                    }

                    Switch {
                        checked: true
                        enabled: false
                        darkBackground: index == 1
                    }

                    Label {
                        text: "Off"
                        color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                    }

                    Switch {
                        darkBackground: index == 1
                    }

                    Switch {
                        enabled: false
                        darkBackground: index == 1
                    }
                }
            }
        }
    }
}
