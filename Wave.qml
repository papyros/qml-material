import QtQuick 2.0

Rectangle {
	id: wave

	property real realX
	property real realY
		
	x: realX-(size/2)
	y: realY-(size/2)

	function getDiameter() {
		var topLeftCorner = Math.sqrt(Math.pow((x - 0), 2) + Math.pow((y - 0), 2));
		var topRightCorner = Math.sqrt(Math.pow((x - parent.width), 2) + Math.pow((y - 0), 2));
		var bottomLeftCorner = Math.sqrt(Math.pow((x - 0), 2) + Math.pow((y - parent.height), 2));
		var bottomRightCorner = Math.sqrt(Math.pow((x - parent.width), 2) + Math.pow((y - parent.height), 2));
		return 2*Math.max(topLeftCorner, topRightCorner, bottomLeftCorner, bottomRightCorner);
	}

	property real size: 0
	property real diameter: getDiameter()

	signal finished

	width: size
	height: size
	radius: size/2

	function run() {
		waveAnim.start();
	}

	SequentialAnimation {
		running: false
		id: waveAnim

		onRunningChanged: {
			if (!running) {
				wave.size = 0;
				wave.opacity = 1;
				wave.finished();
			}
		}

		NumberAnimation {
			target: wave
			properties: "size"
			duration: 500
			from: 0
			to: wave.diameter
			easing.type: Easing.InCubic
		}
		NumberAnimation {
			target: wave
			properties: "opacity"
			duration: 250
			from: 1
			to: 0
			easing.type: Easing.InCubic
		}
	}
}
