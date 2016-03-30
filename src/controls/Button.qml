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
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle
import Material 0.3

/*!
   \qmltype Button
   \inqmlmodule Material

   \brief A push button with a text label.

   A button clearly communicates what action will occur when the user touches it.
   It consists of text, an image, or both, designed in accordance with your app’s color theme.

   There are three standard types of buttons:

   \list
   \li Floating action button: A circular material button that lifts and displays
       an ink reaction on press.
   \li Raised button: A typically rectangular material button that lifts and
       displays ink reactions on press.
   \li Flat button: A button made of ink that displays ink reactions on press but
       does not lift.
   \endlist

   This componenent provides raised and flat buttons. For floating action buttons,
   see \l ActionButton.

   Here are some example buttons:

   \image buttons.png Button examples

   See the \l {http://www.google.com/design/spec/components/buttons.html}
   {Material Design spec} for details on how to use buttons.

   \sa ActionButton
 */
Controls.Button {
    id: button

    /*!
       The background color of the button. By default, this is white for a raised
       button and transparent for a flat button.
     */
    property color backgroundColor: elevation > 0 ? "white" : "transparent"

    /*!
       \internal

       The context of the button, which is used to control special styling of
       buttons in dialogs or snackbars.
     */
    property string context: "default" // or "dialog" or "snackbar"

    /*!
       Set to \c true if the button has a dark background color
     */
    property bool darkButton: Theme.isDarkColor(backgroundColor)

    /*!
       Set to \c true if the button is on a dark background
     */
    property bool darkBackground

    /*!
       The elevation of the button. Normally either \c 0 or \c 1.
     */
    property int elevation

    /*!
       The text color of the button. By default, this is calculated based on the background color,
       but it can be customized to the theme's primary color or another color.
     */
    property color textColor: button.darkButton ? Theme.dark.textColor : Theme.light.textColor

    style: MaterialStyle.ButtonStyle {}
}
