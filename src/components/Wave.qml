/***** THIS FILE CANNOT BE RELICENSED UNDER THE MPL YET *****/

/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Bogdan Cuza <bogdan.cuza@hotmail.com>
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

import QtQuick 2.4

/*!
   \qmltype Wave
   \inqmlmodule Material

   \brief Provides a wave animation for transitioning between views of content.
 */
Rectangle {
    id: wave

    property bool opened
    property real size
    property real initialX
    property real initialY
    property real abstractWidth: parent.width
    property real abstractHeight: parent.height
    property real diameter: 2*Math.sqrt(Math.pow(Math.max(initialX, abstractWidth - initialX), 2) + Math.pow(Math.max(initialY, abstractHeight - initialY), 2))

    signal finished(bool opened)

    function open(x, y) {
        wave.initialX = x;
        wave.initialY = y;
        wave.opened = true;
    }

    function close(x, y) {
        wave.initialX = x;
        wave.initialY = y;
        wave.opened = false;
    }

    width: size
    height: size
    radius: size/2
    x: initialX - size/2
    y: initialY - size/2

    states: State {
        name: "opened"
        when: wave.opened

        PropertyChanges {
            target: wave
            size: wave.diameter
        }
    }

    transitions: Transition {
        from: ""
        to: "opened"
        reversible: true

        SequentialAnimation {
            NumberAnimation {
                property: "size"
                easing.type: Easing.OutCubic
            }
            ScriptAction {
                script: wave.finished(wave.opened)
            }
        }
    }
}
