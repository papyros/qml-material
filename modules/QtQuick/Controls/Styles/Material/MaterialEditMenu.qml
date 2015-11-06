/*
 *   Copyright (C) 2015 by Aleix Pol Gonzalez <aleixpol@kde.org>
 *   Copyright (C) 2015 by Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Library General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  2.010-1301, USA.
 */

import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Window 2.1
import QtQuick.Layouts 1.0
import Material 0.1

Item {
    id: root
    anchors.fill: parent

    property bool editing: true
    onEditingChanged: {
        updateCursorOpacity()
    }
    function updateCursorOpacity() {
        var opacity = root.editing ? 0 : 1;
        cursorHandle.opacity = opacity;
        selectionHandle.opacity = opacity;
    }
    Component.onCompleted: updateCursorOpacity()

//     https://www.google.com/design/spec/patterns/selection.html#selection-text-selection
    Component {
        id: editControls
        Item {
            id: popup
            visible: input.activeFocus && !root.editing
            z: 9999

            Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad } }

            parent: Window.contentItem

            function popup(startRect) {
                var mapped = parent.mapFromItem(input, startRect.x, startRect.y);
                var mapWidget = parent.mapFromItem(input.parent, input.x, input.y, input.width, input.height);

                popup.x = Math.min(Math.max(mapWidget.x, mapped.x-bg.anchors.leftMargin), mapWidget.x+mapWidget.width-bg.width);
                popup.y = Math.max(0, mapped.y - bg.height);

                console.log("showing...", popup.x, popup.y, parent)
            }

            View {
                id: bg
                elevation: 1
                anchors {
                    fill: buttons
                    topMargin: -Units.dp(12)
                    bottomMargin: -Units.dp(14)
                    leftMargin: -Units.dp(24)
                    rightMargin: -Units.dp(16)
                }
            }

            RowLayout {
                id: buttons
                spacing: Units.dp(32)
                Button {
                    text: qsTr("Cut")
                    visible: input.selectedText != ""
                    context: "editmenu"
                    onClicked: {
                        control.cut();
                        select(input.cursorPosition, input.cursorPosition);
                    }
                }
                Button {
                    text: qsTr("Copy")
                    visible: input.selectedText != ""
                    context: "editmenu"
                    onClicked: {
                        control.copy();
                        select(input.cursorPosition, input.cursorPosition);
                    }
                }
                Button {
                    text: qsTr("Paste")
                    visible: input.canPaste
                    context: "editmenu"
                    onClicked: {
                        control.paste();
                    }
                }
                Button {
                    text: qsTr("Select All")
                    visible: input.text != ""
                    context: "editmenu"
                    onClicked: {
                        control.selectAll();
                    }
                }

                IconButton {
                    iconName: "navigation/more_vert"
                    visible: control.menu !== null
                    onClicked: {
                        getMenuInstance().popup()
                    }
                }
            }
        }
    }

    Connections {
        target: mouseArea

        onClicked: {
            var pos = input.positionAt(mouse.x, mouse.y)
            input.moveHandles(pos, pos)
            input.activate()
        }
        onPressAndHold: {
            root.editing = false;
            var pos = input.positionAt(mouse.x, mouse.y)
            input.moveHandles(pos, control.selectByMouse ? -1 : pos)
            input.activate()
        }
    }

    Connections {
        target: input
        onSelectionStartChanged: popupTimer.restart()
        onSelectionEndChanged: popupTimer.restart()
        onActiveFocusChanged: {
            popupTimer.restart()
            root.editing = true;
        }
        onTextChanged: root.editing = true;
    }

    Connections {
        target: flickable
        onMovingChanged: popupTimer.restart()
    }

    property Item editControlsInstance: null
    function getEditControlsInstance() {
        // Lazy load the view when first requested
        if (!editControlsInstance) {
            editControlsInstance = editControls.createObject(control);
        }
        return editControlsInstance;
    }

    Timer {
        id: popupTimer
        interval: 200
        onTriggered: {
            if (!root.editing && (input.canPaste || selectionStart !== selectionEnd)) {
                var startRect = input.positionToRectangle(input.selectionStart);

                getEditControlsInstance().popup(startRect);
            }
        }
    }
}
