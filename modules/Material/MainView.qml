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

Item {
    id: app

    //opacity: 0.5

    width: units.gu(120)
    height: units.gu(80)

    default property alias content: contents.data

    property alias theme: __theme

    Theme {
        id: __theme
    }

    property alias units: __units

    property real scale: Screen.pixelDensity * 1.2// pixels/mm

    property alias device: __device

    QtObject {
        id: __device

        property string mode: "desktop"
    }

    property alias animations: __animations

    QtObject {
        id: __animations

        property int pageTransition: 250
    }

    QtObject {
        id: __units

        function mm(number) {
            return number * scale
        }

        function dp(number) {
            return number * scale * 0.15
        }

        function gu(number) {
            return dp(number * 8)
        }
    }

    property alias i18n: __i18n

    QtObject {
        id: __i18n

        function tr(text) {
            return text
        }
    }

    Rectangle {
        id: contents
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }

        color: theme.defaultBackground

        Rectangle {
            id: overlay
            anchors.fill: parent
            color: "black"
            opacity: drawer && drawer.showing ? 0.4 : 0
            visible: opacity > 0
            z: 10

            MouseArea {
                anchors.fill: parent
                onClicked: drawer.close()
            }
        }
    }

    property NavigationDrawer drawer
}
