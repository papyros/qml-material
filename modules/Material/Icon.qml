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
import QtQuick.Window 2.0
import Material 0.1
import QtGraphicalEffects 1.0

Item {
    id: icon

    property color color: Theme.light.iconColor
    property real size: units.dp(24)

    /*!
       The name of the icon to display.
       
       \sa source
    */
    property string name

    /*!
       A URL pointing to an image to display as the icon. By default, this is
       a special URL representing the icon named by \l name from the Material Design
       icon collection or FontAwesome. The icon color will not be changed unless you
       set the \l colorize property to true or put ".tint." in the filename, in which case
       the \l color property will be used to color the icon.

       \sa name
      */
    property string source: "icon://" + name

    property bool valid: name.indexOf("awesome") == 0 
            ? awesomeIcon.valid : image.status == Image.Ready

    property url iconDirectory: Qt.resolvedUrl("icons")

    width: size
    height: size

    property bool colorize: icon.source.indexOf("icon://") == 0 || icon.source.indexOf(".tint.") != -1

    Image {
        id: image

        anchors.fill: parent
        visible: icon.source != "" && !colorize

        source: {
            if (icon.source.indexOf("icon://") == 0) {
                var name = icon.source.substring(7)
                var list = name.split("/");

                if (name == "" || list[0] == "awesome")
                    return "";
                return Qt.resolvedUrl("icons/%1/%2.svg".arg(list[0]).arg(list[1]));
            } else {
                return icon.source
            }
        }

        sourceSize {
            width: size * Screen.devicePixelRatio
            height: size * Screen.devicePixelRatio
        }
    }

    ColorOverlay {
        id: overlay

        anchors.fill: parent
        source: image
        color: Theme.alpha(icon.color, 1)
        cached: true
        visible: icon.source != "" && colorize && image.source != ""
        opacity: icon.color.a
    }  

    AwesomeIcon {
        id: awesomeIcon

        anchors.centerIn: parent
        size: icon.size * 0.9
        visible: name != ""
        color: icon.color

        name: {
            if (icon.source.indexOf("icon://") == 0) {
                var name = icon.source.substring(7)
                var list = name.split("/")

                if (list[0] == "awesome") {
                    return list[1]
                }
            }

            return ""
        }
    }
}
