/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer
 * Copyright (C) 2015 Bogdan Cuza <bogdan.cuza@hotmail.com>
 * Copyright (C) 2015 Mikhail Ivchenko <ematirov@gmail.com>
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
	id: view

	default property alias contents: mainCol.children
	property string negativeBtnText: "CANCEL"
	property string positiveBtnText: "OK"
	property real minWidth: negativeBtn.width + positiveBtn.width + units.dp(124) //min 100dp padding
	property real maxHeight: view.parent.height/2
        property real minHeight: units.dp(96) + titleLabel.height
	property string title

	signal accepted()
	signal rejected()

	function open() {
		visible = true;
	}

	function close() {
		visible = false;
	}

	width: view.parent.width/2 >= minWidth ? view.parent.width/2 : minWidth
	height: {
        	if (units.dp(96) + mainCol.height <= maxHeight && units.dp(96) + mainCol.height >= minHeight) {
            		return units.dp(96) + mainCol.height;
        	} else if (units.dp(96) + mainCol.height < minHeight) {
            		return minHeight;
        	} else {
            		return maxHeight;
        	}
    	}
	elevation: 5
	anchors.centerIn: parent

	Flickable {
        id: mainFlick

		anchors {
			top: parent.top
			left: parent.left
			bottom: btnContainer.top
			right: parent.right
			rightMargin: units.dp(24)
			topMargin: units.dp(24)
			leftMargin: units.dp(24)
			bottomMargin: units.dp(16)
		}
		clip: true
		interactive: contentHeight > height
		contentHeight: mainCol.height
        	contentWidth: width

		Column {
			id: mainCol

           		spacing: units.dp(5)
            		width: parent.width

			Label {
                		id: titleLabel

				style: "title"
                		width: parent.width
				text: view.title
                		wrapMode: Text.Wrap
			}
		}
	}

	Item {
		id: btnContainer

		width: parent.width
		height: units.dp(48)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: units.dp(8)

		Button {
			id: negativeBtn

			text: view.negativeBtnText
			anchors {
				verticalCenter: parent.verticalCenter
				right: positiveBtn.left
				rightMargin: units.dp(8)
			}
			onClicked: {
				view.close();
				view.rejected();
			}
		}

		Button {
			id: positiveBtn

			text: positiveBtnText
			anchors {
				verticalCenter: parent.verticalCenter
				right: parent.right
				rightMargin: units.dp(16)
			}
			onClicked: {
				view.close();
				view.accepted();
			}
		}
	}

	Scrollbar {
        	flickableItem: mainFlick
    	}
}
