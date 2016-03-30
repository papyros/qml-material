/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2015-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Controls.Styles 1.3
import Material 0.3

SwitchStyle {
    id: style

    property color color: control.hasOwnProperty("color")
            ? control.color : Theme.light.accentColor

    property bool darkBackground: control.hasOwnProperty("darkBackground")
            ? control.darkBackground : false

    handle: View {
        width: 22 * Units.dp
        height: 22 * Units.dp

        radius: height/2

        elevation: 2
        backgroundColor: control.enabled ? control.checked ? color : darkBackground ? "#BDBDBD"
                                                                                    : "#FAFAFA"
                                         : darkBackground ? "#424242" : "#BDBDBD"
    }

    groove: Item {
        width: 40 * Units.dp
        height: 22 * Units.dp

        Rectangle {

            anchors.centerIn: parent

            width: parent.width - 2 * Units.dp
            height: 16 * Units.dp

            radius: height/2

            color: control.enabled ? control.checked ? Theme.alpha(style.color, 0.5)
                                                     : darkBackground ? Qt.rgba(1, 1, 1, 0.26)
                                                                      : Qt.rgba(0, 0, 0, 0.30)
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
