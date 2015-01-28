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
import QtQuick 2.3
import Material 0.1

Image {
    id: icon

    source: {
        var list = name.split("/")

        if (name == "" || list[0] == "awesome")
            return ""

        var color = icon.color

        if (color == 'gray' || color == 'grey')
            color = 'grey600'
         else if (color == Theme.light.iconColor)
            color = 'grey600'
        else if  (color == Theme.dark.iconColor)
            color = 'white'

        var dp_size = "18"

        if (size > 36 * 3)
            dp_size = "48"
        if (size > 24 * 3)
            dp_size = "36"
        else if (size > 18 * 3)
            dp_size = "24"

        return Qt.resolvedUrl("icons/%1/ic_%2_%3_%4dp.png".arg(list[0]).arg(list[1]).arg(color).arg(dp_size))
    }

    /*!
       The name of the icon to display.
       \qmlproperty string name
    */
    property string name

    property real size: units.dp(24)

    width: icon.name.indexOf("awesome/") == 0
           ? height : sourceSize.width * height/sourceSize.height
    height: size

    property string color: Theme.light.iconColor

    mipmap: true

    AwesomeIcon {
        anchors.centerIn: parent
        size: icon.size * 0.9

        visible: icon.name.indexOf("awesome/") == 0

        name: {
            var list = icon.name.split("/")

            if (list[0] == "awesome") {
                return list[1]
            }

            return ''
        }

        color: icon.color
    }
}
