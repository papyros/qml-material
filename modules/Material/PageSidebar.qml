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
import QtQuick.Controls 1.3 as Controls
import Material 0.1

/*!
   \qmltype PageSidebar
   \inqmlmodule Material 0.1

   \brief Represents a split sidebar in a page, with its own title, actions, and color 
   in the action bar.
 */
Page {
    id: pageSidebar

    default property alias sidebar: sidebar.data
    property alias mode: sidebar.mode
    property bool showing: true

    anchors {
        rightMargin: showing ? 0 : -width

        Behavior on rightMargin {
            id: behavior
            enabled: false
            
            NumberAnimation { duration: 200 }
        }
    }

    height: parent.height

    Sidebar {
        id: sidebar

        anchors.fill: parent
    }

    Component.onCompleted: behavior.enabled = true
}
