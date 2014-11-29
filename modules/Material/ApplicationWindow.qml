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
import QtQuick.Window 2.2
import Material 0.1

Window {
    id: app

    width: units.dp(800)
    height: units.dp(600)

    property real __pixelDensity: Screen.pixelDensity

    on__PixelDensityChanged: units.__pixelDensity = __pixelDensity

    default property alias content: pageStack.children

    property alias theme: __theme

    QtObject {
        id: __theme

        property color primaryColor: Theme.primaryColor
        property color primaryDarkColor: Theme.primaryDarkColor
        property color secondaryColor: Theme.secondaryColor
        property color backgroundColor: Theme.backgroundColor

        onPrimaryColorChanged: Theme.primaryColor = primaryColor
        onPrimaryDarkColorChanged: Theme.primaryDarkColor = primaryDarkColor
        onSecondaryColorChanged: Theme.secondaryColor = secondaryColor
        onBackgroundColorChanged: Theme.backgroundColor = backgroundColor
    }

    property alias initialPage: pageStack.initialPage

    Toolbar {
        id: toolbar
        z: 2

        backgroundColor: pageStack.currentPage ? pageStack.currentPage.actionBar.background
                                                    : Theme.primaryColor

        tabs: pageStack.currentPage.tabs
        expanded: pageStack.currentPage.cardStyle
    }

    property alias pageStack: pageStack
    property alias toolbar: toolbar

    PageStack {
        id: pageStack

        anchors {
            left: parent.left
            right: parent.right
            top: toolbar.bottom
            bottom: parent.bottom
        }

        onPagePushed: toolbar.pushActionBar(newPage, oldPage)
        onPagePopped: toolbar.popActionBar(previousPage, currentPage)
    }
}
