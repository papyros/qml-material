import QtQuick 2.0

Dialog {

    height: timePicker.height + buttonHeight
    contentMargins: 0
    showHeaderView: false

    property alias timePickerTime: timePicker.timePicked
    property alias isHours: timePicker.isHours
    signal timePicked(date timePicked)

    TimePicker {
        id: timePicker
        isHours: true
    }

    onAccepted: {
        timePicked(timePickerTime)
        timePicker.reset()
    }

    onRejected: {
        timePicker.reset()
    }
}

