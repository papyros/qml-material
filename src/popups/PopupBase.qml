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
import QtQuick.Window 2.2
import Material 0.3
import Material.Extras 0.1

/*!
   \qmltype PopupBase
   \inqmlmodule Material

   \brief A base class for popups such as dialogs or dropdowns.
 */
FocusScope {
    id: popup

    property color overlayColor: "transparent"
    property string overlayLayer: "overlayLayer"
    property bool globalMouseAreaEnabled: true
    property bool dismissOnTap: true
    property bool showing: false
    property bool closeOnResize: false
    property Item __lastFocusedItem

    signal opened
    signal closed

    function toggle(widget) {
        if (showing) {
            close()
        } else {
            open(widget)
        }
    }

    function open() {
        __lastFocusedItem = Window.activeFocusItem
        parent = Utils.findRootChild(popup, overlayLayer)

        if (!parent.enabled)
            return

        showing = true
        forceActiveFocus()
        parent.currentOverlay = popup

        opened()
    }

    function close() {
        showing = false

        if (parent.hasOwnProperty("currentOverlay")) {
            parent.currentOverlay = null
        }

        if (__lastFocusedItem !== null) {
            __lastFocusedItem.forceActiveFocus()
        }

        closed()
    }
}
