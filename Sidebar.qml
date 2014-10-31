import QtQuick 2.0
import "ListItems" as ListItem

/*!
    \qmltype Sidebar
    \brief A sidebar component for use in adaptive layouts

    To use, simply add an instance to your code, and anchor other components to it.

    To show or hide, set the expanded property.

    By default, the sidebar has a flickable built in, and whatever contents are added
    will be placed in the flickable. When you want this disabled, or want to fill the
    entire sidebar, set the autoFill property to false.

    Examples:
    \qml
        property bool wideAspect: width > units.gu(80)

        Sidebar {
            expanded: wideAspect

            // Anchoring is automatic
        }
    \endqml
*/
View {
    id: root

    property bool expanded: true

    property string mode: "left" // or "right"
    property alias header: headerItem.text

    backgroundColor: style === "default" ? Qt.rgba(0.9,0.9,0.9,0.1) : "#333"
    property color borderColor: style === "dark" ? Qt.rgba(0.5,0.5,0.5,0.5) : Qt.rgba(0,0,0,0.2)

    anchors {
        left: mode === "left" ? parent.left : undefined
        right: mode === "right" ? parent.right : undefined
        top: parent.top
        bottom: parent.bottom
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

    width: units.gu(35)


    anchors.leftMargin: expanded ? 0 : -width
    anchors.rightMargin: expanded ? 0 : -width

    Behavior on anchors.leftMargin {
        NumberAnimation { duration: 200 }
    }

    Behavior on anchors.rightMargin {
        NumberAnimation { duration: 200 }
    }

    default property alias contents: contents.data

    ListItem.Header {
        id: headerItem

        visible: text !== ""
    }

    property bool autoFlick: true

    Flickable {
        id: flickable

        clip: true

        anchors {
            top: headerItem.visible ? headerItem.bottom : parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            rightMargin: mode === "left" ? 1 : 0
            leftMargin: mode === "right" ? 1 : 0
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
