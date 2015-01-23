import QtQuick 2.0
import Material 0.1

Item {
    Column {
        anchors.centerIn: parent
        spacing: units.dp(25)

        Label {
            text: "Determinate"
        }

        ProgressBar {
            id: progressBar1
            width: units.dp(50)

            SequentialAnimation on progress {
                running: true
                loops: NumberAnimation.Infinite

                PauseAnimation { duration: 1000 } // This puts a bit of time between the loop

                NumberAnimation {
                    duration: 3000
                    from: 0
                    to: 1
                }
            }
        }
    }
}
