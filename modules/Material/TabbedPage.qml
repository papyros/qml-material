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
import QtQuick.Controls.Styles 1.3 as Styles

/*!
   \qmltype Tab
   \inqmlmodule Material 0.1

   \brief A special page for tabs.

   This adds a full-size TabView to a page add hooks up the tab bar to the TabView.
 */
Page {
    id: page

    tabs: tabView

    default property alias content: tabView.children

    Controls.TabView {
        id: tabView
        
        currentIndex: page.selectedTab
        anchors.fill: parent

        tabsVisible: false

        // Override the style to remove the frame
        style: Styles.TabViewStyle {
            frameOverlap: 0
            frame: Item {}
        }
    }
}
