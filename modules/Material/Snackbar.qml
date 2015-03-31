/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Bogdan Cuza <bogdan.cuza@hotmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0
import Material 0.1

View {
	id: snackbar

	radius: fullWidth ? 0 : Units.dp(2)
	backgroundColor: "#323232"
	height: Units.dp(48)
	width: fullWidth ? parent.width : Math.min(implicitWidth, Units.dp(568))
	opacity: opened ? 1 : 0

	implicitWidth: buttonText == "" ? snackText.paintedWidth + Units.dp(48) : snackText.paintedWidth + Units.dp(72) + snackButton.width

	property bool fullWidth: Device.type === Device.phone

	anchors {
		left: parent.left
		right: fullWidth ? parent.right : undefined
		bottom: parent.bottom
		leftMargin: fullWidth ? 0 : Units.dp(16)
		bottomMargin: opened ? fullWidth ? 0 : Units.dp(16) :  -snackbar.height

		Behavior on bottomMargin {
			NumberAnimation { duration: 300 }
		}
	}

	Behavior on opacity {
		NumberAnimation { duration: 300 }
	}

	property string buttonText
	property string text
	property bool opened
	property int duration: 2000

	signal clicked

	function open(text) {
		snackbar.text = text
		opened = true;
		timer.start();
	}

	Timer {
		id: timer

		interval: snackbar.duration

		onTriggered: {
			if (!running) {
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
			leftMargin: Units.dp(24)
			topMargin: Units.dp(16)
			rightMargin: Units.dp(24)
		}
		text: snackbar.text
		color: "white"
	}

	Button {
		id: snackButton
		opacity: snackbar.buttonText == "" ? 0 : 1
		textColor: "white"
		text: snackbar.buttonText
		onClicked: snackbar.clicked()
		anchors {
			right: parent.right
			//left: snackText.right
			top: parent.top
			bottom: parent.bottom
			topMargin: Units.dp(16)
			bottomMargin: Units.dp(16)
			rightMargin: snackbar.buttonText == "" ? 0 : Units.dp(24)
		}
	}

}
