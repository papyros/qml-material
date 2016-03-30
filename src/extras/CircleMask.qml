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
import QtGraphicalEffects 1.0

Item {
    id: item

    property alias source: mask.source

    Rectangle {
        id: circleMask
        anchors.fill: parent

        smooth: true
        visible: false

        radius: Math.max(width/2, height/2)
    }

    OpacityMask {
        id: mask

        anchors.fill: parent
        maskSource: circleMask
    }
}
