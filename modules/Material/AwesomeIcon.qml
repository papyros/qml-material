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
import 'awesome.js' as Awesome

Item {
    id: widget

    property string name
    property bool rotate: widget.name.match(/.*-rotate/) !== null

    property alias color: text.color
    property int size: units.dp(24)

    width: text.width
    height: text.height

    property bool shadow: false

    property var icons: Awesome.map

    property alias weight: text.font.weight

    FontLoader { id: fontAwesome; source: Qt.resolvedUrl("fonts/fontawesome/FontAwesome.otf") }

    Text {
        id: text
        anchors.centerIn: parent

        property string name: widget.name.match(/.*-rotate/) !== null ? widget.name.substring(0, widget.name.length - 7) : widget.name

        font.family: fontAwesome.name
        font.weight: Font.Light
        text: widget.icons.hasOwnProperty(name) ? widget.icons[name] : ""
        color: Theme.light.iconColor
        style: shadow ? Text.Raised : Text.Normal
        styleColor: Qt.rgba(0,0,0,0.5)
        font.pixelSize: widget.size

        Behavior on color {
            ColorAnimation { duration: 200 }
        }

        NumberAnimation on rotation {
            running: widget.rotate
            from: 0
            to: 360
            loops: Animation.Infinite
            duration: 1100
        }
    }
}
