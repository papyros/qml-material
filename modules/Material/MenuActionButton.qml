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
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle
import Material 0.1
import Material.Extras 0.1

/*!
   \qmltype ActionButton
   \inqmlmodule Material 0.1

   \brief A floating action button with a menu.

   An ActionButton is a floating action button that provides a primary action
   on the current page.
 */
ActionButton {
    id: actionButton
    property string selectedIconName: "navigation/close"
    property string selectedIconSource: "icon://" + selectedIconName

    property list<Action> actions

    property bool closeOnTap: true

    property bool opened

    signal triggered(var caller)

    onTriggered: {
        if (action)
            action.triggered(caller)
    }

    onClicked: {
        if (opened) {
            if (closeOnTap) opened = false

            triggered(actionButton)
        } else {
            opened = true
        }
    }

    Column {
        id: column

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.top
            bottomMargin: Units.dp(16)
        }

        spacing: Units.dp(8)

        Repeater {
            id: actionsRepeater
            model: actions
            delegate: ActionButton {
                id: menuItem
                isMiniSize: true
                action: modelData
                opacity: 0
                scale: 0.5

                states: [
                    State {
                        name: "opened"
                        when: opened

                        PropertyChanges {
                            target: menuItem
                            opacity: 1
                            scale: 1
                        }
                    }
                ]

                transitions: [
                    Transition {
                        from: "*"
                        to: "opened"

                        SequentialAnimation {
                            PauseAnimation {
                                duration: (actionsRepeater.count - index) * 25
                            }

                            ParallelAnimation {
                                NumberAnimation {
                                    target: menuItem; property: "scale"; duration: 100;
                                    easing.type: Easing.OutQuad
                                }

                                NumberAnimation {
                                    target: menuItem; property: "opacity"; duration: 100
                                    easing.type: Easing.OutQuad
                                }   
                            }  
                        }
                    }
                ]
            }
        }
    }

    style: MaterialStyle.ActionButtonStyle {
        label: Item {
            implicitHeight: control.isMiniSize ? Units.dp(40) : Units.dp(56)
            implicitWidth: implicitHeight
            Icon {
                id: icon

                anchors.centerIn: parent
                source: control.iconSource
                color: control.iconColor
                size: Units.dp(24)
                opacity: opened ? 0 : 1
                rotation: opened ? 0 : -90

                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }

                Behavior on rotation {
                    NumberAnimation { duration: 200 }
                }
            }

            Icon {
                id: selectedIcon

                anchors.centerIn: parent
                source: control.selectedIconSource
                color: control.iconColor
                size: Units.dp(24)
                opacity: opened ? 1 : 0
                rotation: opened ? 90 : 0

                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }

                Behavior on rotation {
                    NumberAnimation { duration: 200 }
                }
            }
        }
    }
}
