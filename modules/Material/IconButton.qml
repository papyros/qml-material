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
import QtQuick 2.0
import Material 0.1
import Material.Extras 0.1

Item {
    id: iconButton

    width: icon.width
    height: icon.height
    
    enabled: action ? action.enabled : true

    property string name: action ? action.iconName : ""
    property alias color: icon.color
    property alias size: icon.size

    signal clicked

    onClicked: {
        if (action) action.triggered(icon)
    }

    opacity: enabled ? 1 : 0.6

    property Action action

    Ink {
        id: ink

        anchors.centerIn: parent

        enabled: iconButton.enabled
        centered: true
        circular: true

        width: parent.width + Units.dp(20)
        height: parent.height + Units.dp(20)

        z: 0

        onClicked: {
            iconButton.clicked()
        }

        onPressAndHold: {
            if(tooltip.tooltipText !== "" && !tooltip.showing)
                tooltip.open(ink, 0, Units.dp(4))
        }

        onReleased: {
            if(tooltip.showing)
                tooltip.close()
        }

        onEntered: {
            if(tooltip.tooltipText !== "" && !tooltip.showing)
                tooltip.open(ink, 0, Units.dp(4))
        }

        onExited: {
            if(tooltip.showing)
                tooltip.close()
        }
    }

    Icon {
        id: icon

        name: iconButton.name
    }

    Tooltip {
        id: tooltip

        property alias tooltipText : tooltipLabel.text

        internalView.backgroundColor: Qt.rgba(0.2, 0.2, 0.2, 0.9)
        width: tooltipLabel.paintedWidth + Units.dp(32)
        height: Units.dp(44)

        Label {
            id: tooltipLabel
            style: "tooltip"
            color: Theme.dark.textColor
            anchors.centerIn: parent
            text: action ? action.name : ""
        }
    }
}
