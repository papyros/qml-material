/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4

/*!
   \qmltype Units
   \inqmlmodule Material

   \brief Provides access to screen-independent Units known as DPs (device-independent pixels).

   This singleton provides methods for building a user interface that automatically scales based on
   the screen density. Use the \l Units::dp function wherever you need to specify a screen size,
   and your app will automatically scale to any screen density.

   Here is a short example:

   \qml
   import QtQuick 2.4
   import Material 0.3

   Rectangle {
       width: dp(100)
       height: dp(80)

       Label {
           text:"A"
           font.pixelSize: dp(50)
       }
   }
   \endqml
*/
Object {
    id: units

    /*!
       This is the standard function to use for accessing device-independent pixels. You should use
       this anywhere you need to refer to distances on the screen.
     */
    function dp(number) {
        return Math.round(number * dp);
    }

    function gu(number) {
        return dp(number * Device.gridUnit)
    }
}
