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
import "Transitions"

Page {
    id: page
    cardStyle: true

    property alias title: label.text

    function show() {
        transition.transitionTo(page)
        card.parent = toolbar.parent
    }

    property bool showing: currentPage

    transition: CardSlideTransition {

    }

    default property alias content: contents.data

    Card {
        id: card
        z: 20
        anchors.horizontalCenter: parent.horizontalCenter

        y: showing ? toolbar.implicitHeight : parent.height
        height: pageStack.height + toolbar.implicitHeight
        width: parent.width * 3/4
        opacity: showing ? 1 : 0

        Behavior on y {
            NumberAnimation { duration: animations.pageTransition }
        }

        Behavior on opacity {
            NumberAnimation { duration: animations.pageTransition }
        }

        Item {
            id: actionBar
            height: toolbar.implicitHeight - 1
            anchors {
                left: parent.left
                right: parent.right
            }

            Label {
                id: label

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: units.dp(16)

                    Behavior on leftMargin {
                        NumberAnimation { duration: 200 }
                    }
                }

                style: "title"
                color: theme.blackColor('secondary')
            }

            Row {
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: units.dp(16)
                }

                spacing: units.dp(24)

                Repeater {
                    model: actions.length > toolbar.maxActionCount ? toolbar.maxActionCount - 1 : actions.length

                    delegate: IconAction {
                        id: iconAction

                        property Action action: actions[index]

                        name: action.iconName
                        //color:
                        size: name == "content/add" ? units.dp(30) : units.dp(27)
                        anchors.verticalCenter: parent ? parent.verticalCenter : undefined

                        onTriggered: action.triggered(iconAction)
                    }
                }

                IconAction {
                    name: "navigation/more_vert"
                    size: units.dp(27)
                    visible: actions.length > toolbar.maxActionCount
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                height: 1
                color: theme.blackColor('divider')
            }
        }

        Item {
            id: contents

            anchors {
                left: parent.left
                right: parent.right
                top: actionBar.bottom
                bottom: parent.bottom
            }
        }
    }
}
