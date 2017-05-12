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
import Material 0.3
import Material.Extras 0.1

/*!
   \qmltype Tooltip
   \inqmlmodule Material

   \brief A tooltip is a label that appears on hover and explains a non-text UI element.

   To display a tooltip for your view, simply create an instance of Tooltip,
   set the text property to your tooltip text, and then set the mouseArea property
   to your MouseArea or Ink that will trigger the tooltip. If you use a MouseArea,
   make sure hoverEnabled is set to true.

   See the Material Design guidelines for more details:
   http://www.google.com/design/spec/components/tooltips.html
 */
PopupBase {
    id: popover

    visible: view.opacity > 0
    closeOnResize: true

    property bool isBelow

    property alias backgroundColor: view.backgroundColor

    property int padding: 16 * Units.dp

    default property alias data: view.data

    function open(caller, offsetX, offsetY) {
        parent = Utils.findRootChild(popover, overlayLayer)

        if (!parent.enabled)
            return

        if (parent.currentOverlay)
            parent.currentOverlay.close()

        if(typeof offsetX === "undefined")
            offsetX = 0

        if(typeof offsetY === "undefined")
            offsetY = 0

        var position = caller.mapToItem(popover.parent, 0, 0)
        var globalPos = caller.mapToItem(null, 0, 0)
        var root = Utils.findRoot(popover)

        popover.x = Qt.binding(function() {
            var x = position.x + (caller.width / 2 - popover.width / 2) + offsetX

            if(x + width > root.width - padding)
                x = root.width - width - padding

            if (x < padding)
                x = padding

            return x
        })

        popover.y = Qt.binding(function() {
            var y = y = position.y + caller.height + offsetY

            if (y + popover.height > root.height - padding) {
                isBelow = false
                y = position.y - popover.height - offsetY
            } else {
                isBelow = true
            }

            return y
        })

        showing = true
        parent.currentOverlay = popover

        opened()
    }

    function close() {
        showing = false
        parent.currentOverlay = null
    }

    View {
        id: view

        elevation: 2
        radius: 2 * Units.dp

        anchors {
            left: parent.left
            right: parent.right
            top: isBelow ? parent.top : undefined
            topMargin: popover.showing ? 0 : -popover.height/4
            bottom: !isBelow ? parent.bottom : undefined
            bottomMargin: popover.showing ? 0 : -popover.height/4

            Behavior on topMargin {
                NumberAnimation { duration: 200 }
            }

            Behavior on bottomMargin {
                NumberAnimation { duration: 200 }
            }
        }

        height: popover.height

        opacity: popover.showing ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }
}
