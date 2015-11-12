/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Jordan Neidlinger <JNeidlinger@gmail.com>
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
import QtQuick.Window 2.2
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3 as Styles
import Material 0.1

/*!
   \qmltype ProgressCircle
   \inqmlmodule Material 0.1

   \brief Visual circular indicator of progress in some operation.
*/
Controls.ProgressBar {
    id: progressBar

    /*!
       The color for the progress circle. By default this is
       the primary color defined in \l Theme::primaryColor
     */
    property color color: Theme.primaryColor

    /*!
       The thickness of the progress circle's stroke,
       3 dp by default
     */
    property real dashThickness: Units.dp(3)

    width: Units.dp(32)
    height: Units.dp(32)

    indeterminate: true

    style: Styles.ProgressBarStyle {
        id: progressBarStyle

        progress: Item {
            anchors.fill: parent

            Canvas {
                id: canvas

                property int ratio: Screen.devicePixelRatio

                width: parent.width * ratio
                height: parent.height * ratio
                anchors.centerIn: parent

                scale: 1/ratio

                onWidthChanged: requestPaint()
                onHeightChanged: requestPaint()

                renderStrategy: Canvas.Threaded
                antialiasing: true
                onPaint: drawSpinner();

                opacity:  visible ? 1.0 : 0

                Behavior on opacity {
                    PropertyAnimation {
                        duration: 800
                    }
                }

                Connections {
                    target: control
                    onColorChanged: canvas.requestPaint()
                    onValueChanged: canvas.requestPaint()
                    onDashThicknessChanged: canvas.requestPaint()
                    onIndeterminateChanged:
                    {
                        if(control.indeterminate)
                        {
                            internal.arcEndPoint = 0
                            internal.arcStartPoint = 0
                            internal.rotate = 0
                        }

                        canvas.requestPaint();
                    }
                }

                QtObject {
                    id: internal

                    property real arcEndPoint: 0
                    onArcEndPointChanged: canvas.requestPaint();

                    property real arcStartPoint: 0
                    onArcStartPointChanged: canvas.requestPaint();

                    property real rotate: 0
                    onRotateChanged: canvas.requestPaint();

                    property real longDash: 3 * Math.PI / 2
                    property real shortDash: 19 * Math.PI / 10
                }

                NumberAnimation {
                    target: internal
                    properties: "rotate"
                    from: 0
                    to: 2 * Math.PI
                    loops: Animation.Infinite
                    running: control.indeterminate && canvas.visible
                    easing.type: Easing.Linear
                    duration: 3000
                }

                SequentialAnimation {
                    running: control.indeterminate && canvas.visible
                    loops: Animation.Infinite

                    ParallelAnimation {
                        NumberAnimation {
                            target: internal
                            properties: "arcEndPoint"
                            from: 0
                            to: internal.longDash
                            easing.type: Easing.InOutCubic
                            duration: 800
                        }

                        NumberAnimation {
                            target: internal
                            properties: "arcStartPoint"
                            from: internal.shortDash
                            to: 2 * Math.PI - 0.001
                            easing.type: Easing.InOutCubic
                            duration: 800
                        }
                    }

                    ParallelAnimation {
                        NumberAnimation {
                            target: internal
                            properties: "arcEndPoint"
                            from: internal.longDash
                            to: 2 * Math.PI - 0.001
                            easing.type: Easing.InOutCubic
                            duration: 800
                        }

                        NumberAnimation {
                            target: internal
                            properties: "arcStartPoint"
                            from: 0
                            to: internal.shortDash
                            easing.type: Easing.InOutCubic
                            duration: 800
                        }
                    }
                }

                function drawSpinner() {
                    var ctx = canvas.getContext("2d");
                    ctx.reset();
                    ctx.clearRect(0, 0, canvas.width, canvas.height);
                    ctx.strokeStyle = control.color
                    ctx.lineWidth = control.dashThickness * canvas.ratio
                    ctx.lineCap = "butt";

                    ctx.translate(canvas.width / 2, canvas.height / 2);
                    ctx.rotate(control.indeterminate ? internal.rotate : currentProgress * (3 * Math.PI / 2));

                    ctx.arc(0, 0, Math.min(canvas.width, canvas.height) / 2 - ctx.lineWidth,
                        control.indeterminate ? internal.arcStartPoint : 0,
                        control.indeterminate ? internal.arcEndPoint : currentProgress * (2 * Math.PI),
                        false);

                    ctx.stroke();
                }
            }
        }

        property Component panel: Item{
            implicitWidth: backgroundLoader.implicitWidth
            implicitHeight: backgroundLoader.implicitHeight

            Item {
                width: parent.width
                height: parent.height
                transformOrigin: Item.TopLeft

                Rectangle {
                    id: backgroundLoader
                    implicitWidth: control.width
                    implicitHeight: control.height
                    color: "transparent"
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
                    width: parent.width - padding.left - padding.right
                }
            }
        }
    }
}
