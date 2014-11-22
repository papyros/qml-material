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

Text {
    id: label
    property string style: "body1"

    property var fontStyles: {
        "display4": {
            "size": 112,
            "font": "light"
        },

        "display3": {
            "size": 56,
            "font": "regular"
        },

        "display2": {
            "size": 45,
            "font": "regular"
        },

        "display1": {
            "size": 34,
            "font": "regular"
        },

        "headline": {
            "size": 24,
            "font": "regular"
        },

        "title": {
            "size": 20,
            "font": "medium"
        },

        "subheading": {
            "size": 16,
            "size_desktop": 15,
            "font": "regular"
        },

        "body2": {
            "size": 14,
            "size_desktop": 13,
            "font": "medium"
        },

        "body1": {
            "size": 14,
            "size_desktop": 13,
            "font": "regular"
        },

        "caption": {
            "size": 12,
            "font": "regular"
        },

        "menu": {
            "size": 14,
            "size_desktop": 13,
            "font": "medium"
        },

        "button": {
            "size": 14,
            "font": "medium"
        }
    }

    property bool desktop: true

    property var fontInfo: fontStyles[style]

    font.pixelSize: 1.3 * units.dp(desktop && fontInfo.size_desktop ? fontInfo.size_desktop : fontInfo.size)
    //font.family: "Roboto"
//    font.weight: {
//        var weight = fontInfo.font

//        if (weight == "medium") {
//            return Font.DemiBold
//        } else if (weight == "regular") {
//            return Font.Normal
//        } else if (weight == "light") {
//            return Font.Light
//        }
//    }

    color: theme.blackColor('text')

    //FontLoader { source: Qt.resolvedUrl("fonts/roboto/Roboto-Regular.ttf") }
    //FontLoader { source: Qt.resolvedUrl("fonts/roboto/Roboto-Medium.ttf") }
    //FontLoader { source: Qt.resolvedUrl("fonts/roboto/Roboto-Bold.ttf") }
}
