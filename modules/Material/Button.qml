/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer
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
import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import Material 0.1 as Material

Button {

    property bool raised: false
    property color textColor: style === 'default' ? theme.blackColor("text") : theme.styleColor(style)

    height: units.dp(36)
    width: Math.max(units.dp(64),buttonStyle.label.width + units.dp(16))

    style: ButtonStyle {
        id: buttonStyle
        background: View {
            height: control.height
            width: control.width
            radius: units.dp(2)
            tintColor: mouseArea.pressed ? Qt.rgba(0,0,0, 0.1) : "transparent"
            Material.Ink {
                id: mouseArea
                anchors.fill: parent
                onClicked: {
                    mouseArea.focused = true
                    control.clicked()
                }
            }
        }

        label: Material.Label {
            id: buttonLabel
            height: fontMetrics.height
            width: fontMetrics.boundingRect(buttonLabel.text)
            text: control.text.toUpperCase()
            FontMetrics {
                id: fontMetrics
                font: buttonLabel.font
            }
        }
    }
}
