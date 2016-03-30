/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2015-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Controls.Styles 1.3
import Material 0.3

ToolBarStyle {
	padding {
        left: 16 * Units.dp
        right: 16 * Units.dp
        top: 0 * Units.dp
        bottom: 0 * Units.dp
    }
    background: View {
        implicitHeight: Device.type == Device.phone || Device.type === Device.phablet
                ? 48 * Units.dp : Device.type == Device.tablet ? 56 * Units.dp : 64 * Units.dp
        fullWidth: true
        elevation: 2

        backgroundColor: Theme.primaryColor
    }
}
