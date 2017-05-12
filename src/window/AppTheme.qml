/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2015-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import Material 0.3

/*!
   \qmltype AppTheme
   \inqmlmodule Material

   \brief A helper class used in \l ApplicationWindow to set your app's theme colors.
 */
QtObject {
    id: appTheme

    /*!
       The accent theme color used in your app for a highlight color in many UI components.
       This is a helper property to set \l Theme::accentColor.
     */
    property string accentColor

    /*!
       The default background color used throughout the app. This is a helper property
       to set \l Theme::backgroundColor.
     */
    property string backgroundColor
    property string tabHighlightColor


    /*!
       The primary theme color used in your app for the toolbar and other primary UI elements.
       This is a helper property to set \l Theme::primaryColor.
     */
    property string primaryColor

    /*!
       A darker version of the primary theme color used by the system status bar and
       window decorations. This is a helper property to set \l Theme::primaryDarkColor.
     */
    property string primaryDarkColor: primaryColor

    onPrimaryColorChanged: Theme.primaryColor = getColor(primaryColor, "500")
    onPrimaryDarkColorChanged: Theme.primaryDarkColor = getColor(primaryDarkColor, "700")
    onAccentColorChanged: Theme.accentColor = getColor(accentColor, "A200")
    onBackgroundColorChanged: Theme.backgroundColor = getColor(backgroundColor, "500")
    onTabHighlightColorChanged: Theme.tabHighlightColor = getColor(tabHighlightColor, "500")

    function getColor(color, shade) {
        if (Palette.colors.hasOwnProperty(color)) {
            return Palette.colors[color][shade]
        } else {
            return color
        }
    }
}
