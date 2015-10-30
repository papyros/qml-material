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
import QtQuick 2.4
import ".."

/*!
   \qmltype BaseListItem
   \inqmlmodule Material.ListItems 0.1

   \brief The base class for list items.

   Provides ink effects, mouse/touch handling and tinting on mouse hover.
 */
View {
    id: listItem
    anchors {
        left: parent ? parent.left : undefined
        right: parent ? parent.right : undefined
    }

    property int margins: Units.dp(16)

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
