import QtQuick 2.0

Dialog {

    height: timePicker.height + buttonHeight
    contentMargins: 0
    showHeaderView: false

    property alias isHours: timePicker.isHours
    property alias prefer24Hour: timePicker.prefer24Hour
    signal timePicked(date timePicked)

    TimePicker {
        id: timePicker
        isHours: true
    }

    onAccepted: {
        timePicked(timePicker.getCurrentTime())
        timePicker.reset()
    }

    onRejected: {
        timePicker.reset()
    }
}

