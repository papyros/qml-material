import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import QtQuick.Controls.Styles 1.2 as ControlStyles

import Material 0.1

Controls.Switch {
    id: switchView

    property color color: Theme.accentColor

    style: ControlStyles.SwitchStyle {
        handle: View {
            width: units.dp(22)
            height: units.dp(22)

            radius: height/2

            elevation: 2
            backgroundColor: switchView.enabled ? switchView.checked ? switchView.color  : "#FAFAFA"
                                                : "#BDBDBD"
		}

        groove: Item {
            width: units.dp(40)
            height: units.dp(22)
			
			Rectangle {

				anchors.centerIn: parent

                width: parent.width - units.dp(2)
                height: units.dp(16)

                radius: height/2

                color: switchView.enabled ? switchView.checked ? Theme.alpha(switchView.color, 0.5)
                                                               : Qt.rgba(0, 0, 0, 0.26)
                                          : Qt.rgba(0, 0, 0, 0.12)

                Behavior on color {

                    ColorAnimation {
                        duration: 200
                    }
                }
			}
		}
	}
}
