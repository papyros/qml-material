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
import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import QtQuick.Controls.Styles 1.2 as ControlStyles
import Material 0.1
import QtGraphicalEffects 1.0

/*!
   \qmltype ActionBar
   \inqmlmodule Material 0.1

   \brief A floating action button.

   An \l ActionButton is a floating action button that provides a primary action
   on the current page.
 */
Controls.Button {
    id: button

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
    property string iconName

    style: ControlStyles.ButtonStyle {
        background: Item {
            RectangularGlow {

                anchors.centerIn: parent
                anchors.verticalCenterOffset: elevation == 1 ? units.dp(1.5)
                                                             : units.dp(1)

                width: parent.width
                height: parent.height

                glowRadius: elevation == 1 ? units.dp(0.75) : units.dp(0.3)
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
            implicitHeight: units.dp(40)
            implicitWidth: units.dp(40)

            Icon {
                id: icon

                anchors.centerIn: parent
                name: control.iconName
                color: button.iconColor
            }
        }
    }
}
