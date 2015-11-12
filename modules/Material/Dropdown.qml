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
import QtQuick.Window 2.2
import Material 0.1
import Material.Extras 0.1

/*!
   \qmltype Dropdown
   \inqmlmodule Material 0.1

   \brief Represents a dropdown menu that can display a variety of content.
 */
PopupBase {
    id: dropdown

    default property alias data: view.data
    property int anchor: Item.TopRight
    property alias internalView: view

    visible: view.opacity > 0
    closeOnResize: true

    function open(caller, offsetX, offsetY) {
        __lastFocusedItem = Window.activeFocusItem
        parent = Utils.findRootChild(dropdown, overlayLayer)

        if (!parent.enabled)
            return

        if (parent.currentOverlay)
            parent.currentOverlay.close()

        if(typeof offsetX === "undefined")
            offsetX = 0

        if(typeof offsetY === "undefined")
            offsetY = 0

        var position = caller.mapToItem(dropdown.parent, 0, 0)

        // Check to make sure we are within the window bounds, move if we need to
        var globalPos = caller.mapToItem(null, 0, 0)
        var root = Utils.findRoot(dropdown)

        if (__internal.left) {
            dropdown.x = position.x
        } else if (__internal.center) {
            dropdown.x = caller.width / 2 - dropdown.width / 2
        } else {
            dropdown.x = position.x + caller.width - dropdown.width
        }

        if (__internal.top) {
            dropdown.y = position.y
        } else if (__internal.center) {
            dropdown.y = caller.height / 2 - dropdown.height / 2
        } else {
            dropdown.y = position.y + caller.height - dropdown.height
        }

        dropdown.x += offsetX
        dropdown.y += offsetY

        if(dropdown.y + height > root.height)
            dropdown.y += -((dropdown.y + height + Units.dp(16)) - root.height)
        if(dropdown.x + width > root.width)
            dropdown.x += -((dropdown.x + width + Units.dp(16)) - root.width)

        showing = true
        parent.currentOverlay = dropdown

        opened()
    }

    QtObject {
        id: __internal

        property bool left: dropdown.anchor == Item.Left || dropdown.anchor == Item.TopLeft ||
        dropdown.anchor == Item.BottomLeft
        property bool right: dropdown.anchor == Item.Right || dropdown.anchor == Item.TopRight ||
        dropdown.anchor == Item.BottomRight
        property bool top: dropdown.anchor == Item.Top || dropdown.anchor == Item.TopLeft ||
        dropdown.anchor == Item.TopRight
        property bool bottom: dropdown.anchor == Item.Bottom ||
        dropdown.anchor == Item.BottomLeft ||
        dropdown.anchor == Item.BottomRight
        property bool center: dropdown.anchor == Item.Center
    }

    View {
        id: view
        elevation: 2
        radius: Units.dp(2)
        anchors.left: __internal.left ? parent.left : undefined
        anchors.right: __internal.right ? parent.right : undefined
        anchors.top: __internal.top ? parent.top : undefined
        anchors.bottom: __internal.bottom ? parent.bottom : undefined
        anchors.horizontalCenter: __internal.center ? parent.horizontalCenter : undefined
        anchors.verticalCenter: __internal.center ? parent.verticalCenter : undefined
    }

    state: showing ? "open" : "closed"

    states: [
        State {
            name: "closed"
            PropertyChanges {
                target: view
                opacity: 0
            }
        },

        State {
            name: "open"
            PropertyChanges {
                target: view
                opacity: 1
                width: dropdown.width
                height: dropdown.height
            }
        }
    ]

    transitions: [
        Transition {
            from: "open"
            to: "closed"

            NumberAnimation {
                target: internalView
                property: "opacity"
                duration: 400
                easing.type: Easing.InOutQuad
            }

            SequentialAnimation {

                PauseAnimation {
                    duration: 200
                }

                NumberAnimation {
                    target: internalView
                    property: "width"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }

            NumberAnimation {
                target: internalView
                property: "height"
                duration: 400
                easing.type: Easing.InOutQuad
            }
        },

        Transition {
            from: "closed"
            to: "open"

            NumberAnimation {
                target: internalView
                property: "opacity"
                duration: 400
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: internalView
                property: "width"
                duration: 200
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: internalView
                property: "height"
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }
    ]
}
