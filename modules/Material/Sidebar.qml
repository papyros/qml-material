/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer <sonrisesoftware@gmail.com>
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
import Material 0.1
import "ListItems" as ListItem

/*!
   \qmltype Sidebar
   \inqmlmodule Material 0.1

   \brief A sidebar component for use in adaptive layouts

   To use, simply add an instance to your code, and anchor other components to it.

   To show or hide, set the expanded property.

   By default, the sidebar has a flickable built in, and whatever contents are added
   will be placed in the flickable. When you want this disabled, or want to fill the
   entire sidebar, set the autoFill property to false.

   Examples:
   \qml
   Item{
       property bool wideAspect: width > Units.gu(80)

       Sidebar {
           expanded: wideAspect

           // Anchoring is automatic
       }
   }
   \endqml
 */
View {
    id: root

    backgroundColor: style === "default" ? "white" : "#333"

    anchors {
        left: mode === "left" ? parent.left : undefined
        right: mode === "right" ? parent.right : undefined
        top: parent.top
        bottom: parent.bottom
        leftMargin: expanded ? 0 : -width
        rightMargin: expanded ? 0 : -width
    }

    width: Units.dp(250)

    property bool expanded: true

    property string mode: "left" // or "right"
    property alias header: headerItem.text

    property color borderColor: style === "dark" ? Qt.rgba(0.5,0.5,0.5,0.5) : Theme.light.dividerColor

    property bool autoFlick: true

    default property alias contents: contents.data

    Behavior on anchors.leftMargin {
        NumberAnimation { duration: 200 }
    }

    Behavior on anchors.rightMargin {
        NumberAnimation { duration: 200 }
    }

    Rectangle {
        color: borderColor
        width: 1

        anchors {
            top: parent.top
            bottom: parent.bottom
            right: mode === "left" ? parent.right : undefined
            left: mode === "right" ? parent.left : undefined
            //rightMargin: -1
        }
    }

    Item {
        clip: true

        anchors {
            fill: parent
            rightMargin: mode === "left" ? 1 : 0
            leftMargin: mode === "right" ? 1 : 0
        }

        ListItem.Subheader {
            id: headerItem

            visible: text !== ""
            backgroundColor: root.backgroundColor
            elevation: flickable.atYBeginning ? 0 : 1
            fullWidth: true
            z: 2            
        }

        Flickable {
            id: flickable

            clip: true

            anchors {
                top: headerItem.visible ? headerItem.bottom : parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            contentWidth: width
            contentHeight: autoFlick ? contents.height : height
            interactive: contentHeight > height

            Item {
                id: contents

                width: flickable.width
                height: autoFlick ? childrenRect.height : flickable.height
            }

            function getFlickableChild(item) {
                if (item && item.hasOwnProperty("children")) {
                    for (var i=0; i < item.children.length; i++) {
                        var child = item.children[i];
                        if (internal.isVerticalFlickable(child)) {
                            if (child.anchors.top === page.top || child.anchors.fill === page) {
                                return item.children[i];
                            }
                        }
                    }
                }
                return null;
            }
        }

        Scrollbar {
            flickableItem: flickable
        }
    }
}
