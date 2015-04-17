import QtQuick 2.0
import Material 0.1

Item {

	property var styles: [
		"display4",
        "display3",
        "display2",
        "display1",
        "headline",
        "title",
        "subheading",
        "body2",
        "body1",
        "caption",
        "button"
	]

	Flickable {
		id: flickable

		anchors.fill: parent

		contentWidth: column.width + 2 * column.anchors.margins
		contentHeight: column.height

		topMargin: units.dp(20)
		bottomMargin: units.dp(20)

		Column {
			id: column
	        spacing: units.dp(20)

	        anchors {
	        	left: parent.left
	        	margins: units.dp(20)
	        }

	        Repeater {
	        	model: styles
	        	delegate: Row {
					Label {
		        		text: modelData
		        		width: units.dp(100)
		        	}

	        		Label {
		        		style: modelData
		        		text: {
		        			var text = fontInfo["font"].substring(0,1).toUpperCase() + fontInfo["font"].substring(1)

		        			if (style == "button")
		        				text += " (ALL CAPS)"

		        			text += " " + fontInfo["size"] + "sp"

		        			if (fontInfo.size_desktop) {
		        				text += " (Device), " + fontInfo["font"].substring(0,1).toUpperCase() + fontInfo["font"].substring(1)

			        			if (style == "button")
			        				text += " (ALL CAPS)"

			        			text += " " + fontInfo["size_desktop"] + "sp (Desktop)"
		        			}

		        			return text
		        		}
		        	}
		        }
	        }
	    }
	}
	
	Scrollbar {
		flickableItem: flickable
	}
}