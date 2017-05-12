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
import QtQuick.Controls 1.3 as Controls
import Material 0.3

/*!
   \qmltype PageSidebar
   \inqmlmodule Material

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
