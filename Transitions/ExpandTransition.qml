import QtQuick 2.0

Item {
    id: trans
    anchors.fill: parent

    Component.onCompleted: parent = pageStack

    default property alias content: transView.children

    property Item source
    property Item page
    property int sourceX
    property int sourceY

    property int targetHeight

    Rectangle {
        id: transView
        visible: false
    }

    function matchBounds(view, view2) {
        var pos = view.mapToItem(trans.parent, 0, 0)

        view2.x = pos.x
        view2.y = pos.y
        view2.width = view.width
        view2.height = view.height

        print('Bounds', view2.x, view2.y, view2.width, view2.height)
    }

    function transitionTo(view, page, args) {
        trans.page = page
        source = view

        matchBounds(source, transView)
        sourceX = transView.x
        sourceY = transView.y

        transView.visible = true

        page.parent = transView
        page.visible = true

        targetHeight = toolbar.parent.height - toolbar.targetHeight

        trans.z = page.z
        animationTo.start()
    }

    function transitionBack() {
        animationBack.start()
    }

    SequentialAnimation {
        id: animationTo
        ParallelAnimation {

            NumberAnimation {
                target: transView
                property: "x"
                to: 0
                duration: 200
            }

            NumberAnimation {
                target: transView
                property: "y"
                to: 0
                duration: 200
            }

            NumberAnimation {
                target: transView
                property: "width"
                to: trans.width
                duration: 200
            }

            NumberAnimation {
                target: transView
                property: "height"
                to: targetHeight
                duration: 200
            }

            NumberAnimation {
                target: page
                property: "opacity"
                to: 1
                duration: 200
            }
        }

        ScriptAction {
            script: {
                page.parent = pageStack
            }
        }
    }

    SequentialAnimation {
        id: animationBack

        ScriptAction {
            script: page.parent = transView
        }

        ParallelAnimation {

            NumberAnimation {
                target: transView
                property: "x"
                to: sourceX
                duration: 200
            }

            NumberAnimation {
                target: transView
                property: "y"
                to: sourceY
                duration: 200
            }

            NumberAnimation {
                target: transView
                property: "width"
                to: source.width
                duration: 200
            }

            NumberAnimation {
                target: transView
                property: "height"
                to: source.height
                duration: 200
            }

            NumberAnimation {
                target: page
                property: "opacity"
                to: 0
                duration: 200
            }
        }

        ScriptAction {
            script: transView.visible = false
        }
    }
}
