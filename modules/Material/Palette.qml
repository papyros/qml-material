/*
* QML Material - An application framework implementing Material Design.
* Copyright (C) 2015 Michael Spencer
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

pragma Singleton

Object {
    property var red: {
        '50':   '#ffebee',
        '100':  '#ffcdd2',
        '200':  '#ef9a9a',
        '300':  '#e57373',
        '400':  '#ef5350',
        '500':  '#f44336',
        '600':  '#e53935',
        '700':  '#d32f2f',
        '800':  '#c62828',
        '900':  '#b71c1c',
        'A100': '#ff8a80',
        'A200': '#ff5252',
        'A400': '#ff1744',
        'A700': '#d50000'
    }

    property var pink: {
        '50': '#fce4ec',
        '100': '#f8bbd0',
        '200': '#f48fb1',
        '300': '#f06292',
        '400': '#ec407a',
        '500': '#e91e63',
        '600': '#d81b60',
        '700': '#c2185b',
        '800': '#ad1457',
        '900': '#880e4f',
        'A100': '#ff80ab',
        'A200': '#ff4081',
        'A400': '#f50057',
        'A700': '#c51162'
    }

    property var teal: {
        '50': '#e0f2f1',
        '100': '#b2dfdb',
        '200': '#80cbc4',
        '300': '#4db6ac',
        '400': '#26a69a',
        '500': '#009688',
        '600': '#00897b',
        '700': '#00796b',
        '800': '#00695c',
        '900': '#004d40',
        'A100': '#a7ffeb',
        'A200': '#64ffda',
        'A400': '#1de9b6',
        'A700': '#00bfa5'
    }

    property var colors: {
        'red': red,
        'pink': pink,
        'teal': teal
    }

}
