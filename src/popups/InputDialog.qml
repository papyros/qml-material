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
import Material 0.3

/*!
   \qmltype InputDialog
   \inqmlmodule Material

   \brief A dialog with a single text field input.
 */
Dialog {
    id: inputDialog

    hasActions: true

    positiveButtonEnabled: textField.acceptableInput

    property alias textField: textField

    property alias validator: textField.validator
    property alias inputMask: textField.inputMask
    property alias inputMethodHints: textField.inputMethodHints

    property alias placeholderText: textField.placeholderText
    property alias value: textField.text

    TextField {
        id: textField

        anchors {
            left: parent.left
            right: parent.right
        }
    }
}
