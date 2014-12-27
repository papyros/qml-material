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

/*!
   \qmltype units
   \inqmlmodule Material 0.1
   \ingroup material

   \brief Provides access to screen-independent units known as DPs (device-independent pixels).

   This singleton provides methods for building a user interface that automatically scales based on
   the screen density. Use the \l units::dp function wherever you need to specify a screen size,
   and your app will automatically scale to any screen density.

   Here is a short example:

   \qml
   import QtQuick 2.0
   import Material 0.1

   Rectangle {
       width: units.dp(100)
       height: units.dp(80)

       Label {
           text:"A"
           font.pixelSize: units.dp(50)
       }
   }
   \endqml
*/
Object {
    id: units

    /*!
       \internal
       This holds the pixel density used for converting millimeters into pixels. This is the exact
       value from \l Screen:pixelDensity, but that property only works from within a \l Window type,
       so this is hardcoded here and we update it from within \l ApplicationWindow
     */
    property real pixelDensity
    property real screenWidth
    property real screenHeight

    /*!
       Converts millimeters into pixels. Used primarily by \l units::dp, but there might be other
       uses for it as well.
     */
     //probably needs modifications as well
    function mm(number) {
        return number * pixelDensity * 1.4
    }

    /*!
       This is the standard function to use for accessing device-independent pixels. You should use
       this anywhere you need to refer to distances on the screen.
     */
    function dp(number) {
        var nr = (pixelDensity*25.4)/160;
        return number*nr*Math.pow(((screenWidth*screenHeight*pixelDensity*25.4)/(320*720*1280)), -1);
    }
}
