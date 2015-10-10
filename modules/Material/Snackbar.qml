/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Bogdan Cuza <bogdan.cuza@hotmail.com>
 *               2014-2015 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtQuick.Layouts 1.1
import Material 0.1

/*!
   \qmltype Snackbar
   \inqmlmodule Material 0.1

   \brief Snackbars provide lightweight feedback about an operation
 */
View {
    id: snackbar

    property string buttonText
    property color buttonColor: Theme.accentColor
    property string text
    property bool opened
    property int duration: 2000
    property bool fullWidth: Device.type === Device.phone || Device.type === Device.phablet

    signal clicked

    function open(text) {
        snackbar.text = text
        opened = true;
        timer.restart();
    }

    anchors {
        left: fullWidth ? parent.left : undefined
        right: fullWidth ? parent.right : undefined
        bottom: parent.bottom
        bottomMargin: opened ? 0 :  -snackbar.height
        horizontalCenter: fullWidth ? undefined : parent.horizontalCenter

        Behavior on bottomMargin {
            NumberAnimation { duration: 300 }
        }
    }
    radius: fullWidth ? 0 : Units.dp(2)
    backgroundColor: "#323232"
    height: snackLayout.height
    width: fullWidth ? undefined : snackLayout.width
    opacity: opened ? 1 : 0

    Timer {
        id: timer

        interval: snackbar.duration

        onTriggered: {
            if (!running) {
                snackbar.opened = false;
            }
        }
    }

    RowLayout {
        id: snackLayout

        anchors {
            verticalCenter: parent.verticalCenter
            left: snackbar.fullWidth ? parent.left : undefined
            right: snackbar.fullWidth ? parent.right : undefined
        }

        spacing: 0

        Item {
            width: Units.dp(24)
        }

        Label {
            id: snackText
            Layout.fillWidth: true
            Layout.minimumWidth: snackbar.fullWidth ? -1 : Units.dp(216) - snackButton.width
            Layout.maximumWidth: snackbar.fullWidth ? -1 :
                Math.min(Units.dp(496) - snackButton.width - middleSpacer.width - Units.dp(48),
                         snackbar.parent.width - snackButton.width - middleSpacer.width - Units.dp(48))

            Layout.preferredHeight: lineCount == 2 ? Units.dp(80) : Units.dp(48)
            verticalAlignment: Text.AlignVCenter
            maximumLineCount: 2
            wrapMode: Text.Wrap
            elide: Text.ElideRight
            text: snackbar.text
            color: "white"
        }

        Item {
            id: middleSpacer
            width: snackbar.buttonText == "" ? 0 : snackbar.fullWidth ? Units.dp(24) : Units.dp(48)
        }

        Button {
            id: snackButton
            textColor: snackbar.buttonColor
            visible: snackbar.buttonText != ""
            text: snackbar.buttonText
            context: "snackbar"
            width: visible ? implicitWidth : 0
            onClicked: snackbar.clicked()
        }

        Item {
            width: Units.dp(24)
        }
    }

    Behavior on opacity {
        NumberAnimation { duration: 300 }
    }
}
