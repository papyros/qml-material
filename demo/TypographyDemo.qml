import QtQuick 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem

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

		contentWidth: column.width + units.dp(16)
		contentHeight: column.height

		topMargin: units.dp(16)
		bottomMargin: units.dp(16)

		Column {
			id: column
	        spacing: units.dp(16)

	        ListItem.Header {
	        	text: "Font Weights"
	        }

	        Label {
	        	font.family: "Roboto"
			    font.weight: Font.Light
			    text: "Roboto Light"
			    font.pixelSize: units.dp(34)

			    anchors {
		        	left: parent.left
		        	margins: units.dp(16)
		        }
	        }

	        Label {
	        	font.family: "Roboto"
			    text: "Roboto Regular"
			    font.pixelSize: units.dp(34)

			    anchors {
		        	left: parent.left
		        	margins: units.dp(16)
		        }
	        }

	        Label {
	        	font.family: "Roboto"
			    font.weight: Font.DemiBold
			    text: "Roboto Medium"
			    font.pixelSize: units.dp(34)

			    anchors {
		        	left: parent.left
		        	margins: units.dp(16)
		        }
	        }

	        Label {
	        	font.family: "Roboto"
			    font.weight: Font.Bold
			    text: "Roboto Bold"
			    font.pixelSize: units.dp(34)

			    anchors {
		        	left: parent.left
		        	margins: units.dp(16)
		        }
	        }

	        ListItem.Header {
	        	text: "Label Styles"
	        }

	        Repeater {
	        	model: styles
	        	delegate: Row {
					anchors {
			        	left: parent.left
			        	margins: units.dp(16)
			        }

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