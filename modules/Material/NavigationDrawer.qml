/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer <sonrisesoftware@gmail.com>
 *               2015 Pierre Jacquier <pierrejacquier39@gmail.com>
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
import Material 0.1

/*!
   \qmltype NavigationDrawer
   \inqmlmodule Material 0.1

   \brief The navigation drawer slides in from the left and is a common pattern in apps.
 */
PopupBase {
    id: navDrawer
    objectName: "navDrawer"

    overlayLayer: "dialogOverlayLayer"
    overlayColor: Qt.rgba(0, 0, 0, 0.3)

    width: Math.min(parent.width - Units.gu(1), Units.gu(5))

    anchors {
        left: mode === "left" ? parent.left : undefined
        right: mode === "right" ? parent.right : undefined
        top: parent.top
        bottom: parent.bottom

        leftMargin: showing ? 0 : -width - Units.dp(10)
        rightMargin: showing ? 0 : -width - Units.dp(10)

        Behavior on leftMargin {
            NumberAnimation { duration: 200 }
        }       
        Behavior on rightMargin {
            NumberAnimation { duration: 200 }
        }
    }

    property string mode: "left" // or "right"

    property alias enabled: action.visible

    readonly property Action action: action

    onEnabledChanged: {
        if (!enabled)
            close()
    }

    Action {
        id: action
        iconName: "navigation/menu"
        name: "Navigation Drawer"
        onTriggered: navDrawer.toggle()
    }

    View {
        anchors.fill: parent
        fullHeight: true
        elevation: 3
        backgroundColor: "white"
    }
}
