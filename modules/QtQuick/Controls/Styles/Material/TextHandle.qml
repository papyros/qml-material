/*
 *   Copyright (C) 2015 by Aleix Pol Gonzalez <aleixpol@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Library General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  2.010-1301, USA.
 */

import QtQuick 2.1
import Material 0.1

Rectangle {
    id: root
    property int side: 0 //-1 left, 0 center, 1 right

    width: Units.dp(22)
    height: Units.dp(22)

    radius: width
    y: styleData.lineHeight

    Rectangle {
        id: rect
        width: parent.width/2
        height: parent.height/2
        color: parent.color
    }

    states: [
        State {
            when: side<0
            name: "right"
            PropertyChanges { target: root; x: -width}
            AnchorChanges { target: rect; anchors.right: parent.right }
        },
        State {
            when: side>0
            name: "left"
            AnchorChanges { target: rect; anchors.left: parent.left }
        },
        State {
            when: side==0
            name: "center"
            PropertyChanges { target: rect; rotation: 45 }
            PropertyChanges { target: rect; width: root.width/Math.SQRT2 }
            PropertyChanges { target: rect; height: rect.width }
            PropertyChanges { target: rect; x: (root.width-rect.width)/2 }

            PropertyChanges { target: root; y: styleData.lineHeight/*+root.height/2*/ }
            PropertyChanges { target: root; x: -root.width/2 }
        }
    ]
}
