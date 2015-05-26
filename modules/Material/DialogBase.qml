import QtQuick 2.0

PopupBase {
    id: dialogBase

    overlayLayer: "dialogOverlayLayer"
    overlayColor: Qt.rgba(0, 0, 0, 0.3)

    opacity: showing ? 1 : 0
    visible: opacity > 0

    default property alias content: dialogContent.data

    signal shown()
    signal hidden()

    anchors {
        centerIn: parent
        verticalCenterOffset: showing ? 0 : -(dialogBase.height/3)

        Behavior on verticalCenterOffset {
            NumberAnimation {
                duration: 200
                onRunningChanged: {
                    if(!running && showing)
                        shown()
                    else if(!running && !showing)
                        hidden()
                }
            }
        }
    }

    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }

    function show() {
        open()
    }

    View {
        elevation: 5
        anchors.fill: parent

        MouseArea {
            id: mainMouseArea
            anchors.fill: parent
            propagateComposedEvents: false
            z: 0
            onClicked: {
                console.log("Clicked")
                mouse.accepted = false
            }
        }

        Item {
            id: dialogContent
            anchors.fill: parent
            z: 1
        }
    }
}

