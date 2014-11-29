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

pragma Singleton

Object {
    id: theme

    property color primaryColor: "#5677fc"
    property color primaryDarkColor: "#5677fc"
    property color secondaryColor: "white"
    property color backgroundColor: "#f3f3f3"

    readonly property color textColor: Qt.rgba(0,0,0,0.70)
    readonly property color subTextColor: Qt.rgba(0,0,0,0.54)
    readonly property color iconColor: subTextColor
    readonly property color hintColor: Qt.rgba(0,0,0,0.26)
    readonly property color dividerColor: Qt.rgba(0,0,0,0.12)

    // Temporary color used by alphaColor
    property color temp

    // TODO: Do we need this?
    function alphaColor(color, alpha) {
        temp = color
        print(temp.r,temp.g,temp.b,alpha)
        print(Qt.rgba(temp.r,temp.g,temp.b,alpha))
        return Qt.rgba(temp.r,temp.g,temp.b,alpha)
    }

    // TODO: Load all the fonts!
    FontLoader {
        source: Qt.resolvedUrl("fonts/roboto/Roboto-Regular.ttf")
        id: robotoFont
    }
}
