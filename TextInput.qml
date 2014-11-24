import QtQuick 2.0

Item {
	property string placeholder
	property color color: theme.primary
	property string text: field.text

	height: units.dp(72)
	width: 200

	states: State {
		name: "focused"
		when: field.activeFocus
		PropertyChanges {
			target: fieldPlaceholder
			font.pixelSize: units.dp(12)
			y: units.dp(16)
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
		font.pixelSize: units.dp(16)
		y: 2*units.dp(16) + units.dp(8)
		color: theme.blackColor('text')
		font.family: theme.font.name
	}

	Text {
		id: fieldPlaceholder
		text: parent.placeholder
		font.pixelSize: units.dp(16)
		y: field.y
		font.family: theme.font.name
		color: theme.blackColor('text')
	}

	Rectangle {
		color: parent.color
		height: units.dp(4)
		width: field.width
		anchors.top: field.bottom
		anchors.topMargin: units.dp(8)
	}
}
