/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer
 * Copyright (C) 2015 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
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
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3 as Styles
import Material 0.1

/*!
   \qmltype ProgressBar
   \inqmlmodule Material
   \ingroup material

   \brief Visual indicator of progress in some operation.
*/

Controls.ProgressBar {
    /*!
       The color for the progress bar. By default this is
       the primary color defined in \l Theme::primaryColor
     */
    property color color: Theme.primaryColor

    width: units.dp(200)
    height: units.dp(4)

    style: Styles.ProgressBarStyle {
        background: Rectangle {
            width: control.width
            height: control.height
            color: control.color
            opacity: 0.2
        }
        progress: Rectangle {
            color: control.indeterminate ? "transparent" : control.color

            // Indeterminate animation
            Item {
                id: independentRect
                anchors.fill: parent
                visible: control.indeterminate
                Rectangle {
                    id: rect
                    property var end: 0
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
    }
}
