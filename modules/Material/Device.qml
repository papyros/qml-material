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

pragma Singleton

Object {
    id: device

    //some kind of enum, by screen size
    property int type
    
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
                break;
            case 1:
                return "phablet";
                break;
            case 2:
                return "tablet";
                break;
            case 3:
                return "computer";
                break;
            case 4:
                return "TV";
                break;
            case 5:
                return "device";
                break;
        }
    }
    
    readonly property string iconName: {
        switch (type) {
            case 0:
                return "hardware/smartphone";
                break;
            case 1:
                return "hardware/tablet";
                break;
            case 2:
                return "hardware/tablet";
                break;
            case 3:
                return "hardware/desktop_windows";
                break;
            case 4:
                return "hardware/tv";
                break;
            case 5:
                return "hardware/computer";
                break;
        }
    }

    readonly property bool isMobile: type == phone || type == tablet
}
