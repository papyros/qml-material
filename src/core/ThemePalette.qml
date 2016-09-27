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
   \qmltype Theme
   \inqmlmodule Material

   \brief Provides access to standard colors that follow the Material Design specification, but
   specifically designed for light or dark surfaces.

   See \l {http://www.google.com/design/spec/style/color.html#color-ui-color-application} for
   details about choosing a color scheme for your application.
 */
QtObject {
    id: palette

    property bool light

    readonly property color textColor: light ? shade(0.87) : shade(1)
    readonly property color subTextColor: light ? shade(0.54) : shade(0.70)
    readonly property color iconColor: light ? subTextColor : textColor
    readonly property color disabledColor: light ? shade(0.38) : shade(0.50)
    readonly property color hintColor: disabledColor
    readonly property color dividerColor: shade(0.12)

    /*!
       A version of the accent color specifically for lighter or darker backgrounds. This is
       normally the same as the global \l Theme::accentColor, but for some application's color
       schemes, the accent color is too dark or too light  and a lighter/darker version is needed
       for some surfaces. This can be customized via the \l ApplicationWindow::theme group property.
       According to the Material Design guidelines, this should taken from a second color palette
       that complements the primary color palette at
       \l {http://www.google.com/design/spec/style/color.html#color-color-palette}.
    */
    property color accentColor: theme.accentColor

    function shade(alpha) {
        if (light) {
            return Qt.rgba(0,0,0,alpha)
        } else {
            return Qt.rgba(1,1,1,alpha)
        }
    }
}
