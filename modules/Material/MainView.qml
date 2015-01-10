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
import QtQuick.Window 2.2
import Material 0.1

Item {
    id: app

    /*!
       A grouped property that allows the application to customize the the primary color, the
       primary dark color, and the accent color. See \l Theme for more details.
     */
    property alias theme: __theme

    /*!
       \internal
       The pixel density of the screen the application's window is currently on. See \l Screen
       and \l units.
     */

    width: units.dp(800)
    height: units.dp(600)
    
    Component.onCompleted: {
      units.pixelDensity = Qt.binding( function() { return Screen.pixelDensity } );
      Device.type = Qt.binding( function () {
        var diagonal = Math.sqrt(Math.pow((Screen.width/Screen.pixelDensity), 2) + Math.pow((Screen.height/Screen.pixelDensity), 2)) * 0.039370;
        if (diagonal >= 3.5 && diagonal < 5) { //iPhone 1st generation to phablet
          units.multiplier = 1;
          return Device.phone;
        } else if (diagonal >= 5 && diagonal < 6.5) {
          units.multiplier = 1;
          return Device.phablet;
        } else if (diagonal >= 6.5 && diagonal < 10.1) {
          units.multiplier = 1;
          return Device.tablet;
        } else if (diagonal >= 10.1 && diagonal < 29) {
          return Device.desktop;
        } else if (diagonal >= 29 && diagonal < 92) {
          return Device.tv;
        } else {
          return Device.unknown;
        }
      } );
    }

    QtObject {
        id: __theme

        property color primaryColor: Theme.primaryColor
        property color primaryDarkColor: Theme.primaryDarkColor
        property color accentColor: Theme.accentColor
        property color backgroundColor: Theme.backgroundColor

        onPrimaryColorChanged: Theme.primaryColor = primaryColor
        onPrimaryDarkColorChanged: Theme.primaryDarkColor = primaryDarkColor
        onAccentColorChanged: Theme.accentColor = accentColor
        onBackgroundColorChanged: Theme.backgroundColor = backgroundColor
    }
}
