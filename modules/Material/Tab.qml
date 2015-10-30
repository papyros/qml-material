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
import QtQuick.Controls 1.3 as Controls

/*!
   \qmltype Tab
   \inqmlmodule Material 0.1

   \brief Tab represents the content of a tab in a TabView.

   This extends the QtQuick.Controls Tab component to add iconName and iconSource properties.
 */
Controls.Tab {
	
	/*!
       The icon displayed for the action. This can be a Material Design icon or an icon from
       FontAwesome. See \l Icon from more details.
     */
	property string iconName

	/*!
       A URL pointing to an image to display as the icon. By default, this is
       a special URL representing the icon named by \l iconName from the Material Design
       icon collection or FontAwesome. The icon will be colorized using the specificed \l color,
       unless you put ".color." in the filename, for example, "app-icon.color.svg".

       \sa iconName
       \sa Icon
     */
    property string iconSource: "icon://" + iconName
}

