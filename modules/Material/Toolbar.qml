/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer
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
    id: toolbar

    implicitHeight: Device.type == Device.phone ? units.dp(48)
                                                       : Device.type == Device.tablet ? units.dp(56)
                                                                                         : units.dp(64)
    height: targetHeight

    property int targetHeight: implicitHeight + (tabs.length > 0 ? tabbar.height : 0)
                                              + (expanded ? implicitHeight : 0)

    property bool expanded: false

    property bool clientSideDecorations: false

    Behavior on height {
        NumberAnimation { duration: MaterialAnimation.pageTransitionDuration }
    }

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    elevation: 2
    fullWidth: true

    clipContent: true

    property string color: "white"

    property alias tabs: tabbar.tabs
    property alias selectedTab: tabbar.selectedIndex
    
    property bool showBackButton

    property NavigationDrawer drawer

    property int maxActionCount: (Device.type == Device.desktop
                                  ? 5 : Device.type == Device.tablet ? 4 : 3) - (drawer ? 1 : 0)

    property Item actionBar
    property Item previousActionBar: actionBar

    function pushActionBar(nextPage, lastPage) {
        print("Pushing action bar..")

        actionBar = nextPage.actionBar
        actionBar.toolbar = toolbar
        previousActionBar = lastPage ? lastPage.actionBar : null

        if (previousActionBar != null) {
            previousActionBar.parent = actionBarItem

            previousHideAnimation.start()
            print("Hiding previous action bar...")
        }

        actionBar.parent = actionBarItem

        actionBarShowAnimation.start()
    }

    function popActionBar(previousPage, currentPage) {
        print("Pushing action bar..")

        actionBar = currentPage.actionBar
        previousActionBar = previousPage ? previousPage.actionBar : null

        if (previousActionBar != null) {
            previousActionBar.parent = actionBarItem

            previousShowAnimation.start()
            print("Hiding previous action bar...")
        }

        actionBar.parent = actionBarItem

        actionBarHideAnimation.start()
    }

    SequentialAnimation {
        id: previousHideAnimation

        ParallelAnimation {

            NumberAnimation {
                duration: MaterialAnimation.pageTransitionDuration
                target: previousActionBar
                property: "opacity"
                to: 0
            }

            NumberAnimation {
                duration: MaterialAnimation.pageTransitionDuration
                target: previousActionBar
                property: "y"
                to: previousActionBar ? -previousActionBar.height : 0
            }
        }
    }

    SequentialAnimation {
        id: previousShowAnimation

        ParallelAnimation {

            NumberAnimation {
                duration: MaterialAnimation.pageTransitionDuration
                target: previousActionBar
                property: "opacity"
                from: 0
                to: 1
            }

            NumberAnimation {
                duration: MaterialAnimation.pageTransitionDuration
                target: previousActionBar
                property: "y"
                from: previousActionBar ? -previousActionBar.height : 0
                to: 0
            }
        }
    }

    SequentialAnimation {
        id: actionBarShowAnimation

        ParallelAnimation {
            NumberAnimation {
                duration: MaterialAnimation.pageTransitionDuration
                target: actionBar
                property: "opacity"
                from: 0
                to: 1
            }

            NumberAnimation {
                duration: MaterialAnimation.pageTransitionDuration
                target: actionBar
                property: "y"
                from: actionBar.height
                to: 0
            }
        }
    }

    SequentialAnimation {
        id: actionBarHideAnimation

        ParallelAnimation {
            NumberAnimation {
                duration: MaterialAnimation.pageTransitionDuration
                target: actionBar
                property: "opacity"
                from: 1
                to: 0
            }

            NumberAnimation {
                duration: MaterialAnimation.pageTransitionDuration
                target: actionBar
                property: "y"
                to: actionBar.height
                from: 0
            }
        }
    }

    Item {
        id: actionBarItem

        anchors {
            left: parent.left
            right: clientSideDecorations ? windowControls.left : parent.right
            rightMargin: clientSideDecorations ? units.dp(8) : 0
        }
        height: toolbar.implicitHeight


    }

    Row {
        id: windowControls
        visible: clientSideDecorations

        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: units.dp(16)
        }

        spacing: units.dp(24)

        IconAction {
            name: "navigation/close"
            color: "white"
            onTriggered: {
                Qt.quit()
            }
        }
    }

    Tabs {
        id: tabbar
        anchors {
            top: toolbar.height <= toolbar.implicitHeight + tabbar.height
                 ? actionBarItem.bottom : undefined
            bottom: toolbar.height <= toolbar.implicitHeight + tabbar.height
                    ? undefined : parent.bottom
        }
        color: toolbar.color
        highlight: Theme.accentColor
    }
}
