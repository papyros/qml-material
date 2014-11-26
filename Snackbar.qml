import QtQuick 2.0

Card {
	radius: units.dp(2)
	backgroundColor: "#323232"
	elevation: 1
	height: units.dp(48)
	width: buttonText == "" ? snackText.paintedWidth + units.dp(48) : snackText.paintedWidth + units.dp(72) + snackButton.width
	opacity: 0
	y: parent.height - height - units.dp(5)
	x: units.dp(10)

	property string buttonText
	property string text
	property bool opened
	property int duration: 2000

	signal click
	signal dissapear

	id: snackbar

	function open() {
		opened = true;
		timer.start();
	}

	states: State {
		name: "opened"
		when: opened
		PropertyChanges {
			target: snackbar
			opacity: 1
			y: snackbar.parent.height -snackbar.height - units.dp(10)
		}
	}

	transitions: Transition {
		from: ""
		to: "opened"
		reversible: true
		NumberAnimation {
			properties: "opacity, y"
			easing.type: Easing.InCubic
			duration: 300
		}
	}

	Timer {
		interval: snackbar.duration
		id: timer
		onTriggered: {
			if (!running) {
				snackbar.dissapear();
				snackbar.opened = false;
			}
		}
	}

	Label {
		id: snackText
		anchors {
			right: snackbar.buttonText == "" ? parent.right : snackButton.left
			left: parent.left
			top: parent.top
			bottom: parent.bottom
			leftMargin: units.dp(24)
			topMargin: units.dp(16)
			rightMargin: units.dp(24)
		}
		text: snackbar.text
		color: "white"
	}

	Button {
		id: snackButton
		opacity: snackbar.buttonText == "" ? 0 : 1
		textColor: "white"
		raised: false
		text: snackbar.buttonText
		onTriggered: snackbar.click()
		anchors {
			right: parent.right
			//left: snackText.right
			top: parent.top
			bottom: parent.bottom
			topMargin: units.dp(16)
			bottomMargin: units.dp(16)
			rightMargin: snackbar.buttonText == "" ? 0 : units.dp(24)
		}

		/*Label {
			style: "button"
			anchors.centerIn: parent
			text: buttonText
		}*/
	}

}
