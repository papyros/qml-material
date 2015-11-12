/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Jordan Neidlinger
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
import Material 0.1
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

/*!
   \qmltype Slider
   \inqmlmodule Material 0.1

   \brief Sliders let users select a value from a continuous or discrete range of 
   values by moving the slider thumb.
 */
Controls.Slider {
    id: slider

    /*!
       Set to \c true to enable a float numeric value label above the slider knob
     */
    property bool numericValueLabel: false

    /*!
       Set to \c true if the switch is on a dark background
     */
    property bool darkBackground

    property color color: darkBackground ? Theme.dark.accentColor
                                         : Theme.light.accentColor

    tickmarksEnabled: false

    implicitHeight: numericValueLabel ? Units.dp(54) : Units.dp(32)
    implicitWidth: Units.dp(200)

    style: MaterialStyle.SliderStyle {}
}
