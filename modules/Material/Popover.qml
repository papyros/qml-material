import QtQuick 2.0
import Material 0.1
import Material.Extras 0.1

Item {
    id: dropdown

    property string overlayLayer: "overlayLayer"

    Component.onCompleted: {
        parent = Utils.findRootChild(dropdown, overlayLayer)
    }

    property int anchor: Item.TopRight

    property bool showing
    property color backdropColor: "transparent"

    default property alias data: view.data
    property alias internalView: view

    onShowingChanged: {
        if (showing)
        {
            parent.currentOverlay = dropdown
        }
        else
            parent.currentOverlay = null
    }

    function open(caller, offsetX, offsetY) {
        if(typeof offsetX === "undefined")
            offsetX = 0

        if(typeof offsetY === "undefined")
            offsetY = 0

        var position = caller.mapToItem(dropdown.parent, 0, 0)

        // Check to make sure we are within the window bounds, move if we need to
        var globalPos = caller.mapToItem(null, 0, 0)
        var root = Utils.findRoot(dropdown)

        if(globalPos.y + height > root.height)
            offsetY = -((globalPos.y + height + units.dp(16)) - root.height)
        if(globalPos.x + width > root.width)
            offsetX = -((globalPos.x + width + units.dp(16)) - root.width)

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
        property bool center: dropdown.anchor == Item.Center
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

    View {
        id: view
        elevation: 2
        radius: units.dp(2)
        anchors.left: __internal.left ? dropdown.left : undefined
        anchors.right: __internal.right ? dropdown.right : undefined
        anchors.top: __internal.top ? dropdown.top : undefined
        anchors.bottom: __internal.bottom ? dropdown.bottom : undefined
        anchors.horizontalCenter: __internal.center ? dropdown.horizontalCenter : undefined
        anchors.verticalCenter: __internal.center ? dropdown.verticalCenter : undefined
    }
}
