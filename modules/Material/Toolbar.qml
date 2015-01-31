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
import QtQuick.Controls 1.2 as Controls
import QtQuick.Layouts 1.1
import Material 0.1

View {
    id: toolbar

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    opacity: page && page.actionBar.hidden ? 0 : 1

    backgroundColor: page && page.actionBar.backgroundColor ? Qt.darker(page.actionBar.backgroundColor,1).a == 0
                                                              ? page.color : page.actionBar.backgroundColor
                                                            : Theme.primaryColor

    implicitHeight: Device.type == Device.phone ? units.dp(48)
                                                : Device.type == Device.tablet ? units.dp(56)
                                                                               : units.dp(64)
    height: targetHeight

    elevation: backgroundColor == page.color ? 0 : 2

    fullWidth: true

    clipContent: true

    property int targetHeight: page && page.actionBar.hidden ? 0
                                                : implicitHeight + (tabs.length > 0 ? tabbar.height : 0)
                                                                 + (expanded ? implicitHeight : 0)

    property int maxActionCount: (Device.formFactor == "desktop"
                                  ? 5 : Device.formFactor == "tablet" ? 4 : 3)

    property bool expanded: false

    property bool clientSideDecorations: false

    property string color: "white"

    property var page

    property alias tabs: tabbar.tabs

    property alias selectedTab: tabbar.selectedIndex

    property bool showBackButton

    property var pages: []

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

    function pop() {
        stack.pop()
        page = pages.pop()
    }

    function push( page ) {
        page.actionBar.maxActionCount = Qt.binding( function() { return toolbar.maxActionCount } );
        stack.push(page.actionBar);
        pages.push(toolbar.page)
        toolbar.page = page
    }

    Controls.StackView {
        id: stack
        height: toolbar.implicitHeight

        anchors {
            left: parent.left
            right: clientSideDecorations ? windowControls.left : parent.right
        }

        delegate: Controls.StackViewDelegate {
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
    }

    Row {
        id: windowControls

        anchors {
            verticalCenter: stack.verticalCenter
            right: parent.right
            rightMargin: units.dp(16)
        }

        spacing: units.dp(24)

        IconButton {
            name: "navigation/close"
            color: Theme.lightDark(toolbar.backgroundColor, Theme.light.textColor,
                Theme.dark.textColor)
        }
    }

    Tabs {
        id: tabbar
        color: toolbar.backgroundColor
        highlight: Theme.accentColor
        visible: tabs.length > 0

        tabs: page ? page.tabs : []

        anchors {
            left: parent.left
            right: parent.right
            top: stack.bottom
        }
    }

}
