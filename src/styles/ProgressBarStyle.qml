/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *               2015 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Controls.Styles 1.3
import Material 0.3

ProgressBarStyle {
    id: progressBarStyle

    progress: Rectangle {
        color: control.indeterminate ? "transparent" : control.color

        // Indeterminate animation
        Item {
            id: independentRect
            anchors.fill: parent
            visible: control.indeterminate
            Rectangle {
                id: rect
                property int end: 0
                width: end - x
                height: control.height
                color: control.color
                ParallelAnimation {
                    running: control.indeterminate
                    SequentialAnimation {
                        loops: Animation.Infinite
                        PauseAnimation {
                            duration: 500
                        }

                        NumberAnimation{
                            target: rect; property: "x"
                            from: 0; to: control.width
                            duration: 1500
                            easing.type: Easing.InCubic
                        }
                    }
                    SequentialAnimation {
                        loops: Animation.Infinite
                        NumberAnimation {
                            target: rect; property: "end"
                            from: 0; to: control.width
                            duration: 1500
                        }
                        PauseAnimation {
                            duration: 500
                        }
                        ScriptAction {
                            script: rect.x = 0
                        }
                    }
                }
            }
        }
    }

    panel: Item {
        property bool horizontal: control.orientation == Qt.Horizontal
        implicitWidth: horizontal ? backgroundLoader.implicitWidth : backgroundLoader.implicitHeight
        implicitHeight: horizontal ? backgroundLoader.implicitHeight : backgroundLoader.implicitWidth

        Item {
            width: horizontal ? parent.width : parent.height
            height: !horizontal ? parent.width : parent.height
            y: horizontal ? 0 : width
            rotation: horizontal ? 0 : -90
            transformOrigin: Item.TopLeft

            Rectangle {
                id: backgroundLoader
                implicitWidth: control.width
                implicitHeight: control.height
                color: control.color
                opacity: 0.2
            }

            Loader {
                sourceComponent: progressBarStyle.progress
                anchors.topMargin: padding.top
                anchors.leftMargin: padding.left
                anchors.rightMargin: padding.right
                anchors.bottomMargin: padding.bottom

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                width: currentProgress * (parent.width - padding.left - padding.right)
            }
        }
    }
}
