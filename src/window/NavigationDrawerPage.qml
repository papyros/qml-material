/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Controls 1.3 as Controls

Page {
    id: navPage

    backAction: navDrawer.action
    title: page.title
    actions: page.actions
    actionBar.backgroundColor: page.actionBar.backgroundColor
    actionBar.decorationColor: page.actionBar.decorationColor

    property var navDrawer

    property var page

    function navigate(page) {
        navPage.page = page
        navDrawer.close()
    }

    onNavDrawerChanged: navDrawer.parent = navPage

    onPageChanged: stackView.push({ item: page, replace: true })

    Controls.StackView {
        id: stackView
        anchors.fill: parent
    }
}
