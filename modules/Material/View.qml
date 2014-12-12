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
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import Material 0.1

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
            "offset": units.dp(0),
            "blur": units.dp(0)
        },

        {
            "opacity": 0.12,
            "offset": units.dp(1),
            "blur": units.dp(1.5)
        },

        {
            "opacity": 0.16,
            "offset": units.dp(3),
            "blur": units.dp(3)
        },

        {
            "opacity": 0.19,
            "offset": units.dp(10),
            "blur": units.dp(10)
        },

        {
            "opacity": 0.25,
            "offset": units.dp(14),
            "blur": units.dp(14)
        },

        {
            "opacity": 0.30,
            "offset": units.dp(19),
            "blur": units.dp(19)
        }
    ]

    property var bottomShadow: [
        {
            "opacity": 0,
            "offset": units.dp(0),
            "blur": units.dp(0)
        },

        {
            "opacity": 0.24,
            "offset": units.dp(1),
            "blur": units.dp(1)
        },

        {
            "opacity": 0.23,
            "offset": units.dp(3),
            "blur": units.dp(3)
        },

        {
            "opacity": 0.23,
            "offset": units.dp(6),
            "blur": units.dp(3)
        },

        {
            "opacity": 0.22,
            "offset": units.dp(10),
            "blur": units.dp(5)
        },

        {
            "opacity": 0.22,
            "offset": units.dp(15),
            "blur": units.dp(6)
        }
    ]



    property alias device: __device
    property alias animations: __animations
    property alias i18n: __i18n


    QtObject {
        id: __device
        property string mode: "desktop"
    }

    QtObject {
        id: __animations
        property int pageTransition: 250
    }

    QtObject {
        id: __i18n
        function tr(text) {
            return text
        }
    }

    RectangularGlow {
        property var elevationInfo: bottomShadow[Math.min(elevation, 5)]
        property real horizontalShadowOffset: elevationInfo.offset * Math.sin((2 * Math.PI) * (parent.rotation / 360.0))
        property real verticalShadowOffset: elevationInfo.offset * Math.cos((2 * Math.PI) * (parent.rotation / 360.0))

        anchors.centerIn: parent
        width: parent.width + (fullWidth ? units.dp(10) : 0)
        height: parent.height + (fullHeight ? units.dp(20) : 0)
        anchors.horizontalCenterOffset: horizontalShadowOffset * (elevationInverted ? -1 : 1)
        anchors.verticalCenterOffset: verticalShadowOffset * (elevationInverted ? -1 : 1)
        glowRadius: elevationInfo.blur
        opacity: elevationInfo.opacity
        spread: 0.05
        color: "black"
        cornerRadius: item.radius + glowRadius * 2.5
    }

    RectangularGlow {
        property var elevationInfo: topShadow[Math.min(elevation, 5)]
        property real horizontalShadowOffset: elevationInfo.offset * Math.sin((2 * Math.PI) * (parent.rotation / 360.0))
        property real verticalShadowOffset: elevationInfo.offset * Math.cos((2 * Math.PI) * (parent.rotation / 360.0))

        anchors.centerIn: parent
        width: parent.width + (fullWidth ? units.dp(10) : 0)
        height: parent.height + (fullHeight ? units.dp(20) : 0)
        anchors.horizontalCenterOffset: horizontalShadowOffset * (elevationInverted ? -1 : 1)
        anchors.verticalCenterOffset: verticalShadowOffset * (elevationInverted ? -1 : 1)
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
        antialiasing: parent.rotation ? true : false

        clip: true

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
}
