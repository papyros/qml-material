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
import Material 0.1

/*!
   \qmltype Subheader
   \inqmlmodule Material.ListItems 0.1

   \brief Subheaders are special list tiles that delineate distinct sections of a list or grid list.
 */
View {
    id: listItem

    //----- STYLE PROPERTIES -----//

    height: Units.dp(48)
    property int margins: Units.dp(16)

    anchors {
        left: parent.left
        right: parent.right
    }

    property int spacing

    property alias text: label.text
    property alias style: label.style

    Label {
        id: label

        style: "body1"

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            margins: margins
        }

        color: Theme.light.subTextColor
    }

    property bool showDivider: false

    ThinDivider {
        anchors.bottom: parent.bottom
        visible: showDivider
    }
}
