/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2016 hunt978(bootsing.hoo@gmail.com)
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

import Material 0.2
import QtQuick 2.4
import QtQuick.Window 2.2

/*!
   \qmltype Reziser
   \inqmlmodule Material

   \brief Reziser allow Material apps resize window size under frameless mode
   the app will show a litter icon in right-bottom corner when the mouse hover 
   the area. then user can resize the window by draging the window.
*/
Icon
{
    id : __resizer

    anchors.bottom: parent.bottom
    anchors.right : parent.right

    colorize : true
    color : Theme.primaryColor 
    opacity : (Storage.target.visibility != Window.FullScreen) ? __resizer.opacity : 0

    name : "device/signal_cellular_0_bar"

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        
        property var previousPosition 
        property var enable : (Storage.target.visibility != Window.FullScreen) 
			&& Storage.target.clientSideDecorations

        onPressed: {
            if( enable ){
                previousPosition = Qt.point(mouseX, mouseY)
            }
        }

        onPositionChanged: {
            if (pressedButtons == Qt.LeftButton && enable) {
                var width  = (mouseX - previousPosition.x) + Storage.target.width
                var height = (mouseY - previousPosition.y) + Storage.target.height
                if( width > 0 ){
                    Storage.target.width = width
                }
                if( height > 0 ){
                    Storage.target.height = height
                }
            }
        }

        onEntered : {
            if( enable ){
                cursorShape = Qt.SizeFDiagCursor
                __resizer.opacity = 1            
            }
        }

        onExited : {
            if( enable ){
                 cursorShape = Qt.ArrowCursor
                __resizer.opacity = 0           
            }
        }
    }

    Component.onCompleted: {
        __resizer.opacity = 0
    }
}
