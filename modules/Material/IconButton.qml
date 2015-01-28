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
import Material.Extras 0.1

Icon {
    id: icon

    signal triggered

    name: action ? action.iconName : ""
    enabled: action ? action.enabled : true

    onTriggered: {
        if (action) action.triggered(icon)
    }

    opacity: enabled ? 1 : 0.6

    property Action action

    Ink {
        id: ink

        anchors.centerIn: parent

        enabled: icon.enabled
        circular: true

        width: parent.width + units.dp(8)
        height: parent.height + units.dp(8)

        onClicked: {
            //ink.focused = true
            icon.triggered()
        }
    }

}
