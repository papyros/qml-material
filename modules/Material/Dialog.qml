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

	width: view.parent.width/2 >= minWidth ? view.parent.width/2 : minWidth
	height: {
        if (mainCol.height <= maxHeight && mainCol.height >= minHeight) {
            return mainCol.height;
        } else if (mainCol.height < minHeight) {
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
		}

		Button {
			id: positiveBtn

			text: positiveBtnText
			anchors {
				verticalCenter: parent.verticalCenter
				right: parent.right
				rightMargin: units.dp(16)
			}
		}
	}

    Scrollbar {
        flickableItem: mainFlick
    }
}
