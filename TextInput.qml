import QtQuick 2.0
import QtQuick.Window 2.2

Item {
	property string placeholder
	property color color: theme.primary
	property string text: field.text

	function getPx (dp){
		var ppi = 25.4*Screen.pixelDensity;
		return 1.5*(dp*(ppi/160));
	}

	height: getPx(72)
	width: 200

	states: State {
		name: "focused"
		when: field.activeFocus
		PropertyChanges {
			target: fieldPlaceholder
			font.pixelSize: getPx(12)
			y: getPx(16)
		}
	}

	transitions: Transition {
		from: ""
		to: "focused"
		reversible: true
		NumberAnimation {
			properties: "y, font.pixelSize"
			duration: 150
		}
	}

	TextInput {
		id: field
		height: font.pixelSize
		width: parent.width
		font.pixelSize: getPx(16)
		y: 2*getPx(16) + getPx(8)
		color: theme.blackColor('text')
		font.family: theme.font.name
	}

	Text {
		id: fieldPlaceholder
		text: parent.placeholder
		font.pixelSize: getPx(16)
		y: field.y
		font.family: theme.font.name
		color: theme.blackColor('text')
	}

	Rectangle {
		color: parent.color
		height: getPx(4)
		width: field.width
		anchors.top: field.bottom
		anchors.topMargin: getPx(8)
	}
}
