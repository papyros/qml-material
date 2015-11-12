/*
 * QML Extras - Extra types and utilities to make QML even more awesome
 *
 * Copyright (C) 2015 Bogdan Cuza
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

import QtQuick 2.4

Grid {
    id: grid

    default property alias delegate: repeater.delegate
    property real cellWidth
    property real cellHeight
    property alias model: repeater.model
    property real widthOverride: parent.width
    property real heightOverride: parent.height
    property real minColumnSpacing


    columns: {
        var flooredResult = Math.floor(widthOverride/cellWidth);
        if (flooredResult >= 1 && flooredResult <= repeater.count)
            if ((widthOverride-(flooredResult*cellWidth))/(flooredResult+1) < minColumnSpacing)
                return flooredResult-1;
            else
                return flooredResult;
        else if (flooredResult > repeater.count)
            return repeater.count;
        else
            return 1;
    }

    columnSpacing: (widthOverride-(columns*cellWidth))/(columns+1) < (minColumnSpacing/2) ? (minColumnSpacing/2) : (widthOverride-(columns*cellWidth))/(columns+1)
    width: widthOverride - 2*columnSpacing
    anchors{
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: rowSpacing
    }

    Repeater {
        id: repeater
    }
}
