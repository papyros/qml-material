import QtQuick 2.0

Dialog {

    height: timePicker.height + buttonHeight
    contentMargins: 0
    showHeaderView: false

    property alias timePickerTime: timePicker.timePicked
    signal timePicked(date timePicked)

    TimePicker {
        id: timePicker
    }

    onAccepted: {
        timePicked(timePickerTime)
        console.log(timePickerTime.hours + " " +  timePickerTime.minutes)
        timePicker.reset()
    }

    onRejected: {
        timePicker.reset()
    }
}

