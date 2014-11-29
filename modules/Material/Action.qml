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

/*!
   \qmltype Action
   \inqmlmodule Material 0.1
   \ingroup material

   \brief Represents an action shown in an action bar, context menu, or list.
 */
QtObject {
    id: action

	/*!
	   The text displayed for the action.
	 */
    property string name

    /*!
       The icon displayed for the action. This can be a Material Design icon or an icon from
       FontAwesome. See \l Icon from more details.
     */
    property string iconName

    /*!
      A short summary of the action, which may be displayed depending on the UI showing the
      action. For example, a list of actions could display the summary as the secondary line of
      text.
     */
    property string summary

	/*!
	   Set to \c true to display a divider between this action and the next action. Used in lists
	   or context menus.
	 */
    property bool hasDividerAfter

    /*!
       Set to \c false to hide the action in the UI.
     */
    property bool visible: true

    /*!
       Set to \c false to disable the action.
     */
    property bool enabled: true

	/*!
	   Called when the UI representing the action is triggered. \c caller contains the UI element
	   that triggered the action.
	 */
    signal triggered(var caller)
}
