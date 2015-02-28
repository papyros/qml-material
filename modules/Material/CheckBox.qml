/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Jordan Neidlinger
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
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle
import Material 0.1

Controls.CheckBox {
    id: checkBox

    /*!
       The checkbox color. By default this is the app's accent color
     */
    property color color: darkBackground ? Theme.dark.accentColor : Theme.light.accentColor

    /*!
       Set to \c true if the checkbox is on a dark background
     */
    property bool darkBackground

    style: MaterialStyle.CheckBoxStyle {}

    Ink {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
        }

        width: units.dp(54)
        height: units.dp(54)
        color: checkBox.checked ? Theme.alpha(checkBox.color, 0.20) : Qt.rgba(0,0,0,0.1)
        enabled: checkBox.enabled

        circular: true
        centered: true

        onClicked: checkBox.checked = !checkBox.checked
    }
}
