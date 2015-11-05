/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014-2015 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtQuick.Window 2.2
import Material 0.1

/*!
   \qmltype MainView
   \inqmlmodule Material 0.1

   \brief A root component with support for overlays and configuring the app theme.
 */
Item {
    id: mainView

    /*!
       \qmlproperty AppTheme theme

       A grouped property that allows the application to customize the the primary color, the
       primary dark color, and the accent color. See \l Theme for more details.
     */
    property alias theme: __theme

    AppTheme {
        id: __theme
    }

    OverlayLayer {
        id: dialogOverlayLayer
        objectName: "dialogOverlayLayer"
        z: 100
    }

    OverlayLayer {
        id: tooltipOverlayLayer
        objectName: "tooltipOverlayLayer"
        z: 100
    }

    OverlayLayer {
        id: overlayLayer
        z: 100
    }

    width: Units.dp(800)
    height: Units.dp(600)

    Component.onCompleted: {
        Units.pixelDensity = Qt.binding(function() {
            return Screen.pixelDensity
        });

        Device.type = Qt.binding(function () {
            var diagonal = Math.sqrt(Math.pow((Screen.width/Screen.pixelDensity), 2) +
                    Math.pow((Screen.height/Screen.pixelDensity), 2)) * 0.039370;

            if (diagonal >= 3.5 && diagonal < 5) { //iPhone 1st generation to phablet
                Units.multiplier = 1;
                return Device.phone;
            } else if (diagonal >= 5 && diagonal < 6.5) {
                Units.multiplier = 1;
                return Device.phablet;
            } else if (diagonal >= 6.5 && diagonal < 10.1) {
                Units.multiplier = 1;
                return Device.tablet;
            } else if (diagonal >= 10.1 && diagonal < 29) {
                return Device.desktop;
            } else if (diagonal >= 29 && diagonal < 92) {
                return Device.tv;
            } else {
                return Device.unknown;
            }
        });

        // Nasty hack because singletons cannot import the module they were declared in, so
        // the grid unit cannot be defined in either Device or Units, because it requires both.
        // See https://bugreports.qt.io/browse/QTBUG-39703
        Units.gridUnit = Qt.binding(function() {
            return Device.type === Device.phone || Device.type === Device.phablet
                    ? Units.dp(48) : Device.type == Device.tablet ? Units.dp(56) : Units.dp(64)
        })
    }
}
