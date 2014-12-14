import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import Material 0.1

Switch {
	id: materialSwitch
	style: SwitchStyle {
		handle: Rectangle {
			height: units.dp(30)
			width: units.dp(30)
			radius: units.dp(15)
            color: materialSwitch.checked ? "#009688"  : "#FAFAFA"
		}
		groove: Rectangle {
			width: units.dp(75)
			height: units.dp(30)
			
			Rectangle {
				width: parent.width
				anchors.centerIn: parent
				height: units.dp(15)
				radius: units.dp(7.5)
				color: materialSwitch.checked ? "#80009688"  : Qt.rgba(0, 0, 0, 0.26)
			}
		}
	}
}
