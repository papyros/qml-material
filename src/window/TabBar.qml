/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2015-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Layouts 1.1

import Material 0.3
import Material.ListItems 0.1

Item {
    id: tabBar

    property bool centered: false

    property var tabs: []
    property int leftKeyline

    property bool isLargeDevice: Device.type == Device.desktop || Device.type == Device.tablet

    property bool fullWidth: isLargeDevice
            ? false : width - maxTabsWidth <= 16 * Units.dp && tabsWidth <= width

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

    property int tabPadding: isLargeDevice ? 24 * Units.dp : 12 * Units.dp

    property int tabMinWidth: isLargeDevice ? 160 * Units.dp : 72 * Units.dp

    property int selectedIndex: 0

    property bool darkBackground

    property color highlightColor: Theme.tabHighlightColor
    property color textColor: darkBackground ? Theme.dark.textColor : Theme.light.accentColor

    property bool isTabView: String(tabs).indexOf("TabView") != -1

    readonly property int tabCount: isTabView ? tabs.count : tabs.length

    visible: tabCount > 0
    implicitHeight: 48 * Units.dp

    onTabCountChanged: {
        selectedIndex = Math.min(selectedIndex, tabCount)
    }

    function removeTab(tab, index) {
        if (tab.hasOwnProperty("close")) {
            tab.close()
        } else if (tabs.hasOwnProperty("removeTab")) {
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

            height: 2 * Units.dp
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
                    ? Math.min(2 * tabPadding + row.width, 264 * Units.dp)
                    : Math.min(Math.max(2 * tabPadding + row.width, tabMinWidth), 264 * Units.dp)


            property bool selected: index == tabBar.selectedIndex

            property var tab: isTabView ? tabs.getTab(index) : modelData

            Ink {
                anchors.fill: parent
                enabled: tab.enabled
                onClicked: tabBar.selectedIndex = index

                Row {
                    id: row

                    anchors.centerIn: parent
                    spacing: 10 * Units.dp

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
                        visible: tab.hasOwnProperty("canRemove") && tab.canRemove && (tabs.hasOwnProperty("removeTab") || tab.hasOwnProperty("close"))
                        color: tabItem.selected
                                ? darkBackground ? Theme.dark.iconColor : Theme.light.accentColor
                                : darkBackground ? Theme.dark.shade(tab.enabled ? 0.6 : 0.2) : Theme.light.shade(tab.enabled ? 0.6 : 0.2)
                        onClicked: tabBar.removeTab(tab, index)
                        size: 20 * Units.dp
                    }
                }
            }
        }
    }
}
