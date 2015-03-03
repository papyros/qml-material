import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.1

Item {
    implicitHeight: grid.implicitHeight + units.dp(40)
    GridLayout {
        id: grid
        anchors.centerIn: parent
        columns: 2
        columnSpacing: units.dp(20)
        rowSpacing: units.dp(20)

        Label {
            text: "Determinate"
        }

        ProgressBar {
            Layout.fillWidth: true
            color: theme.accentColor

            SequentialAnimation on value {
                running: true
                loops: NumberAnimation.Infinite

                NumberAnimation {
                    duration: 3000
                    from: 0
                    to: 1
                }

                PauseAnimation { duration: 1000 } // This puts a bit of time between the loop
            }
        }

        Label {
            text: "Indeterminate"
        }

        ProgressBar {
            Layout.fillWidth: true
            color: theme.accentColor
            indeterminate: true
        }
    }
}
