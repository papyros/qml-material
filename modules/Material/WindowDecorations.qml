/*
 * QML Material - An application framework implementing Material Design.
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
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0
import Material 0.1

Object {
    id: windowDecorations
    property var __decorations

    property color color: Theme.primaryDarkColor
    property var window

    onColorChanged: {
        if (__decorations && color != "#000000") {
            updateColor();
        }
    }

    onWindowChanged: {
        if (__decorations) {
            __decorations.window = window
        }
    }

    function updateColor() {
        __decorations.backgroundColor = color
        __decorations.iconColor = Theme.lightDark(color, Theme.light.iconColor,
                Theme.dark.iconColor)
        __decorations.textColor = Theme.lightDark(color, Theme.light.textColor,
                Theme.dark.textColor)
        __decorations.update()
    }

    Component.onCompleted: {
        __decorations = Qt.createQmlObject('import Papyros.Desktop 0.1; WindowDecorations {}',
                windowDecorations, "PapyrosWindowDecorations");

        if (__decorations) {
            __decorations.window = window
            if (color != "#000000")
                updateColor()
        } else {
            console.log("Window decoration customization not supported.")
        }
    }
}
