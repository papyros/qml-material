import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.1

Item {

    Column {
        anchors.centerIn: parent
        spacing: units.dp(20)

        Repeater {
            model: 2

            Rectangle {
                color: index == 0 ? "#EEE" : "#333"
                width: grid.implicitWidth + units.dp(100)
                height: grid.implicitHeight + units.dp(100)
                radius: units.dp(2)

                GridLayout {
                    id: grid
                    anchors.centerIn: parent
                    columns: 3

                    // Empty filler
                    Item { width: 1; height: 1 }

                    Label {
                        Layout.alignment : Qt.AlignHCenter
                        text: "Normal"
                        color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                    }

                    Label {
                        Layout.alignment : Qt.AlignHCenter
                        text: "Disabled"
                        color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                    }

                    Label {
                        text: "On"
                        color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                    }

                    Checkbox {
                        checked: true
                        text: "On"
                        darkBackground: index == 1
                    }

                    Checkbox {
                        checked: true
                        enabled: false
                        text: "Disabled"
                        darkBackground: index == 1
                    }

                    Label {
                        text: "Off"
                        color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                    }

                    Checkbox {
                        text: "Off"
                        darkBackground: index == 1
                    }

                    Checkbox {
                        text: "Disabled"
                        enabled: false
                        darkBackground: index == 1
                    }
                }
            }
        }
    }
}
