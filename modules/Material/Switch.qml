/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3 as ControlStyles

import Material 0.1

/*!
   \qmltype Switch
   \inqmlmodule Material 0.1

   \brief On/off switches toggle the state of a single settings option
 */
Controls.Switch {
    id: control

    /*!
       The switch color. By default this is the app's accent color
     */
    property color color: darkBackground ? Theme.dark.accentColor
                                         : Theme.light.accentColor

    /*!
       Set to \c true if the switch is on a dark background
     */
    property bool darkBackground

    style: ControlStyles.SwitchStyle {
        handle: View {
            width: Units.dp(22)
            height: Units.dp(22)
            radius: height / 2
            elevation: 2
            backgroundColor: control.enabled ? control.checked ? control.color
                                                               : darkBackground ? "#BDBDBD"
                                                                                : "#FAFAFA"
                                             : darkBackground ? "#424242"
                                                              : "#BDBDBD"
        }

        groove: Item {
            width: Units.dp(40)
            height: Units.dp(22)

            Rectangle {
                anchors.centerIn: parent
                width: parent.width - Units.dp(2)
                height: Units.dp(16)
                radius: height / 2
                color: control.enabled ? control.checked ? Theme.alpha(control.color, 0.5)
                                                         : darkBackground ? Qt.rgba(1, 1, 1, 0.26)
                                                                          : Qt.rgba(0, 0, 0, 0.26)
                                       : darkBackground ? Qt.rgba(1, 1, 1, 0.12)
                                                        : Qt.rgba(0, 0, 0, 0.12)

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
        }
    }
}
