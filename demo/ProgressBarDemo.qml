import QtQuick 2.0
import Material 0.1

Item {
    Column {
        anchors.centerIn: parent
        spacing: units.dp(25)

        Label {
            text: "Determinate"
            horizontalAlignment: Text.AlignHCenter
        }

        ProgressBar {
            id: progressBar1
            width: 200
            height: 2
            /* If needed, you can set a custom color :
            color: "red"
            */


            SequentialAnimation {
                running: true
                loops: NumberAnimation.Infinite

                PauseAnimation { duration: 1000 } // This puts a bit of time between the loop

                NumberAnimation {
                    target: progressBar1
                    property: "progress"
                    duration: 3000
                    from: 0
                    to: 1
                }
            }
        }
    }
}
