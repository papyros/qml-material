/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014 Jordan Neidlinger <JNeidlinger@gmail.com>
 *               2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle
import Material 0.3

/*!
   \qmltype CheckBox
   \inqmlmodule Material

   \brief Checkboxes allow the user to select multiple options from a set.
 */
Controls.CheckBox {
    id: checkBox

    /*!
       The checkbox color. By default this is the app's accent color
     */
    property color color: darkBackground ? Theme.dark.accentColor : Theme.light.accentColor

    /*!
       Set to \c true if the checkbox is on a dark background
     */
    property bool darkBackground

    style: MaterialStyle.CheckBoxStyle {}

    Ink {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 4 * Units.dp
        }

        width: 40 * Units.dp
        height: 40 * Units.dp
        color: checkBox.checked ? Theme.alpha(checkBox.color, 0.20)
                                : checkBox.darkBackground ? Qt.rgba(1,1,1,0.1)
                                                          : Qt.rgba(0,0,0,0.1)
        enabled: checkBox.enabled

        circular: true
        centered: true

        onClicked: {
          checkBox.checked = !checkBox.checked
          checkBox.clicked()
        }
    }
}
