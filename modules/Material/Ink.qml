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

MouseArea {
    id: view

    clip: true
    hoverEnabled: true
    z: 2

    property int startSize: width/3
    property int endSize: width - 10

    property Item currentCircle
    property color color: Qt.rgba(0,0,0,0.1)

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
            currentCircle = tapCircle.createObject(view, {"x": x, "y": y });
    }

    Component {
        id: tapCircle

        Item
        {
            id: circleItem

            function removeCircle()
            {
                circleItem.destroy(200);
                closeAnimation.start();

                currentCircle = null;
            }

            Rectangle {
                id: circleRectangle
                anchors.centerIn: parent

                property double size: view.height * 2

                width: size
                height: size
                radius: size/2

                opacity: 0
                color: view.color

                ParallelAnimation {
                    id: fillAnimation
                    running: true

                    NumberAnimation { target: circleRectangle; property: "size"; duration: 200; from: startSize; to: endSize; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: circleRectangle; property: "opacity"; duration: 100; from: 0; to: 1; easing.type: Easing.InOutQuad }
                }

                ParallelAnimation {
                    id: closeAnimation

                    NumberAnimation { target: circleRectangle; property: "size"; duration: 200;  to: endSize*1.5; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: circleRectangle; property: "opacity"; duration: 200; from: 1; to: 0; easing.type: Easing.InOutQuad }
                }
            }
        }
    }
}
