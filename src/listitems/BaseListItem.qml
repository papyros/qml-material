/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import Material 0.3

/*!
   \qmltype BaseListItem
   \inqmlmodule Material.ListItems

   \brief The base class for list items.

   Provides ink effects, mouse/touch handling and tinting on mouse hover.
 */
View {
    id: listItem
    anchors {
        left: parent ? parent.left : undefined
        right: parent ? parent.right : undefined
    }

    property bool darkBackground
    property int margins: 16 * Units.dp

    property bool selected
    property bool interactive: true

    property int dividerInset: 0
    property bool showDivider: false

    signal clicked()
    signal pressAndHold()

    opacity: enabled ? 1 : 0.6

    ThinDivider {
        anchors.bottom: parent.bottom
        anchors.leftMargin: dividerInset

        visible: showDivider
        darkBackground: listItem.darkBackground
    }

    Ink {
        id: ink

        onClicked: listItem.clicked()
        onPressAndHold: listItem.pressAndHold()

        anchors.fill: parent

        enabled: listItem.interactive && listItem.enabled
        z: -1
    }

    tintColor: selected
               ? Qt.rgba(0,0,0,0.05)
               : ink.containsMouse ? Qt.rgba(0,0,0,0.03) : Qt.rgba(0,0,0,0)
}
