import QtQuick 2.0

Item {
    id: trans
    anchors.fill: parent

    Component.onCompleted: parent = pageStack

    default property alias content: transView.children

    property Item page

    Rectangle {
        id: transView
        visible: false

        width: parent.width
        height: parent.height
        x: parent.width
    }

    function transitionTo(page) {
        trans.page = page

        page.parent = transView

        page.opacity = 1
        page.visible = true

        transView.visible = true

        trans.z = page.z

        animationTo.start()
    }

    function transitionBack() {
        animationBack.start()
    }

    SequentialAnimation {
        id: animationTo

        NumberAnimation {
            target: transView
            property: "x"
            from: trans.width
            to: 0
            duration: 200
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
            script: {
                page.parent = transView
            }
        }

        NumberAnimation {
            target: transView
            property: "x"
            to: trans.width
            duration: 200
        }

        ScriptAction {
            script: {
                trans.visible = false
            }
        }
    }
}
