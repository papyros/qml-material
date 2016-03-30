/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2015-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3 as ControlStyles
import Material 0.3
import QtGraphicalEffects 1.0

/*!
   \qmltype ActionButton
   \inqmlmodule Material

   \brief A floating action button.

   An ActionButton is a floating action button that provides a primary action
   on the current page.
 */
Controls.Button {
    id: button

    visible: action ? action.visible : true

    /*!
       The color of the action button. By default, this is the accent color of your
       app as defined by \l Theme::accentColor.
     */
    property color backgroundColor: Theme.accentColor

    /*!
       \internal
       The elevation of the icon. This will be higher for a white background color.
     */
    property int elevation: backgroundColor == "white" ? 0 : 1

    /*!
       The color of the icon displayed on the action button. By default, this is
       automatically selected based on the \l backgroundColor.
     */
    property color iconColor: Theme.lightDark(button.backgroundColor,
                                              Theme.light.iconColor,
                                              Theme.dark.iconColor)

    /*!
       The name of the icon to display in the action button, selected from the Material
       Design icon collection by Google.
     */
    property string iconName: action ? action.iconName : ""

    /*!
       Floating action buttons come in two sizes:

       \list
       \li \b {Default size} - for most use cases
       \li \b {Mini size} - only used to create visual continuity with other screen elements
       \endlist
     */
    property bool isMiniSize: false

    style: ControlStyles.ButtonStyle {
        padding {
            left: 0
            right: 0
            top: 0
            bottom: 0
        }

        background: Item {
            RectangularGlow {

                anchors.centerIn: parent
                anchors.verticalCenterOffset: elevation == 1 ? 1.5 * Units.dp
                                                             : 1 * Units.dp

                width: parent.width
                height: parent.height

                glowRadius: elevation == 1 ? 0.75 * Units.dp : 0.3 * Units.dp
                opacity: elevation == 1 ? 0.6 : 0.3
                spread: elevation == 1 ? 0.7 : 0.85
                color: "black"
                cornerRadius: height/2
            }

            View {
                anchors.fill: parent
                radius: width/2

                backgroundColor: button.backgroundColor

                tintColor: control.pressed ||
                           (control.focus && !button.elevation) ||
                           (control.hovered && !button.elevation) ?
                           Qt.rgba(0,0,0, control.pressed ? 0.1 : 0.05) : "transparent"

                Ink {
                    id: mouseArea
                    anchors.fill: parent
                    Connections {
                        target: control.__behavior
                        onPressed: mouseArea.onPressed(mouse)
                        onCanceled: mouseArea.onCanceled()
                        onReleased: mouseArea.onReleased(mouse)
                    }

                    circular: true
                }
            }
        }
        label: Item {
            implicitHeight: isMiniSize ? 40 * Units.dp : 56 * Units.dp
            implicitWidth: implicitHeight
            Icon {
                id: icon

                anchors.centerIn: parent
                name: control.iconName
                color: button.iconColor
                size: 24 * Units.dp
            }
        }
    }
}
