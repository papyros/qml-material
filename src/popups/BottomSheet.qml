/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2015-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *               2015 Steve Coffey <scoffey@barracuda.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import Material 0.3

/*!
   \qmltype BottomSheet
   \inqmlmodule Material

   \brief A bottom sheet is a sheet of paper that slides up from the bottom edge
   of the screen and presents a set of clear and simple actions.
 */
PopupBase {
    id: bottomSheet

    /*!
       The maximum height of the bottom sheet. This is useful when used with a flickable,
       so the bottom sheet will scroll when the content is higher than the maximum height.
     */
    property int maxHeight: parent.height * 0.6

    default property alias content: containerView.data

    overlayLayer: "dialogOverlayLayer"
    overlayColor: Qt.rgba(0, 0, 0, 0.2)
    height: Math.min(maxHeight, implicitHeight)
    implicitHeight: containerView.childrenRect.height
    width: parent.width

    visible: percentOpen > 0

    property real percentOpen: showing ? 1 : 0

    Behavior on percentOpen {

        NumberAnimation {
            duration: 200
            easing {
                 type: Easing.OutCubic
            }
        }
    }

    anchors {
        bottom: parent.bottom
        bottomMargin: (bottomSheet.percentOpen - 1) * height
    }

    View {
        id:containerView

        anchors.fill: parent

        elevation: 2
        backgroundColor: "#fff"
    }
}
