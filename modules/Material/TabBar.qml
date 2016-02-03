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
import QtQuick 2.4
import QtQuick.Layouts 1.1

import Material 0.2
import Material.ListItems 0.1

Item {
    id: tabBar

    property bool centered: false

    property var tabs: []
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

    property bool isTabView: String(tabs).indexOf("TabView") != -1

    readonly property int tabCount: isTabView ? tabs.count : tabs.length

    visible: tabCount > 0
    height: Units.dp(48)

    onTabCountChanged: {
        selectedIndex = Math.min(selectedIndex, tabCount)
    }

    function removeTab(index) {
        if (tabs.hasOwnProperty("removeTab")) {
            tabs.removeTab(index)
        }
    }

    property Item activeTab: selectedIndex < tabCount &&
                             tabRow.children[selectedIndex] !== undefined
            ? tabRow.children[selectedIndex] : null

    property int activeTabX: activeTab ? activeTab.x : -1
    property int activeTabWidth: activeTab ? activeTab.width : -1

    property int __animated

    onActiveTabChanged: __animated = false

    Component.onCompleted: animateStablization.restart()

    onActiveTabXChanged: {
        if (activeTabX == -1)
            return
        if (__animated) {
            selectionIndicator.x = activeTab.x
        } else {
            animateStablization.restart()
        }
    }
    onActiveTabWidthChanged: {
        if (activeTabWidth == -1)
            return
        if (__animated) {
            selectionIndicator.width = activeTab.width
        } else {
            animateStablization.restart()
        }
    }

    Timer {
        id: animateStablization
        interval: 5
        onTriggered: {
            __animated = true
            seqX.to = activeTabX
            seqWidth.to = activeTabWidth
            selectionAnimation.restart()
        }
    }

    ParallelAnimation {
        id: selectionAnimation

        NumberAnimation {
            id: seqX
            target: selectionIndicator; property: "x"; duration: 200
        }
        NumberAnimation {
            id: seqWidth
            target: selectionIndicator; property: "width"; duration: 200
        }
    }

    Item {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: centered ? undefined : parent.left
            leftMargin: fullWidth ? 0 : Math.max(leftKeyline - tabPadding, 0)
            horizontalCenter: centered ? parent.horizontalCenter : undefined
        }

        width: tabRow.width

        Row {
            id: tabRow

            height: parent.height

            Repeater {
                id: repeater
                model: isTabView ? tabs.count : tabs
                delegate: tabDelegate
            }
        }

        Rectangle {
            id: selectionIndicator
            anchors {
                bottom: parent.bottom
            }

            height: Units.dp(2)
            color: tabBar.highlightColor
        }
    }

    Component {
        id: tabDelegate

        View {
            id: tabItem

            width: tabBar.fullWidth ? tabBar.width/repeater.count : implicitWidth
            height: tabBar.height

            implicitWidth: isLargeDevice
                    ? Math.min(2 * tabPadding + row.width, Units.dp(264))
                    : Math.min(Math.max(2 * tabPadding + row.width, tabMinWidth), Units.dp(264))


            property bool selected: index == tabBar.selectedIndex

            property var tab: isTabView ? tabs.getTab(index) : modelData

            Ink {
                anchors.fill: parent
                enabled: tab.enabled
                onClicked: tabBar.selectedIndex = index

                Row {
                    id: row

                    anchors.centerIn: parent
                    spacing: Units.dp(10)

                    Icon {
                        anchors.verticalCenter: parent.verticalCenter

                        source: tabItem.tab.hasOwnProperty("iconSource")
                                ? tabItem.tab.iconSource : tabItem.tab.hasOwnProperty("iconName")
                                ? "icon://" + tabItem.tab.iconName : ""
                        color: tabItem.selected
                                ? darkBackground ? Theme.dark.iconColor : Theme.light.accentColor
                                : darkBackground ? Theme.dark.shade(tab.enabled ? 0.6 : 0.2) : Theme.light.shade(tab.enabled ? 0.6 : 0.2)

                        visible: source != "" && source != "icon://"

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                    }

                    Label {
                        id: label

                        text: typeof(tabItem.tab) == "string"
                                ? tabItem.tab : tabItem.tab.title
                        color: tabItem.selected
                                ? darkBackground ? Theme.dark.textColor : Theme.light.accentColor
                                : darkBackground ? Theme.dark.shade(tab.enabled ? 0.6 : 0.2) : Theme.light.shade(tab.enabled ? 0.6 : 0.2)

                        style: "body2"
                        font.capitalization: Font.AllUppercase
                        anchors.verticalCenter: parent.verticalCenter
                        maximumLineCount: 2

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                    }

                    IconButton {
                        iconName: "navigation/close"
                        visible: tab.hasOwnProperty("canRemove") && tab.canRemove && tabs.hasOwnProperty("removeTab")
                        color: tabItem.selected
                                ? darkBackground ? Theme.dark.iconColor : Theme.light.accentColor
                                : darkBackground ? Theme.dark.shade(tab.enabled ? 0.6 : 0.2) : Theme.light.shade(tab.enabled ? 0.6 : 0.2)
                        onClicked: tabBar.removeTab(index)
                        size: Units.dp(20)
                    }
                }
            }
        }
    }
}
