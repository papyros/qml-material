import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import QtQuick.Controls.Styles 1.2 as ControlStyles

import Material 0.1

Controls.Switch {
    id: control

    /*!
       The switch color. By default this is the app's accent color
     */
    property color color: darkBackground ? Theme.dark.accentColor : Theme.light.accentColor

    /*!
       Set to \c true if the switch is on a dark background
     */
    property bool darkBackground

    style: ControlStyles.SwitchStyle {
        handle: View {
            width: units.dp(22)
            height: units.dp(22)
            radius: height / 2
            elevation: 2
            backgroundColor: control.enabled ? control.checked ? control.color
                                                               : darkBackground ? "#BDBDBD"
                                                                                : "#FAFAFA"
                                             : darkBackground ? "#424242"
                                                              : "#BDBDBD"
        }

        groove: Item {
            width: units.dp(40)
            height: units.dp(22)

            Rectangle {
                anchors.centerIn: parent
                width: parent.width - units.dp(2)
                height: units.dp(16)
                radius: height / 2
                color: control.enabled ? control.checked ? Theme.alpha(control.color, 0.5)
                                                         : darkBackground ? Theme.alpha("#FFF", 0.30)
                                                                          : Theme.alpha("#000", 0.26)
                                       : darkBackground ? Theme.alpha("#FFF", 0.10)
                                                        : Theme.alpha("#000", 0.12)

                Behavior on color {

                    ColorAnimation {
                        duration: 200
                    }
                }
            }
        }
    }
}
