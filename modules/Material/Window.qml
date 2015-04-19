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
import QtQuick 2.2
import Material 0.1
import QtQuick.Window 2.2

/*!
   \qmltype Window
   \inqmlmodule Material 0.1

   \brief A subclass of \l Window that provides some additional features for developing Applications
   that conform to Material Design.

   Here is a short working example of an application:

   \qml
   import QtQuick 2.0
   import Material 0.1

   Window {
       title: "Application Name"
   }
   \endqml
*/
Window {
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
}
