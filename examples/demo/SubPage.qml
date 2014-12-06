import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem

Page {
	id: page
	title: "Page Title"

	tabs: [
		// Each tab can have text and an icon
		{
			text: "Overview",
			icon: "action/home"
		},
		
		// You can also leave out the icon
		{
			text:"Projects",
		},
		
		// Or just simply use a string
		"Inbox"
	]
	
	// TabView is simply a customized ListView
	// You can use any model/delegate for the tab contents,
	// but a VisualItemModel works well
	TabView {
		id: tabView
		anchors.fill: parent
		currentIndex: page.selectedTab
		model: tabs
	}
	
	VisualItemModel {
		id: tabs
		
		// Tab 1 "Overview"
		Rectangle {
			width: tabView.width
			height: tabView.height
			color: "green"
		}
		
		// Tab 2 "Projects"
		Rectangle {
			width: tabView.width
			height: tabView.height
			color: "orange"
		}
		
		// Tab 3 "Inbox"
		Rectangle {
			width: tabView.width
			height: tabView.height
			color: "purple"
		}
	}
}
