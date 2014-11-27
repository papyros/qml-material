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

Object {

    property color primary: "#5677fc"
    property color primaryDark: "#5677fc"
    property color secondary: "white"
    property var font: robotoFont

    property color defaultBackground: "#f3f3f3"

    property color temp

    function blackColor(style) {
        if (style == 'text') {
            return Qt.rgba(0,0,0,0.7)
            //return Qt.rgba(0,0,0,0.87)
        } else if (style == 'secondary' || style == 'icon') {
            return Qt.rgba(0,0,0,0.54)
        } else if (style == 'hint') {
            return Qt.rgba(0,0,0,0.26)
        } else if (style == 'divider') {
            return Qt.rgba(0,0,0,0.12)
        }
    }

    function colorize(color, alpha) {
        temp = color
        print(temp.r,temp.g,temp.b,alpha)
        print(Qt.rgba(temp.r,temp.g,temp.b,alpha))
        return Qt.rgba(temp.r,temp.g,temp.b,alpha)
    }

    function styleColor(style) {
        if (style == "default")
            return blackColor('text')
        else
            return primary
    }
    
    FontLoader {
        source: Qt.resolvedUrl("fonts/roboto/Roboto-Regular.ttf")
        id: robotoFont
    }
}
