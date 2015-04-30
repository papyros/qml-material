import QtQuick 2.0
import QtQuick.Controls.Styles 1.3
import Material 0.1

RadioButtonStyle {
    spacing: 0

    label: Label {
        text: control.text
        style: "button"
        color: control.enabled ? control.darkBackground ? Theme.dark.textColor
                                                        : Theme.light.textColor
                               : control.darkBackground ? Theme.alpha("#fff", 0.30)
                                                        : Theme.alpha("#000", 0.26)
    }

    background: Rectangle {
        color: "transparent"
    }

    indicator: Rectangle {
        implicitWidth: units.dp(48)
        implicitHeight: units.dp(48)
        radius: implicitHeight / 2
        color: control.activeFocus ? Theme.alpha(control.color, 0.20) : "transparent"

        Rectangle {
            anchors.centerIn: parent
            implicitWidth: units.dp(20)
            implicitHeight: units.dp(20)
            radius: implicitHeight / 2
            color: "transparent"
            border.color: control.enabled
                ? control.checked ? control.color
                                  : control.darkBackground ? Theme.alpha("#fff", 0.70)
                                                           : Theme.alpha("#000", 0.54)
                : control.darkBackground ? Theme.alpha("#fff", 0.30)
                                         : Theme.alpha("#000", 0.26)
            border.width: units.dp(2)
            antialiasing: true

            Behavior on border.color {
                ColorAnimation { duration: 200}
            }

            Rectangle {
                anchors.centerIn: parent
                implicitWidth: control.checked ? units.dp(10) : 0
                implicitHeight: control.checked ? units.dp(10) : 0
                color: control.enabled ? control.color
                                       : control.darkBackground ? Theme.alpha("#fff", 0.30)
                                                                : Theme.alpha("#000", 0.26)
                radius: implicitHeight / 2
                antialiasing: true

                Behavior on implicitWidth {
                    NumberAnimation { duration: 200 }
                }

                Behavior on implicitHeight {
                    NumberAnimation { duration: 200 }
                }
            }
        }
    }
}
