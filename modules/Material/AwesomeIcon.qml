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
import 'awesome.js' as Awesome

/*!
   \qmltype AwesomeIcon
   \inqmlmodule Material 0.1

   \brief Displays a unicode character as an icon

    This is mostly a helper for \l Icon. It will display a unicode
    character as an icon. You can add shadows and color to it.

    The font is \l {http://fortawesome.github.io/Font-Awesome/icons/}{FontAwesome.otf}

    \sa awesome.js
    \sa Icon
 */
Item {
    id: widget
    /*!
        \qmlproperty string AwesomeIcon::name

        The name of the icon to show. If the name includes the 'rotate' word
        it will automatically include an rotation animation.
    */
    property string name

    /*!
        \internal
        \qmlproperty bool AwesomeIcon::rotate

        \c true if icon should rotate, defined by the \l name of the icon
    */
    property bool rotate: widget.name.match(/.*-rotate/) !== null

    /*!
        \qmlproperty bool AwesomeIcon::valid

        \c true if the icon has a valid \l name
    */
    property bool valid: text.implicitWidth > 0

    /*!
        \qmlproperty color AwesomeIcon::color

        The color to show.
    */
    property alias color: text.color

    /*!
        \qmlproperty int AwesomeIcon::size

        The size of the icon. Default 24 dp.
    */
    property int size: units.dp(24)

    /*!
        \qmlproperty bool AwesomeIcon::shadow

        \c true if the icon should show a shadow.
    */
    property bool shadow: false

    /*!
        \qmlproperty variant AwesomeIcon::icons

        Holds all the Awesome icon names that can be used.
    */
    property var icons: Awesome.map

    /*!
        \qmlproperty int AwesomeIcon::weight

        See QML Font::weight
    */
    property alias weight: text.font.weight

    width: text.width
    height: text.height

    FontLoader { id: fontAwesome; source: Qt.resolvedUrl("fonts/fontawesome/FontAwesome.otf") }

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
