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
import Material 0.1

FocusScope {
    id: page

    property color backgroundColor: Theme.backgroundColor
    property string title
    property list<Action> actions
    property Action backAction: Action {
        name: "Back"
        iconName: "navigation/arrow_back"
        onTriggered: page.pop()
        visible: canGoBack
    }
    property bool canGoBack: false
    property bool cardStyle: false
    property var tabs: []
    property int selectedTab
    property alias actionBar: __actionBar
    default property alias data: content.data
    property Item rightSidebar

    onRightSidebarChanged: {
        if (rightSidebar)
            rightSidebar.mode = "right"
    }

    ActionBar {
        id: __actionBar

        page: page
    }

    Rectangle {
        anchors.fill: parent
        color: backgroundColor
    }

    function pop() {
        if (Controls.Stack.view.currentItem == page)
            Controls.Stack.view.pop();
    }

    function push(component, properties) {
        Controls.Stack.view.push({item: component, properties: properties});
    }

    Item {
        id: content

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: rightSidebarContent.left
        }
    }

    Item {
        id: rightSidebarContent

        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }

        children: [rightSidebar]

        width: rightSidebar
               ? rightSidebar.width + rightSidebar.anchors.rightMargin
               : 0
    }
}
