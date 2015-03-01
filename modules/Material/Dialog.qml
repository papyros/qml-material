/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014-2015 Michael Spencer <sonrisesoftware@gmail.com>
 * Copyright (C) 2015 Bogdan Cuza <bogdan.cuza@hotmail.com>
 * Copyright (C) 2015 Mikhail Ivchenko <ematirov@gmail.com>
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
import QtQuick.Layouts 1.1
import Material 0.1
import Material.Extras 0.1

PopupBase {
    id: dialog

    overlayLayer: "dialogOverlayLayer"
    overlayColor: Theme.alpha("#000", 0.3)

    opacity: showing ? 1 : 0
    visible: opacity > 0

    width: Math.max(minimumWidth,
                    (placeholder.childrenRect.width +
                     placeholder.anchors.leftMargin +
                     placeholder.anchors.rightMargin))

    height: titleLabel.height +
            titleLabel.anchors.topMargin +
            placeholder.childrenRect.height +
            placeholder.anchors.topMargin +
            placeholder.anchors.bottomMargin +
            buttonContainer.height

    property int minimumWidth: units.dp(240)

    property alias title: titleLabel.text

    property string negativeButtonText: "Cancel"
    property string positiveButtonText: "Ok"

    property bool hasActions: true

    default property alias dialogContent: placeholder.children

    signal accepted()
    signal rejected()

    anchors {
        centerIn: parent
        verticalCenterOffset: showing ? 0 : -(dialog.height/3)
        Behavior on verticalCenterOffset {
            NumberAnimation { duration: 200 }
        }
    }

    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }

    Keys.onEscapePressed: dialog.close()

    function show() {
        open()
    }

    View {
        id: dialogContainer

        anchors.fill: parent
        elevation: 5

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: false

            onClicked: {
                mouse.accepted = false
            }
        }

        Label {
            id: titleLabel

            style: "title"

            anchors {
                top: parent.top
                topMargin: units.dp(16)
                left: parent.left
                leftMargin: units.dp(16)
            }
        }

        Item {
            id: placeholder

            anchors {
                left: parent.left
                right: parent.right
                top: titleLabel.bottom
                bottom: buttonContainer.top

                leftMargin: units.dp(16)
                rightMargin: units.dp(16)
                topMargin: units.dp(16)
                bottomMargin: hasActions ? 0 : units.dp(16)
            }
        }

        Item {
            id: buttonContainer
            width: negativeButton.width + positiveButton.width + units.dp(24)
            height: hasActions ? units.dp(64) : 0
            visible: hasActions

            anchors {
                bottom: parent.bottom
                right: parent.right
            }

            Button {
                id: negativeButton

                text: negativeButtonText
                textColor: Theme.accentColor

                anchors {
                    top: parent.top
                    right: positiveButton.left
                    bottom: parent.bottom
                    topMargin: units.dp(8)
                    rightMargin: units.dp(8)
                    bottomMargin: units.dp(8)
                }

                onClicked: {
                    close();
                    rejected();
                }
            }

            Button {
                id: positiveButton

                text: positiveButtonText
                textColor: Theme.accentColor

                anchors {
                    top: parent.top
                    topMargin: units.dp(8)
                    rightMargin: units.dp(16)
                    bottomMargin: units.dp(8)
                    right: parent.right
                    bottom: parent.bottom
                }

                onClicked: {
                    close()
                    accepted();
                }
            }
        }
    }

}
