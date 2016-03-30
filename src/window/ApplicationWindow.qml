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
import QtQuick.Window 2.2
import Material 0.3
import Material.Extras 0.1

/*!
   \qmltype ApplicationWindow
   \inqmlmodule Material

   \brief A window that provides features commonly used for Material Design apps.

   This is normally what you should use as your root component. It provides a \l Toolbar and
   \l PageStack to provide access to standard features used by Material Design applications.

   Here is a short working example of an application:

   \qml
   import QtQuick 2.4
   import Material 0.3

   ApplicationWindow {
       title: "Application Name"

       initialPage: page

       Page {
           id: page
           title: "Page Title"

           Label {
               anchors.centerIn: parent
               text: "Hello World!"
           }
       }
   }
   \endqml
*/
Controls.ApplicationWindow {
    id: app

    /*!
       Set to \c true to include window decorations in your app's toolbar and hide
       the regular window decorations header.
     */
    property bool clientSideDecorations: false

    /*!
       \qmlproperty Page initialPage

       The initial page shown when the application starts.
     */
    property alias initialPage: __pageStack.initialItem

    /*!
       \qmlproperty PageStack pageStack

       The \l PageStack used for controlling pages and transitions between pages.
     */
    property alias pageStack: __pageStack

    /*!
       \qmlproperty AppTheme theme

       A grouped property that allows the application to customize the the primary color, the
       primary dark color, and the accent color. See \l Theme for more details.
     */
    property alias theme: __theme

    AppTheme {
        id: __theme
    }

    PlatformExtensions {
        id: platformExtensions
        decorationColor: __toolbar.decorationColor
        window: app
    }

    PageStack {
        id: __pageStack
        anchors {
            left: parent.left
            right: parent.right
            top: __toolbar.bottom
            bottom: parent.bottom
        }

        onPushed: __toolbar.push(page)
        onPopped: __toolbar.pop(page)
        onReplaced: __toolbar.replace(page)
    }

    Toolbar {
        id: __toolbar
        clientSideDecorations: app.clientSideDecorations
    }

    OverlayLayer {
        id: dialogOverlayLayer
        objectName: "dialogOverlayLayer"
    }

    OverlayLayer {
        id: tooltipOverlayLayer
        objectName: "tooltipOverlayLayer"
    }

    OverlayLayer {
        id: overlayLayer
    }

    width: dp(800)
    height: dp(600)

    Dialog {
        id: errorDialog

        property var promise

        positiveButtonText: "Retry"

        onAccepted: {
            promise.resolve()
            promise = null
        }

        onRejected: {
            promise.reject()
            promise = null
        }
    }

    /*!
       Show an error in a dialog, with the specified secondary button text (defaulting to "Close")
       and an optional retry button.

       Returns a promise which will be resolved if the user taps retry and rejected if the user
       cancels the dialog.
     */
    function showError(title, text, secondaryButtonText, retry) {
        if (errorDialog.promise) {
            errorDialog.promise.reject()
            errorDialog.promise = null
        }

        errorDialog.negativeButtonText = secondaryButtonText ? secondaryButtonText : "Close"
        errorDialog.positiveButton.visible = retry || false

        errorDialog.promise = new Promises.Promise()
        errorDialog.title = title
        errorDialog.text = text
        errorDialog.open()

        return errorDialog.promise
    }

    // Units

    function dp(dp) {
        return dp * Units.dp
    }

    function gu(gu) {
        return units.gu(gu)
    }

    UnitsHelper {
        id: units
    }

    Component.onCompleted: {
        if (clientSideDecorations)
            flags |= Qt.FramelessWindowHint
    }
}
