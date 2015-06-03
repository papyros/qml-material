import QtQuick 2.0

Dialog {

    height: timePicker.height + buttonHeight
    contentMargins: 0
    showHeaderView: false

    property alias timePickerTime: timePicker.timePicked
    property alias isHours: timePicker.isHours
    signal timePicked(date timePicked)

    onShowingChanged: {
        timePicker.reset()
    }

    TimePicker {
        id: timePicker
        isHours: true
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

