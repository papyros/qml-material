/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer
 * Copyright (C) 2014 Marcin Baszczewski
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
import QtQuick 2.0
import Material.Extras 0.1

MouseArea {
    id: view

    clip: true
    hoverEnabled: enabled
    z: 2

    property int startSize: circleClip ? width/5 : width/3
    property int middleSize: circleClip ? width * 3/4 : width - 10
    property int endSize: circleClip ? width * 3 : width * 1.5

    property Item currentCircle
    property color color: Qt.rgba(0,0,0,0.1)

    property bool circleClip: false

    onPressed: {
        print("PRESSED")

        createTapCircle(mouse.x, mouse.y)
    }

    onCanceled: {
        currentCircle.removeCircle();
    }

    onReleased: {
        currentCircle.removeCircle();
    }

    function createTapCircle(x, y) {
        if (!currentCircle)
            currentCircle = tapCircle.createObject(view, {"circleX": x, "circleY": y });
    }

    Component {
        id: tapCircle

        Item {
            id: circleItem

            anchors.fill: parent

            function removeCircle() {
                circleItem.destroy(200);
                closeAnimation.start();

                currentCircle = null;
            }

            property real circleX
            property real circleY

            Item {
                id: circleParent
                anchors.fill: parent
                visible: !circleClip

                Rectangle {
                    id: circleRectangle

                    x: circleItem.circleX - width/2
                    y: circleItem.circleY - height/2

                    property double size

                    width: size
                    height: size
                    radius: size/2

                    opacity: 0
                    color: view.color

                    ParallelAnimation {
                        id: fillAnimation
                        running: true

                        NumberAnimation { target: circleRectangle; property: "size"; duration: 200; from: startSize; to: middleSize; easing.type: Easing.InOutQuad }
                        NumberAnimation { target: circleRectangle; property: "opacity"; duration: 100; from: 0; to: 1; easing.type: Easing.InOutQuad }
                    }

                    ParallelAnimation {
                        id: closeAnimation

                        NumberAnimation { target: circleRectangle; property: "size"; duration: 200;  to: endSize; easing.type: Easing.InOutQuad }
                        NumberAnimation { target: circleRectangle; property: "opacity"; duration: 200; from: 1; to: 0; easing.type: Easing.InOutQuad }
                    }
                }
            }

            CircleItem {
                anchors.fill: parent
                content: circleParent
                visible: circleClip
            }
        }
    }
}
