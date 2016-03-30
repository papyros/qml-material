/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *               2014 Bogdan Cuza <bogdan.cuza@hotmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Layouts 1.1
import Material 0.3

/*!
   \qmltype Snackbar
   \inqmlmodule Material

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
    radius: fullWidth ? 0 : 2 * Units.dp
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
            width: 24 * Units.dp
        }

        Label {
            id: snackText
            Layout.fillWidth: true
            Layout.minimumWidth: snackbar.fullWidth ? -1 : 216 * Units.dp - snackButton.width
            Layout.maximumWidth: snackbar.fullWidth ? -1 :
                Math.min(496 * Units.dp - snackButton.width - middleSpacer.width - 48 * Units.dp,
                         snackbar.parent.width - snackButton.width - middleSpacer.width - 48 * Units.dp)

            Layout.preferredHeight: lineCount == 2 ? 80 * Units.dp : 48 * Units.dp
            verticalAlignment: Text.AlignVCenter
            maximumLineCount: 2
            wrapMode: Text.Wrap
            elide: Text.ElideRight
            text: snackbar.text
            color: "white"
        }

        Item {
            id: middleSpacer
            width: snackbar.buttonText == "" ? 0 : snackbar.fullWidth ? 24 * Units.dp : 48 * Units.dp
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
            width: 24 * Units.dp
        }
    }

    Behavior on opacity {
        NumberAnimation { duration: 300 }
    }
}
