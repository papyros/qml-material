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
import Material.Extras 0.1 as Extras
import QtGraphicalEffects 1.0

Item {
    id: item

    property alias source: image.source
    property alias status: image.status
    property alias averageColor: image.averageColor
    property alias sourceSize: image.sourceSize
    property alias asynchronous: image.asynchronous
    property alias cache: image.cache
    property alias fillMode: image.fillMode

    width: image.implicitWidth
    height: image.implicitHeight

    Extras.Image {
        id: image
        anchors.fill: parent
        smooth: true
        visible: false
        mipmap: true
    }

    CircleMask {
        anchors.fill: image
        source: image
    }
}
