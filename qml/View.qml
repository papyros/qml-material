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
import QtGraphicalEffects 1.0

Item {
    id: item
    width: 100
    height: 62

    property int elevation: 0
    property real radius: 0

    property string style: "default"

    property color backgroundColor: elevation > 0 ? "white" : "transparent"
    property color tintColor: "transparent"

    property alias border: rect.border

    property bool fullWidth
    property bool fullHeight

    property alias clipContent: rect.clip

    default property alias content: rect.data

    property bool elevationInverted: false

    property var topShadow: [
        {
            "opacity": 0,
            "offset": Units.dp(0),
            "blur": Units.dp(0)
        },

        {
            "opacity": 0.12,
            "offset": Units.dp(1),
            "blur": Units.dp(1.5)
        },

        {
            "opacity": 0.16,
            "offset": Units.dp(3),
            "blur": Units.dp(3)
        },

        {
            "opacity": 0.19,
            "offset": Units.dp(10),
            "blur": Units.dp(10)
        },

        {
            "opacity": 0.25,
            "offset": Units.dp(14),
            "blur": Units.dp(14)
        },

        {
            "opacity": 0.30,
            "offset": Units.dp(19),
            "blur": Units.dp(19)
        }
    ]

    property var bottomShadow: [
        {
            "opacity": 0,
            "offset": Units.dp(0),
            "blur": Units.dp(0)
        },

        {
            "opacity": 0.24,
            "offset": Units.dp(1),
            "blur": Units.dp(1)
        },

        {
            "opacity": 0.23,
            "offset": Units.dp(3),
            "blur": Units.dp(3)
        },

        {
            "opacity": 0.23,
            "offset": Units.dp(6),
            "blur": Units.dp(3)
        },

        {
            "opacity": 0.22,
            "offset": Units.dp(10),
            "blur": Units.dp(5)
        },

        {
            "opacity": 0.22,
            "offset": Units.dp(15),
            "blur": Units.dp(6)
        }
    ]

    RectangularGlow {
        property var elevationInfo: bottomShadow[Math.min(elevation, 5)]

        anchors.centerIn: parent
        width: parent.width + (fullWidth ? units.dp(10) : 0)
        height: parent.height + (fullHeight ? units.dp(20) : 0)
        anchors.verticalCenterOffset: elevationInfo.offset * (elevationInverted ? -1 : 1)
        glowRadius: elevationInfo.blur
        opacity: elevationInfo.opacity
        spread: 0.05
        color: "black"
        cornerRadius: item.radius + glowRadius * 2.5
    }

    RectangularGlow {
        property var elevationInfo: topShadow[Math.min(elevation, 5)]

        anchors.centerIn: parent
        width: parent.width + (fullWidth ? units.dp(10) : 0)
        height: parent.height + (fullHeight ? units.dp(20) : 0)
        anchors.verticalCenterOffset: elevationInfo.offset * (elevationInverted ? -1 : 1)
        glowRadius: elevationInfo.blur
        opacity: elevationInfo.opacity
        spread: 0.05
        color: "black"
        cornerRadius: item.radius + glowRadius * 2.5
    }

    Rectangle {
        id: rect
        anchors.fill: parent
        color: Qt.tint(backgroundColor, tintColor)
        radius: item.radius

        clip: true

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
}
