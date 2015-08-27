/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtQuick 2.2
import QtQuick.Layouts 1.1

import Material 0.1
import Material.ListItems 0.1

Item {
	id: tabbar

	property var tabs
	property int leftKeyline

	property bool isLargeDevice: Device.type == Device.desktop || Device.type == Device.tablet

	property bool fullWidth: isLargeDevice
			? false : width - maxTabsWidth <= Units.dp(16) && tabsWidth <= width

	property int tabsWidth: {
		var width = 0

		for (var i = 0; i < tabRow.children.length; i++) {
			width += tabRow.children[i].implicitWidth
		}

		return width
	}

	property int maxTabsWidth: {
		var tabWidth = 0

		for (var i = 0; i < tabRow.children.length; i++) {
			tabWidth = Math.max(tabRow.children[i].implicitWidth, tabWidth)
		}

		return tabWidth * tabRow.children.length
	}

	property int tabPadding: isLargeDevice ? Units.dp(24) : Units.dp(12)

	property int tabMinWidth: isLargeDevice ? Units.dp(160) : Units.dp(72)

	property int selectedIndex: 0

    property bool darkBackground

    property color highlightColor: Theme.tabHighlightColor
    property color textColor: darkBackground ? Theme.dark.textColor : Theme.light.accentColor

    height: Units.dp(48)

    onWidthChanged: {
    	print(maxTabsWidth, width, fullWidth)
    }

	Row {
		id: tabRow

		height: parent.height
		x: fullWidth ? 0 : Math.max(leftKeyline - tabPadding, 0)

		Repeater {
			id: repeater
			model: tabs
			delegate: tabDelegate
		}
	}

	Rectangle {
        id: selectionIndicator
        anchors {
            bottom: parent.bottom
        }

        height: Units.dp(2)
        color: tabbar.highlightColor
        x: tabRow.children[tabbar.selectedIndex].x + tabRow.x
        width: tabRow.children[tabbar.selectedIndex].width

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        Behavior on x {
            NumberAnimation { duration: 200 }
        }

        Behavior on width {
            NumberAnimation { duration: 200 }
        }
    }

	Component {
		id: tabDelegate

		View {
            id: tabItem

            width: tabbar.fullWidth ? tabbar.width/repeater.count : implicitWidth
            height: tabbar.height

            implicitWidth: isLargeDevice
            		? Math.min(2 * tabPadding + row.width, Units.dp(264))
            		: Math.min(Math.max(2 * tabPadding + row.width, tabMinWidth), Units.dp(264))


            onImplicitWidthChanged: print("Tab", index, implicitWidth)

            property bool selected: index == tabbar.selectedIndex

            Ink {
                anchors.fill: parent

                onClicked: tabbar.selectedIndex = index
            }

            Row {
                id: row

                anchors.centerIn: parent
                spacing: Units.dp(10)

                Icon {
                    anchors.verticalCenter: parent.verticalCenter

                    name: modelData.hasOwnProperty("icon") ? modelData.icon : ""
                    color: tabItem.selected
                            ? darkBackground ? Theme.dark.iconColor : Theme.light.accentColor
                            : darkBackground ? Theme.dark.shade(0.6) : Theme.light.shade(0.6)

                    visible: name != ""

                    Behavior on color {
                        ColorAnimation { duration: 200 }
                    }
                }

                Label {
                    id: label

                    text: modelData.hasOwnProperty("text") ? modelData.text : modelData
                    color: tabItem.selected
                            ? darkBackground ? Theme.dark.textColor : Theme.light.accentColor
                            : darkBackground ? Theme.dark.shade(0.6) : Theme.light.shade(0.6)

                    style: "body2"
                    font.capitalization: Font.AllUppercase
                    anchors.verticalCenter: parent.verticalCenter
                    maximumLineCount: 2

                    Behavior on color {
                        ColorAnimation { duration: 200 }
                    }
                }
            }
        }
	}
}
