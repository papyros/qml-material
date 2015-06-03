import QtQuick 2.0
import Material 0.1


Item {

    TimePickerDialog {
        id: timePicker

        onTimePicked: {
            console.log(timePickerTime)
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: Units.dp(20)

        Button {
            text: "Show Action Dialog"
            anchors.horizontalCenter: parent.horizontalCenter
            elevation: 1
            onClicked: {
                timePicker.show()
            }
        }
    }
}
