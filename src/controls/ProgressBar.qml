/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *               2015 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle
import Material 0.3

/*!
   \qmltype ProgressBar
   \inqmlmodule Material

   \brief Visual indicator of progress in some operation.
*/

Controls.ProgressBar {
    /*!
       The color for the progress bar. By default this is
       the primary color defined in \l Theme::primaryColor
     */
    property color color: Theme.primaryColor

    width: 200 * Units.dp
    height: 4 * Units.dp

    style: MaterialStyle.ProgressBarStyle {}
}
