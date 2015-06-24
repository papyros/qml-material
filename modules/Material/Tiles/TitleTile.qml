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

/*!
   \qmltype TitleTile
   \inqmlmodule Material 0.1
   \brief An image tile for grid lists, with a title on two lines over a dark scrim.
 */

Item {
    id: tile

    property alias primaryText: primaryText.text
    property alias imageSource: image.source

    property var _view: GridView.view

    width: _view && _view.cellHeight ?
               Math.round(_view.cellWidth - _view.padding) :
               Units.dp(158)
    height: _view && _view.cellHeight ?
                Math.round(_view.cellHeight - _view.padding) :
                Math.round(width * 2/3)

    signal clicked
    signal pressAndHold

    Image {
        id: image

        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }

    Rectangle {
        id: scrim

        height: bar.height * 1.5
        width: parent.width
        anchors.bottom: parent.bottom
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0) }
            GradientStop { position: 0.7; color: Qt.rgba(0,0,0,0.4) }
            GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.8) }
        }
    }

    Item {
        id: bar

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: Units.dp(68)
        anchors.margins: Units.dp(16)

        Label {
            id: primaryText
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            wrapMode: Text.WordWrap
            maximumLineCount: 2
            elide: Text.ElideRight
            text: "Primary text on two lines"
            color: Theme.dark.textColor
            style: "subheading"
        }
    }

    Ink {
        id: ink

        onClicked: tile.clicked()
        onPressAndHold: tile.pressAndHold()

        anchors.fill: parent
    }
}
