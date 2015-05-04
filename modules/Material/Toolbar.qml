/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014-2015 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtQuick.Controls 1.2 as Controls
import QtQuick.Layouts 1.1
import Material 0.1


/*!
   \qmltype Toolbar
   \inqmlmodule Material 0.1

   \brief Brief description...

   Details...
*/
View {
    id: toolbar

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    property int actionBarHeight: {
        if (!page || page.actionBar.hidden)
            return 0

        var height = implicitHeight + page.actionBar.extendedHeight

        if (page.rightSidebar && page.rightSidebar.showing) {
            var sidebarHeight = implicitHeight + page.rightSidebar.actionBar.extendedHeight

            height = Math.max(height, sidebarHeight)
        }

        return height
    }
    property int targetHeight: actionBarHeight + (tabs.length > 0 ? tabbar.height : 0)
    property int maxActionCount: Device.type === Device.desktop
                                 ? 5 : Device.type === Device.tablet ? 4 : 3
    property bool clientSideDecorations: false
    property string color: "white"
    property var page
    property alias tabs: tabbar.tabs
    property alias selectedTab: tabbar.selectedIndex
    property bool showBackButton
    property var pages: []

    opacity: page && page.actionBar.hidden ? 0 : 1

    backgroundColor: page ? page.actionBar.backgroundColor.a === 0
                            ? page.backgroundColor : page.actionBar.backgroundColor
                          : Theme.primaryColor

    implicitHeight: Device.type == Device.phone || Device.type === Device.phablet 
            ? Units.dp(48) : Device.type == Device.tablet ? Units.dp(56) : Units.dp(64)

    height: targetHeight
    elevation: backgroundColor === page.color ? 0 : page.actionBar.elevation
    fullWidth: true
    clipContent: true

    Behavior on height {
        NumberAnimation { duration: MaterialAnimation.pageTransitionDuration }
    }

    Behavior on opacity {
        NumberAnimation { duration: MaterialAnimation.pageTransitionDuration }
    }

    onSelectedTabChanged: {
        if (page)
            page.selectedTab = selectedTab
    }

    onPageChanged: {
        toolbar.selectedTab = page.selectedTab
    }

    Connections {
        target: page

        // Ignore errors when the page is invalid or null
        ignoreUnknownSignals: true

        onSelectedTabChanged: {
            toolbar.selectedTab = page.selectedTab
        }
    }

    function pop() {
        stack.pop()

        if (page.rightSidebar && page.rightSidebar.actionBar)
            rightSidebarStack.pop()

        page = pages.pop()
    }

    function push(page) {
        stack.push(page.actionBar)
        pages.push(toolbar.page)

        page.actionBar.toolbar = toolbar
        toolbar.page = page

        if (page.rightSidebar && page.rightSidebar.actionBar)
            rightSidebarStack.push(page.rightSidebar.actionBar)
    }

    function replace(page) {
        page.actionBar.maxActionCount = Qt.binding(function() { return toolbar.maxActionCount })
        toolbar.page = page

        stack.replace(page.actionBar)

        if (page.rightSidebar && page.rightSidebar.actionBar)
            rightSidebarStack.replace(page.rightSidebar.actionBar)

        pages.pop()
        pages.push(toolbar.page)
    }

    Rectangle {
        anchors.fill: rightSidebarStack

        color: page.rightSidebar && page.rightSidebar.actionBar.backgroundColor
               ? Qt.darker(page.rightSidebar.actionBar.backgroundColor,1).a === 0
                 ? page.rightSidebar.color
                 : page.rightSidebar.actionBar.backgroundColor
               : Theme.primaryColor
    }

    Controls.StackView {
        id: stack
        height: actionBarHeight

        Behavior on height {
            NumberAnimation { duration: MaterialAnimation.pageTransitionDuration }
        }

        anchors {
            left: parent.left
            right: page && page.rightSidebar
                   ? rightSidebarStack.left
                   : clientSideDecorations ? windowControls.left : parent.right
            rightMargin: 0
        }

        delegate: toolbarDelegate
    }

    Controls.StackView {
        id: rightSidebarStack
        height: actionBarHeight
        width: page && page.rightSidebar
               ? page.rightSidebar.width
               : 0

        Behavior on height {
            NumberAnimation { duration: MaterialAnimation.pageTransitionDuration }
        }

        anchors {
            right: clientSideDecorations ? windowControls.left : parent.right
            rightMargin: page.rightSidebar ? page.rightSidebar.anchors.rightMargin : 0
        }

        delegate: toolbarDelegate
    }

    Controls.StackViewDelegate {
        id: toolbarDelegate

        pushTransition: Controls.StackViewTransition {
            SequentialAnimation {
                id: actionBarShowAnimation

                ParallelAnimation {
                    NumberAnimation {
                        duration: MaterialAnimation.pageTransitionDuration
                        target: enterItem
                        property: "opacity"
                        from: 0
                        to: 1
                    }

                    NumberAnimation {
                        duration: MaterialAnimation.pageTransitionDuration
                        target: enterItem
                        property: "y"
                        from: enterItem.height
                        to: 0
                    }
                }
            }
            SequentialAnimation {
                id: previousHideAnimation

                ParallelAnimation {

                    NumberAnimation {
                        duration: MaterialAnimation.pageTransitionDuration
                        target: exitItem
                        property: "opacity"
                        to: 0
                    }

                    NumberAnimation {
                        duration: MaterialAnimation.pageTransitionDuration
                        target: exitItem
                        property: "y"
                        to: exitItem ? -exitItem.height : 0
                    }
                }
            }
        }
    }

    Row {
        id: windowControls

        visible: clientSideDecorations

        anchors {
            verticalCenter: stack.verticalCenter
            right: parent.right
            rightMargin: Units.dp(16)
        }

        spacing: Units.dp(24)

        IconButton {
            iconName: "navigation/close"
            color: Theme.lightDark(toolbar.backgroundColor, Theme.light.textColor,
                Theme.dark.textColor)
            onClicked: Qt.quit()
        }
    }

    Tabs {
        id: tabbar
        color: toolbar.backgroundColor
        visible: tabs.length > 0

        tabs: page ? page.tabs : []
        darkBackground: Theme.isDarkColor(toolbar.backgroundColor)

        anchors {
            left: parent.left
            right: parent.right
            top: stack.bottom
        }
    }

}
