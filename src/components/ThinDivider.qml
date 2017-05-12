/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import Material 0.3

/*!
   \qmltype ThinDivider
   \inqmlmodule Material

   \brief A 1dp high divider for use in lists and other columns of content.
 */
Rectangle {
    anchors {
        left: parent.left
        right: parent.right
    }

    property bool darkBackground

    color: darkBackground ? Theme.dark.hintColor : Theme.light.hintColor
    height: 1
}
