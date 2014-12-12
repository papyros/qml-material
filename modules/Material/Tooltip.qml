import QtQuick 2.0

Card {
	id: tooltip
	radius: units.dp(2)
	backgroundColor: "#888"
	elevation: 1
	opacity: 0
	height: label.height + units.dp(8)
	width: label.width + units.dp(16)
	property bool opened
	property string text

	function open() {
		opened = true;
	}

	function close() {
		opened = false;
	}

	Label {
		id: label
		font.pointSize: 10
		anchors.centerIn: parent
		text: tooltip.text
		color: "white"
	}

	states: State {
		when: opened
		name: "opened"
		PropertyChanges {
			target: tooltip
			opacity: 0.9
		}
	}
	transitions: Transition {
		from: ""
		to: "opened"
		reversible: true
		NumberAnimation {
			property: "opacity"
		}
	}
}
