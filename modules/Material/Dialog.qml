/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014-2015 Michael Spencer <sonrisesoftware@gmail.com>
 *               2015 Bogdan Cuza <bogdan.cuza@hotmail.com>
 *               2015 Mikhail Ivchenko <ematirov@gmail.com>
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

/*!
   \qmltype Dialog
   \inqmlmodule Material 0.1
   \brief Dialogs inform users about critical information, require users to make
   decisions, or encapsulate multiple tasks within a discrete process
 */
PopupBase {
    id: dialog

    overlayLayer: "dialogOverlayLayer"
    overlayColor: Qt.rgba(0, 0, 0, 0.3)

    opacity: showing ? 1 : 0
    visible: opacity > 0

    width: Math.max(minimumWidth,
                    content.contentWidth + 2 * contentMargins)

    height: Math.min(parent.height - Units.dp(64),
                     headerView.height + (contentMargins * 2) +
                     content.contentHeight +
                     content.topMargin +
                     content.bottomMargin +
                     (floatingActions ? 0 : buttonContainer.height))

    property int contentMargins: Units.dp(16)

    property int minimumWidth: Units.dp(270)

    property alias title: titleLabel.text
    property alias text: textLabel.text

    /*!
       \qmlproperty Button negativeButton
       The negative button, displayed as the leftmost button on the right of the dialog buttons.
       This is usually used to dismiss the dialog.
     */
    property alias negativeButton: negativeButton

    /*!
       \qmlproperty Button primaryButton
       The primary button, displayed as the rightmost button in the dialog buttons row. This is
       usually used to accept the dialog's action.
     */
    property alias positiveButton: positiveButton

    property string negativeButtonText: "Cancel"
    property string positiveButtonText: "Ok"
    property alias positiveButtonEnabled: positiveButton.enabled

    property bool hasActions: true
    property bool floatingActions: false

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

    Keys.onPressed: {
        if (event.key === Qt.Key_Escape) {
            closeKeyPressed(event)
        }
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            closeKeyPressed(event)
        }
    }

    function closeKeyPressed(event) {
        if (dialog.showing) {
            if (dialog.dismissOnTap) {
                dialog.close()
            }
            event.accepted = true
        }
    }

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
                topMargin: title == "" && text == "" ? 0 : Units.dp(16)
            }

            Label {
                id: titleLabel

                width: parent.width
                wrapMode: Text.Wrap
                style: "title"
                visible: title != ""
            }

            Label {
                id: textLabel

                width: parent.width
                wrapMode: Text.Wrap
                style: "dialog"
                visible: text != ""
            }
        }

        Rectangle {
            anchors.fill: content
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
                topMargin: title == "" && text == "" ? 0 :Units.dp(8)
                bottomMargin: Units.dp(-8)
                bottom: floatingActions ? parent.bottom : buttonContainer.top
            }

            interactive: contentHeight + Units.dp(8) > height
            bottomMargin: hasActions  || contentMargins == 0 ? 0 : Units.dp(8)

            Rectangle {
                Column {
                    id: column
                    anchors {
                        left: parent.left
                        margins: contentMargins
                    }

                    width: content.width - 2 * contentMargins
                    spacing: Units.dp(16)
                }
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

                backgroundColor: floatingActions ? "transparent" : "white"
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
                        right: positiveButton.visible ? positiveButton.left : parent.right
                        topMargin: Units.dp(8)
                        rightMargin: positiveButton.visible ? Units.dp(8) : Units.dp(16)
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
