/*
* QML Material - An application framework implementing Material Design.
* Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
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

Rectangle {
    id: overlayLayer
    objectName: "overlayLayer"

    anchors.fill: parent

    property Item currentOverlay
    color: "transparent"

    states: State {
        name: "ShowState"
        when: overlayLayer.currentOverlay != null

        PropertyChanges {
            target: overlayLayer
            color: currentOverlay.overlayColor
        }
    }

    transitions: Transition {
        ColorAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: overlayLayer.currentOverlay != null && overlayLayer.currentOverlay.globalMouseAreaEnabled
        hoverEnabled: enabled
        onClicked: overlayLayer.currentOverlay.close()
        onWheel: wheel.accepted = true
    }
}
