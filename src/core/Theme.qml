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

pragma Singleton

/*!
   \qmltype Theme
   \inqmlmodule Material

   \brief Provides access to standard colors that follow the Material Design specification.

   See \l {http://www.google.com/design/spec/style/color.html#color-ui-color-application} for
   details about choosing a color scheme for your application.
 */
Object {
    id: theme

    /*!
       The primary color used for the toolbar background unless a page specifies its own color.
       This can be customized via the \l ApplicationWindow::theme group property. According to the
       Material Design guidelines, this should normally be a 500 color from one of the color
       palettes at \l {http://www.google.com/design/spec/style/color.html#color-color-palette}.
     */
    property color primaryColor: "#FAFAFA"

    /*!
       A darker version of the primary color used for the window titlebar (if client-side
       decorations are not used), unless a \l Page specifies its own primary and primary dark
       colors. This can be customized via the \l ApplicationWindow::theme group property. According
       to the Material Design guidelines, this should normally be the 700 color version of your
       aplication's primary color, taken from one of the color palettes at
       \l {http://www.google.com/design/spec/style/color.html#color-color-palette}.
    */
    property color primaryDarkColor: Qt.rgba(0,0,0, 0.54)

    /*!
       The accent color complements the primary color, and is used for any primary action buttons
       along with switches, sliders, and other components that do not specifically set a color.
       This can be customized via the  \l ApplicationWindow::theme group property. According
       to the Material Design guidelines, this should taken from a second color palette that
       complements the primary color palette at
       \l {http://www.google.com/design/spec/style/color.html#color-color-palette}.
    */
    property color accentColor: "#2196F3"

    /*!
       The default background color for the application.
     */
    property color backgroundColor: "#f3f3f3"

    /*!
       The color of the higlight indicator for selected tabs. By default this is the accent color,
       but it can also be white (for a dark primary color/toolbar background).
     */
    property color tabHighlightColor: accentColor

    /*!
       Standard colors specifically meant for light surfaces. This includes text colors along with
       a light version of the accent color.
     */
    property ThemePalette light: ThemePalette {
        light: true
    }

    /*!
       Standard colors specifically meant for dark surfaces. This includes text colors along with
       a dark version of the accent color.
    */
    property ThemePalette dark: ThemePalette {
        light: false
    }

    /*!
       A utility method for changing the alpha on colors. Returns a new object, and does not modify
       the original color at all.
     */
    function alpha(color, alpha) {
        // Make sure we have a real color object to work with (versus a string like "#ccc")
        var realColor = Qt.darker(color, 1)

        realColor.a = alpha

        return realColor
    }

    /*!
       Select a color depending on whether the background is light or dark.

       \c lightColor is the color used on a light background.

       \c darkColor is the color used on a dark background.
     */
    function lightDark(background, lightColor, darkColor) {
        return isDarkColor(background) ? darkColor : lightColor
    }

    /*!
       Returns true if the color is dark and should have light content on top
     */
    function isDarkColor(background) {
        var temp = Qt.darker(background, 1)

        var a = 1 - ( 0.299 * temp.r + 0.587 * temp.g + 0.114 * temp.b);

        return temp.a > 0 && a >= 0.3
    }

    Component.onCompleted: {
        try {
            var code = 'import Material.Fonts 0.1; MaterialFontLoader {}'
            Qt.createQmlObject(code, theme, "MaterialFontLoader")
        } catch (error) {
            // Ignore the error; it only means that the fonts were not enabled
        }
    }
}
