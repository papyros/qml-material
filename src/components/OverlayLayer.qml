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

/*!
   \qmltype OverlayLayer
   \inqmlmodule Material

   \brief Provides a layer to display popups and other overlay components.
 */
Rectangle {
    id: overlayLayer
    objectName: "overlayLayer"

    anchors.fill: parent

    property Item currentOverlay
    color: "transparent"

    onEnabledChanged: {
        if (!enabled && overlayLayer.currentOverlay != null)
            overlayLayer.currentOverlay.close()
    }

    onWidthChanged: closeIfNecessary()
    onHeightChanged: closeIfNecessary()

    states: State {
        name: "ShowState"
        when: overlayLayer.currentOverlay != null

        PropertyChanges {
            target: overlayLayer
            color: currentOverlay.overlayColor
        }
    }

    transitions: Transition {
        ColorAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

    function closeIfNecessary() {
        if (overlayLayer.currentOverlay != null && overlayLayer.currentOverlay.closeOnResize)
            overlayLayer.currentOverlay.close()
    }

    MouseArea {
        anchors.fill: parent
        enabled: overlayLayer.currentOverlay != null &&
                overlayLayer.currentOverlay.globalMouseAreaEnabled
        hoverEnabled: enabled

        onWheel: wheel.accepted = true

        onClicked: {
            if (overlayLayer.currentOverlay.dismissOnTap)
                overlayLayer.currentOverlay.close()
        }
    }
}
