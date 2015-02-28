/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer
 *               2015 Bogdan Cuza
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
import QtGraphicalEffects 1.0

Image {
    id: icon

    property alias color: overlay.color
    property real size: units.dp(24)

    /*!
       The name of the icon to display.
       \qmlproperty string name
    */
    property string name

    source: {
        var list = name.split("/");
        if (name == "" || list[0] == "awesome")
            return "";
        return Qt.resolvedUrl("icons/%1/%2.svg".arg(list[0]).arg(list[1]));
    }
    width: height
    height: size
    mipmap: true
    fillMode: Image.PreserveAspectFit

    ColorOverlay {
        id: overlay

        anchors.fill: parent
        source: parent
        color: Theme.light.iconColor
        cached: true
    }

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
