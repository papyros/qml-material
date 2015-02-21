/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer
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
import QtQuick.Controls 1.2 as Controls
import Material 0.1

Controls.StackView {
    id: stackView

    signal pushed(Item page)
    signal popped()
    signal replaced(Item page)

    property int __lastDepth: 0
    property Item __oldItem: null

    onCurrentItemChanged: {
        if (stackView.currentItem) {
            stackView.currentItem.canGoBack = stackView.depth > 1;

            if (__lastDepth > stackView.depth) {
                popped();
            } else if (__lastDepth < stackView.depth) {
                pushed(stackView.currentItem);
            } else {
                replaced(stackView.currentItem);
            }
        }

        __lastDepth = stackView.depth;
    }
}
