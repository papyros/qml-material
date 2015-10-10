import QtQuick 2.4
import Material 0.1

Dialog {
    contentMargins: 0
    hasActions: true
    floatingActions: true

    property alias isHours: timePicker.isHours
    property alias prefer24Hour: timePicker.prefer24Hour
    signal timePicked(date timePicked)

    TimePicker {
        id: timePicker
        isHours: true
        bottomMargin: Units.dp(48)
    }

    onAccepted: {
        timePicked(timePicker.getCurrentTime())
        timePicker.reset()
    }

    onRejected: {
        timePicker.reset()
    }
}

