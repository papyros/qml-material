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
import Material 0.3

/*!
   \qmltype MainView
   \inqmlmodule Material

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

    PlatformExtensions {
        id: platformExtensions
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

    width: dp(800)
    height: dp(600)

    // Units

    function dp(dp) {
        return dp * Units.dp
    }

    function gu(gu) {
        return units.gu(gu)
    }

    UnitsHelper {
        id: units
    }
}
