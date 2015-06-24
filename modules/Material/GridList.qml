/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Marco Piccolino <marco.a.piccolino@gmail.com>
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

import QtQuick 2.0
import Material 0.1

GridView {
    id: gridList

    property var breakpoints: [600,1024]
    property int padding: Units.dp(4)
    property string tileRatio: _aspect.indexOf(tileRatio) !== -1 ? tileRatio : "1:1"

    property var _aspect: ["16:9","3:2","4:3","1:1","3:4","2:3"]

    anchors {
        fill: parent
        leftMargin: padding
        topMargin: padding
    }
    clip: true
    cellWidth: {
        var columns = 2
        for (var i=0; i<breakpoints.length; i++) {
            if (parent && parent.width >= Units.dp(breakpoints[i])) {
                columns += 1
            }
        }
        Math.floor(width / columns)
    }
    cellHeight: {
        var ratio = tileRatio.split(":")
        var ratioW =  ratio[0]
        var ratioH =  ratio[1]
        Math.round(cellWidth * ratioH / ratioW)
    }
}

