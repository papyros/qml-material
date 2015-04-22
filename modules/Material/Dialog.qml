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
    overlayColor: Qt.rgba(0, 0, 0, 0.3)

    opacity: showing ? 1 : 0
    visible: opacity > 0

    width: Math.max(minimumWidth,
                    content.contentWidth + Units.dp(32))

    height: Math.min(Units.dp(350),
                     headerView.height + Units.dp(32) +
                     content.contentHeight +
                     content.topMargin +
                     content.bottomMargin +
                     buttonContainer.height)

    property int minimumWidth: Units.dp(270)

    property alias title: titleLabel.text
    property alias text: textLabel.text

    property string negativeButtonText: "Cancel"
    property string positiveButtonText: "Ok"

    property bool hasActions: true

    default property alias dialogContent: column.data

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
        radius: Units.dp(2)

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: false

            onClicked: {
                mouse.accepted = false
            }
        }

        Item {
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: Units.dp(8)
            }

            clip: true
            height: headerView.height + Units.dp(32)

            View {
                backgroundColor: "white"
                elevation: content.atYBeginning ? 0 : 1
                fullWidth: true

                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }

                height: headerView.height + Units.dp(16)
            }
        }


        Column {
            id: headerView

            spacing: Units.dp(16)

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top

                leftMargin: Units.dp(16)
                rightMargin: Units.dp(16)
                topMargin: Units.dp(16)
            }

            Label {
                id: titleLabel

                width: parent.width
                wrapMode: Text.Wrap
                style: "title"
                visible: text != ""
            }

            Label {
                id: textLabel

                width: parent.width
                wrapMode: Text.Wrap
                style: "dialog"
                visible: text != ""
            }
        }

        Flickable {
            id: content

            contentWidth: column.implicitWidth
            contentHeight: column.height
            clip: true

            anchors {
                left: parent.left
                right: parent.right
                top: headerView.bottom
                topMargin: Units.dp(8)
                bottomMargin: Units.dp(-8)
                bottom: buttonContainer.top
            }

            interactive: contentHeight + Units.dp(8) > height
            bottomMargin: hasActions ? 0 : Units.dp(8)

            Column {
                id: column
                anchors {
                    left: parent.left
                    margins: Units.dp(16)
                }

                width: content.width - Units.dp(32)
                spacing: Units.dp(16)
            }
        }

        Scrollbar {
            flickableItem: content
        }

        Item {
            id: buttonContainer

            anchors {
                bottomMargin: Units.dp(8)
                bottom: parent.bottom
                right: parent.right
                left: parent.left
            }

            height: hasActions ? buttonView.height + Units.dp(8) : 0
            clip: true

            View {
                id: buttonView

                height: hasActions ? positiveButton.implicitHeight + Units.dp(8) : 0
                visible: hasActions

                backgroundColor: "white"
                elevation: content.atYEnd ? 0 : 1
                fullWidth: true
                elevationInverted: true

                anchors {
                    bottom: parent.bottom
                    right: parent.right
                    left: parent.left
                }

                Button {
                    id: negativeButton

                    text: negativeButtonText
                    textColor: Theme.accentColor
                    context: "dialog"

                    anchors {
                        top: parent.top
                        right: positiveButton.left
                        topMargin: Units.dp(8)
                        rightMargin: Units.dp(8)
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
                    context: "dialog"

                    anchors {
                        top: parent.top
                        topMargin: Units.dp(8)
                        rightMargin: Units.dp(16)
                        right: parent.right
                    }

                    onClicked: {
                        close()
                        accepted();
                    }
                }
            }
        }
    }

}
