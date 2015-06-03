import QtQuick 2.0
import Material 0.1


Item {

    TimePickerDialog {
        id: timePicker

        onTimePicked: {
            updateLabelForDate(timePicked)
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

        Label {
            id: timeLabel
            style: "display1"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Component.onCompleted: {
        var date = new Date(Date.now())
        updateLabelForDate(new Date(Date.now()))
    }

    function updateLabelForDate(date) {
        var hours = date.getHours()
        var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes()
        timeLabel.text = hours + ":" + minutes
    }
}
