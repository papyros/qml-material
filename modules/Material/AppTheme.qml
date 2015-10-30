/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtQuick 2.4
import Material 0.1

/*!
   \qmltype AppTheme
   \inqmlmodule Material 0.1

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

