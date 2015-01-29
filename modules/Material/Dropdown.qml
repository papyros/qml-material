import QtQuick 2.0
import Material 0.1
import Material.Extras 0.1

Item {
    id: dropdown

    Component.onCompleted: {
        parent = Utils.findRootChild(dropdown, "overlayLayer")
    }

    property int anchor: Item.TopRight

    property bool showing

    default property alias content: view.content

    onShowingChanged: {
        if (showing)
            parent.currentOverlay = dropdown
        else
            parent.currentOverlay = null
    }

    function open(caller, offsetX, offsetY) {
        var position = caller.mapToItem(dropdown.parent, 0, 0)

        if (__internal.left) {
            dropdown.x = position.x
        } else {
            dropdown.x = position.x + caller.width - dropdown.width
        }

        if (__internal.top) {
            dropdown.y = position.y
        } else {
            dropdown.y = position.y + caller.height - dropdown.height
        }

        dropdown.x += offsetX
        dropdown.y += offsetY

        showing = true
    }

    function close() {
        showing = false
    }

    QtObject {
        id: __internal

        property bool left: dropdown.anchor == Item.Left || dropdown.anchor == Item.TopLeft ||
                            dropdown.anchor == Item.BottomLeft
        property bool right: dropdown.anchor == Item.Right || dropdown.anchor == Item.TopRight ||
                             dropdown.anchor == Item.BottomRight
        property bool top: dropdown.anchor == Item.Top || dropdown.anchor == Item.TopLeft ||
                           dropdown.anchor == Item.TopRight
        property bool bottom: dropdown.anchor == Item.Bottom || dropdown.anchor == Item.BottomLeft ||
                              dropdown.anchor == Item.BottomRight
    }

    state: showing ? "open" : "closed"

    states: [
        State {
            name: "closed"
            PropertyChanges {
                target: view
                opacity: 0
                width: 0
                height: 0
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
                target: view
                property: "opacity"
                duration: 400
                easing.type: Easing.InOutQuad
            }

            SequentialAnimation {

                PauseAnimation {
                    duration: 200
                }

                NumberAnimation {
                    target: view
                    property: "width"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }

            NumberAnimation {
                target: view
                property: "height"
                duration: 400
                easing.type: Easing.InOutQuad
            }
        },

        Transition {
            from: "closed"
            to: "open"

            NumberAnimation {
                target: view
                property: "opacity"
                duration: 400
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: view
                property: "width"
                duration: 200
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: view
                property: "height"
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }
    ]

    View {
        id: view

        elevation: 2
        radius: units.dp(2)

        anchors.left: __internal.left ? dropdown.left : undefined
        anchors.right: __internal.right ? dropdown.right : undefined
        anchors.top: __internal.top ? dropdown.top : undefined
        anchors.bottom: __internal.bottom ? dropdown.bottom : undefined
    }
}

