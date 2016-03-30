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

/*!
   \qmltype Scrollbar
   \inqmlmodule Material

   \brief Scrollbars show scrolling progress for listviews and flickables.
*/
Item {
    id: root

    property Flickable flickableItem
    property int orientation: Qt.Vertical
    property int thickness: 5
    property bool moving: flickableItem.moving

    width: thickness
    height: thickness
    clip: true
    smooth: true
    visible: orientation === Qt.Vertical ? flickableItem.contentHeight > flickableItem.height
                                         : flickableItem.contentWidth > flickableItem.width

    anchors {
        top: orientation === Qt.Vertical ? flickableItem.top : undefined
        bottom: flickableItem.bottom
        left: orientation === Qt.Horizontal ? flickableItem.left : undefined
        right: flickableItem.right
        margins: 2
    }

    Component.onCompleted: hideAnimation.start()

    onMovingChanged: {
        if (moving) {
            hideAnimation.stop()
            showAnimation.start()
        } else {
            hideAnimation.start()
            showAnimation.stop()
        }
    }

    NumberAnimation {
        id: showAnimation
        target: scrollBar;
        property: "opacity";
        to: 0.3;
        duration: 200;
        easing.type: Easing.InOutQuad
    }

    SequentialAnimation {
        id: hideAnimation

        NumberAnimation { duration: 500 }
        NumberAnimation {
            target: scrollBar;
            property: "opacity";
            to: 0;
            duration: 500;
            easing.type: Easing.InOutQuad
        }
    }

    onOrientationChanged: {
        if (orientation == Qt.Vertical) {
            width = thickness
        } else {
            height = thickness
        }
    }

    Rectangle {
        id: scrollBar
        property int length: orientation == Qt.Vertical ? root.height
                                                        : root.width;
        property int targetLength: orientation == Qt.Vertical ? flickableItem.height
                                                              : flickableItem.width;
        property int contentStart: orientation == Qt.Vertical ? flickableItem.contentY
                                                              : flickableItem.contentX;
        property int contentLength: orientation == Qt.Vertical ? flickableItem.contentHeight
                                                               : flickableItem.contentWidth;
        property int start: Math.max(0, length * contentStart/contentLength);
        property int end: Math.min(length,
                                   length * (contentStart + targetLength)/contentLength)

        color: "black"//theme.foreground
        opacity: 0.3
        radius: thickness/2
        width: Math.max(orientation == Qt.Horizontal ? end - start : 0, thickness)
        height: Math.max(orientation == Qt.Vertical ? end - start : 0, thickness)
        x: orientation == Qt.Horizontal ? start : 0
        y: orientation == Qt.Vertical ? start : 0
    }
}
