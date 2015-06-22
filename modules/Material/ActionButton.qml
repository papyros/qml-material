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
import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle
import Material 0.1

/*!
   \qmltype ActionButton
   \inqmlmodule Material 0.1

   \brief A floating action button.

   An ActionButton is a floating action button that provides a primary action
   on the current page.
 */
Controls.Button {
    id: button

    property Action action

    /*!
       The color of the action button. By default, this is the accent color of your
       app as defined by \l Theme::accentColor.
     */
    property color backgroundColor: action && action.backgroundColor.a > 0 
            ? action.backgroundColor : Theme.accentColor

    /*!
       \internal
       The elevation of the icon. This will be higher for a white background color.
     */
    property int elevation: backgroundColor == "white" ? 0 : 1

    /*!
       The color of the icon displayed on the action button. By default, this is
       automatically selected based on the \l backgroundColor.
     */
    property color iconColor: Theme.lightDark(button.backgroundColor,
                                              Theme.light.iconColor,
                                              Theme.dark.iconColor)

    /*!
       The name of the icon to display in the action button, selected from the Material
       Design icon collection by Google.
     */
    property string iconName

    property string iconSource: action ? action.iconSource : "icon://" + iconName

    /*!
       Floating action buttons come in two sizes:

       \list
       \li \b {Default size} - for most use cases
       \li \b {Mini size} - only used to create visual continuity with other screen elements
       \endlist
     */
    property bool isMiniSize: false

    property bool containsMouse

    onClicked: {
        if (action)
            action.triggered(button)
    }

    style: MaterialStyle.ActionButtonStyle {}
}
