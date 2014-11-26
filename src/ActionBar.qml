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
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0

Item {
    id: actionBar

    implicitHeight: device.mode === "mobile"
                    ? units.dp(48) : device.mode == "tablet"
                      ? units.dp(56) : units.dp(64)

    anchors {
        left: parent.left
        right: parent.right
    }

    property string color: "white"

    property Item page

    property int maxActionCount: toolbar.maxActionCount

    property bool showContents: page != undefined && !page.cardStyle

    property color background: theme.primary

    IconAction {
        id: leftItem

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: leftItem.show ? units.dp(16) : -leftItem.width

            Behavior on leftMargin {
                NumberAnimation { duration: 200 }
            }
        }

        color: actionBar.color
        size: units.dp(27)
        name: page.backAction ? page.backAction.iconName : ""

        onTriggered: page.backAction.triggered(leftItem)

        opacity: show ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        property bool show: page && (page.backAction && page.backAction.visible) &&
                            (!page.cardStyle || !showContents)
    }

    Label {
        id: label

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: leftItem.show ? units.dp(72) : units.dp(16)

            Behavior on leftMargin {
                NumberAnimation { duration: 200 }
            }
        }

        text: showContents ? page.title : ""
        fontStyle: "title"
        color: actionBar.color
    }

    Row {
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: units.dp(16)
        }

        spacing: units.dp(24)

        Repeater {
            model: !showContents ? []
                                : page.actions.length > maxActionCount
                                  ? maxActionCount - 1 : page.actions.length

            delegate: IconAction {
                id: iconAction

                property Action action: page.actions[index]

                name: action.iconName
                color: actionBar.color
                size: name == "content/add" ? units.dp(30) : units.dp(27)
                anchors.verticalCenter: parent ? parent.verticalCenter : undefined

                onTriggered: action.triggered(iconAction)
            }
        }

        IconAction {
            name: "navigation/more_vert"
            size: units.dp(27)
            color: actionBar.color
            visible: showContents && page && page.actions.length > maxActionCount
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
