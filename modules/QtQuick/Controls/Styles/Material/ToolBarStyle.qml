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

import QtQuick 2.4
import QtQuick.Controls.Styles 1.3
import Material 0.1

ToolBarStyle {
	padding {
        left: Units.dp(16)
        right: Units.dp(16)
        top: Units.dp(0)
        bottom: Units.dp(0)
    }
    background: View {
        implicitHeight: Device.type == Device.phone || Device.type === Device.phablet 
                ? Units.dp(48) : Device.type == Device.tablet ? Units.dp(56) : Units.dp(64)
        fullWidth: true
        elevation: 2
        
        backgroundColor: Theme.primaryColor
    }
}
