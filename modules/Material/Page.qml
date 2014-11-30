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

Rectangle {
    id: page

    property string title
    property alias actionBar: __actionBar

    ActionBar {
        id: __actionBar
        page: page
    }

    property Item pageStack

    property list<Action> actions
    property Action backAction: Action {
        name: "Back"
        iconName: "navigation/arrow_back"
        onTriggered: pageStack.pop()
        visible: showBackButton
    }

    anchors.fill: parent

    property bool currentPage: pageStack.currentPage === page

    property bool dynamic: false

    signal close

    property bool showBackButton: true

    property var tabs: []
    property int selectedTab
    property Item transition

    property bool cardStyle: false

    z: 0

    color: Theme.backgroundColor

    function push() {
        z = pageStack.count
    }

    function pop() {

    }
}
