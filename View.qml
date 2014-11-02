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

    property bool fullWidth: parent && width == parent.width && x == 0
    property bool fullHeight: parent && height == parent.height && y == 0

    property alias clipContent: rect.clip

    default property alias content: rect.data

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

    RectangularGlow {
        property var elevationInfo: bottomShadow[Math.min(elevation, 5)]

        anchors.centerIn: parent
        width: parent.width + (fullWidth ? units.dp(10) : 0)
        height: parent.height + (fullHeight ? units.dp(20) : 0)
        anchors.verticalCenterOffset: elevationInfo.offset
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
        anchors.verticalCenterOffset: elevationInfo.offset
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

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
}
