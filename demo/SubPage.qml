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
import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem

Page {
    id: page
    title: "Page Title that is very long to demonstrate eliding titles in ActionBar"

    actionBar.backgroundColor: Palette.colors.grey['200']
    actionBar.decorationColor: Palette.colors.grey['300']

    tabs: [
        // Each tab can have text and an icon
        {
            text: "Overview",
            icon: "action/home"
        },

        // You can also leave out the icon
        {
            text:"Projects",
        },

        // Or just simply use a string
        "Inbox"
    ]

    // TabView is simply a customized ListView
    // You can use any model/delegate for the tab contents,
    // but a VisualItemModel works well
    TabView {
        id: tabView
        anchors.fill: parent
        currentIndex: page.selectedTab
        model: tabs
    }

    VisualItemModel {
        id: tabs

        // Tab 1 "Overview"
        Rectangle {
            width: tabView.width
            height: tabView.height
            color: Palette.colors.red["200"]

            Button {
                anchors.centerIn: parent
                darkBackground: true
                text: "Go to tab 3"
                onClicked: page.selectedTab = 2
            }
        }

        // Tab 2 "Projects"
        Rectangle {
            width: tabView.width
            height: tabView.height
            color: Palette.colors.purple["200"]
        }

        // Tab 3 "Inbox"
        Rectangle {
            width: tabView.width
            height: tabView.height
            color: Palette.colors.orange["200"]
        }
    }
}
