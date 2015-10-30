/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014-2015 Michael Spencer <sonrisesoftware@gmail.com>
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

pragma Singleton

/*!
   \qmltype Device
   \inqmlmodule Material 0.1

   \brief A singleton that provides information about the current device.
 */
Object {
    id: device

    //some kind of enum, by screen size
    property int type: desktop

    readonly property int phone: 0
    readonly property int phablet: 1
    readonly property int tablet: 2
    readonly property int desktop: 3
    readonly property int tv: 4
    readonly property int unknown: 5 //it's either bigger than tv or smaller than phone
    
    readonly property string name: {
        switch (type) {
            case 0:
                return "phone";
            case 1:
                return "phablet";
            case 2:
                return "tablet";
            case 3:
                return "computer";
            case 4:
                return "TV";
            case 5:
                return "device";
        }
    }
    
    readonly property string iconName: {
        switch (type) {
            case 0:
                return "hardware/smartphone";
            case 1:
                return "hardware/tablet";
            case 2:
                return "hardware/tablet";
            case 3:
                return "hardware/desktop_windows";
            case 4:
                return "hardware/tv";
            case 5:
                return "hardware/computer";
        }
    }

    readonly property bool isMobile: type == phone || type == phablet || type == tablet
}
