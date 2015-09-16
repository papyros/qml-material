/*
 * QML Extras - Extra types and utilities to make QML even more awesome
 *
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
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.3
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
