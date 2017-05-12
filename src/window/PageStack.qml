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
import QtQuick.Controls 1.3 as Controls
import Material 0.3

/*!
   \qmltype PageStack
   \inqmlmodule Material

   \brief Manages the page stack used for navigation.
*/
Controls.StackView {
    id: stackView

    signal pushed(Item page)
    signal popped(Item page)
    signal replaced(Item page)

    property int __lastDepth: 0
    property Item __oldItem: null

    onCurrentItemChanged: {
        if (stackView.currentItem) {
            stackView.currentItem.canGoBack = stackView.depth > 1;
            stackView.currentItem.forceActiveFocus()

            if (__lastDepth > stackView.depth) {
                popped(stackView.currentItem);
            } else if (__lastDepth < stackView.depth) {
                pushed(stackView.currentItem);
            } else {
                replaced(stackView.currentItem);
            }
        }

        __lastDepth = stackView.depth;
    }
}
