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
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3 as Styles

/*!
   \qmltype TabbedPage
   \inqmlmodule Material

   \brief A special page for tabs.

   This adds a full-size TabView to a page add hooks up the tab bar to the TabView.
 */
Page {
    id: page

    default property alias content: tabView.data

    /*!
     * The currently selected tab.
     *
     * \since 0.3
     */
    readonly property Tab selectedTab: tabView.count > 0
            ? tabView.getTab(selectedTabIndex) : null

    tabs: tabView

    onSelectedTabIndexChanged: tabView.currentIndex = page.selectedTabIndex

    Controls.TabView {
        id: tabView

        currentIndex: page.selectedTabIndex
        anchors.fill: parent

        tabsVisible: false

        // Override the style to remove the frame
        style: Styles.TabViewStyle {
            frameOverlap: 0
            frame: Item {}
        }

        onCurrentIndexChanged: page.selectedTabIndex = currentIndex

        onCountChanged: {
            for (var i = 0; i < count; i++) {
                var tab = getTab(i)
                if (tab.hasOwnProperty("index"))
                    tab.index = i
                if (tab.hasOwnProperty("__tabView"))
                    tab.__tabView = tabView
            }
        }
    }
}
