/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtGraphicalEffects 1.0
import Material 0.3

/*!
   \qmltype View
   \inqmlmodule Material

   \brief Provides a base view component, with support for Material Design elevation,
   background colors, and tinting.
 */
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

    default property alias data: rect.data

    property bool elevationInverted: false

    property var topShadow: [
        {
            "opacity": 0,
            "offset": 0,
            "blur": 0
        },

        {
            "opacity": 0.12,
            "offset": 1 * Units.dp,
            "blur": 1.5 * Units.dp
        },

        {
            "opacity": 0.16,
            "offset": 3 * Units.dp,
            "blur": 3 * Units.dp
        },

        {
            "opacity": 0.19,
            "offset": 10 * Units.dp,
            "blur": 10 * Units.dp
        },

        {
            "opacity": 0.25,
            "offset": 14 * Units.dp,
            "blur": 14 * Units.dp
        },

        {
            "opacity": 0.30,
            "offset": 19 * Units.dp,
            "blur": 19 * Units.dp
        }
    ]

    property var bottomShadow: [
        {
            "opacity": 0,
            "offset": 0 * Units.dp,
            "blur": 0 * Units.dp
        },

        {
            "opacity": 0.24,
            "offset": 1 * Units.dp,
            "blur": 1 * Units.dp
        },

        {
            "opacity": 0.23,
            "offset": 3 * Units.dp,
            "blur": 3 * Units.dp
        },

        {
            "opacity": 0.23,
            "offset": 6 * Units.dp,
            "blur": 3 * Units.dp
        },

        {
            "opacity": 0.22,
            "offset": 10 * Units.dp,
            "blur": 5 * Units.dp
        },

        {
            "opacity": 0.22,
            "offset": 15 * Units.dp,
            "blur": 6 * Units.dp
        }
    ]

    RectangularGlow {
        property var elevationInfo: bottomShadow[Math.min(elevation, 5)]
        property real horizontalShadowOffset: elevationInfo.offset * Math.sin((2 * Math.PI) * (parent.rotation / 360.0))
        property real verticalShadowOffset: elevationInfo.offset * Math.cos((2 * Math.PI) * (parent.rotation / 360.0))

        anchors.centerIn: parent
        width: parent.width + (fullWidth ? 10 * Units.dp : 0)
        height: parent.height + (fullHeight ? 20 * Units.dp : 0)
        anchors.horizontalCenterOffset: horizontalShadowOffset * (elevationInverted ? -1 : 1)
        anchors.verticalCenterOffset: verticalShadowOffset * (elevationInverted ? -1 : 1)
        glowRadius: elevationInfo.blur
        opacity: elevationInfo.opacity
        spread: 0.05
        color: "black"
        cornerRadius: item.radius + glowRadius * 2.5
        //visible: parent.opacity == 1
    }

    RectangularGlow {
        property var elevationInfo: topShadow[Math.min(elevation, 5)]
        property real horizontalShadowOffset: elevationInfo.offset * Math.sin((2 * Math.PI) * (parent.rotation / 360.0))
        property real verticalShadowOffset: elevationInfo.offset * Math.cos((2 * Math.PI) * (parent.rotation / 360.0))

        anchors.centerIn: parent
        width: parent.width + (fullWidth ? 10 * Units.dp : 0)
        height: parent.height + (fullHeight ? 20 * Units.dp : 0)
        anchors.horizontalCenterOffset: horizontalShadowOffset * (elevationInverted ? -1 : 1)
        anchors.verticalCenterOffset: verticalShadowOffset * (elevationInverted ? -1 : 1)
        glowRadius: elevationInfo.blur
        opacity: elevationInfo.opacity
        spread: 0.05
        color: "black"
        cornerRadius: item.radius + glowRadius * 2.5
        //visible: parent.opacity == 1
    }

    Rectangle {
        id: rect
        anchors.fill: parent
        color: Qt.tint(backgroundColor, tintColor)
        radius: item.radius
        antialiasing: parent.rotation || radius > 0 ? true : false
        clip: true

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
}
