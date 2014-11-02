import QtQuick 2.0

MouseArea {
    id: view

    property int startSize: width/2
    property int endSize: width - 10
    z: 2

    hoverEnabled: true

    onClicked: {
        print("TAPPED")
        focusAnimation.stop()
        tapAnimation.restart()
    }

    ParallelAnimation {
        id: tapAnimation

        ColorAnimation { target: tapCircle; property: "color"; to: Qt.rgba(0,0,0,0.1); duration: 200 }

        NumberAnimation { target: tapCircle; property: "height"; duration: 200; from: startSize; to: endSize; easing.type: Easing.InOutQuad }

        SequentialAnimation {
            NumberAnimation { target: tapCircle; property: "opacity"; duration: 100; from: 0; to: 1; easing.type: Easing.InOutQuad }
            NumberAnimation { target: tapCircle; property: "opacity"; duration: 100; from: 1; to: 0; easing.type: Easing.InOutQuad }
        }

        onRunningChanged: {
            if (!running && focused) {
                focusAnimation.restart()
            }
        }
    }

    property bool focused: false

    onFocusedChanged: {
        if (focused) {
            tapAnimation.stop()
            focusAnimation.restart()
        }
    }

    ParallelAnimation {
        id: focusAnimation

        ColorAnimation { target: tapCircle; property: "color"; to: Qt.rgba(0,0,0,0.05); duration: 200 }

        NumberAnimation { target: tapCircle; property: "opacity"; duration: 200; from: 0; to: 1; easing.type: Easing.InOutQuad }

        SequentialAnimation {
            loops: Animation.Infinite;

            NumberAnimation { target: tapCircle; property: "height"; duration: 600; from: view.width - 25; to: view.width - 15; easing.type: Easing.InOutQuad }

            NumberAnimation { target: tapCircle; property: "height"; duration: 600; to: view.width - 25; from: view.width - 15; easing.type: Easing.InOutQuad }
        }
    }

    clip: true

    Rectangle {
        id: tapCircle
        anchors.centerIn: parent

        height: view.height * 2
        width: height
        radius: width/2

        opacity: 0
        color: Qt.rgba(0,0,0,0.1)//Qt.rgba(9/16,9/16,9/16,0.4)
    }
}
