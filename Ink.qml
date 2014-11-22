/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
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
