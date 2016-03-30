/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import Material 0.3
import "awesome.js" as Awesome

/*!
   \qmltype AwesomeIcon
   \inqmlmodule Material

   \brief Displays an icon from the FontAwesome icon collection.

   Most of the time, this is used indirectly by the \l Icon component, which
   is used by action bars, list items, and many other common Material components.
 */
Item {
    id: widget

    property string name
    property bool rotate: widget.name.match(/.*-rotate/) !== null
    property bool valid: text.implicitWidth > 0

    property alias color: text.color
    property int size: 24 * Units.dp

    width: text.width
    height: text.height

    property bool shadow: false

    property var icons: Awesome.map

    property alias weight: text.font.weight

    FontLoader { id: fontAwesome; source: Qt.resolvedUrl("FontAwesome.otf") }

    Text {
        id: text
        anchors.centerIn: parent

        property string name: widget.name.match(/.*-rotate/) !== null ? widget.name.substring(0, widget.name.length - 7) : widget.name

        font.family: fontAwesome.name
        font.weight: Font.Light
        text: widget.icons.hasOwnProperty(name) ? widget.icons[name] : ""
        color: Theme.light.iconColor
        style: shadow ? Text.Raised : Text.Normal
        styleColor: Qt.rgba(0,0,0,0.5)
        font.pixelSize: widget.size

        Behavior on color {
            ColorAnimation { duration: 200 }
        }

        NumberAnimation on rotation {
            running: widget.rotate
            from: 0
            to: 360
            loops: Animation.Infinite
            duration: 1100
        }
    }
}
