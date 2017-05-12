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

pragma Singleton

/*!
   \qmltype MaterialAnimation
   \inqmlmodule Material

   \brief A singleton with common animation durations.
 */
QtObject {
    id: materialAnimation

    property int pageTransitionDuration: 250
}
