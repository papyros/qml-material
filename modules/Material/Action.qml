/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014-2015 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtQuick.Controls 1.3 as Controls
/*!
   \qmltype Action
   \inqmlmodule Material 0.1

   \brief Represents an action shown in an action bar, context menu, or list.

   One of the most common uses of actions is displaying actions in the action bar of a page
   using the \l Page::actions property. See the example for \l Page for more details.
 */
Controls.Action {
    id: action

    /*!
       Set to \c true to display a divider between this action and the next action. Used in lists
       or context menus.
     */
    property bool hasDividerAfter

    /*!
       A URL pointing to an image to display as the icon. By default, this is
       a special URL representing the icon named by \l iconName from the Material Design
       icon collection or FontAwesome. The icon will be colorized using the specificed \l color,
       unless you put ".color." in the filename, for example, "app-icon.color.svg".

       \sa iconName
       \sa Icon
     */
    property string iconSource: "icon://" + iconName

    /*!
       The text displayed for the action.
     */
    property string name

    /*!
      A short summary of the action, which may be displayed depending on the UI showing the
      action. For example, a list of actions could display the summary as the secondary line of
      text.
     */
    property string summary

    /*!
       Set to \c false to hide the action in the UI.
     */
    property bool visible: true

    /*!
       Set to \c true to rotate the icon 90 degrees on mouseover.
     */    
    property bool hoverAnimation: false

    property alias text: action.name
    property alias tooltip: action.summary
}
