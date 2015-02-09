import QtQuick 2.0
import Material 0.1
import Material.Extras 0.1

Popover {
    id: dropdown

    anchor: Item.TopRight

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

