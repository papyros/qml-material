/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *               2015 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1 as ListItem

/*!
   \qmltype ActionBar
   \inqmlmodule Material

   \brief An action bar holds the title and actions displayed in the application toolbar.

   The reason this exists separately from \l Toolbar is for animation purposes.
   Each page contains its own \c ActionBar, and when the application transitions
   between pages, the toolbar animates the transition between action bars.

   Normally, you don't need to manually create an instance of this class, and just
   use the instance provided by the page. See the example in the \l Page documentation
   for more details.
 */
Item {
    id: actionBar

    implicitHeight: 1 * Device.gridUnit * Units.dp

    anchors {
        left: parent.left
        right: parent.right
    }

    /*!
       A list of actions to show in the action bar. These actions will be shown
       anchored to the right, and will overflow if there are more than the
       maximum number of actions as defined in \l maxActionCount.

       When used with a page, the actions will be set to the page's \l Page::actions
       property, so set that instead of changing this directly.
     */
    property list<Action> actions

    /*!
       The back action to display to the left of the title in the action bar.
       When used with a page, this will pick up the page's back action, which
       by default is a back arrow when there is a page behind the current page
       on the page stack. However, you can customize this, for example, to show
       a navigation drawer at the root of your app.

       When using an action bar in a page, set the \l Page::backAction instead of
       directly setting this property.
     */
    property Action backAction

    /*!
       The background color of the window decoration when the action bar's page is active,
       usually a darker version of the \l backgroundColor.
       By default this is the primary dark color defined in \l Theme::primaryDarkColor
     */
    property color decorationColor: Theme.primaryDarkColor

    /*!
       The background color for the toolbar when the action bar's page is active.
       By default this is the primary color defined in \l Theme::primaryColor
     */
    property color backgroundColor: Theme.primaryColor

    /*!
       \qmlproperty Item customContent

       A custom view to show instead of the title in the action bar.
     */
    property alias customContent: customContentView.data

    /*!
       \qmlproperty Item extendedContent

       A custom view to show under the row containing the title and actions.
       Causes the action bar to be extend in height to contain this view.
     */
    property alias extendedContent: extendedContentView.data

    /*!
       The elevation of the action bar. Set to 0 if you want have a header or some
       other view below the action bar that you want to appear as part of the action bar.
     */
    property int elevation: 2

    /*!
       \internal
       The height of the extended content view.
     */
    readonly property int extendedHeight: extendedContentView.height +
            (tabBar.visible && !integratedTabBar ? tabBar.height : 0)

    /*!
       Set to true to hide the action bar. This is used when displaying an
       action bar in a toolbar through the use of a page and the page stack.
       If you are using an action bar for custom purposes, set the opacity or visibility
       instead.
     */
    property bool hidden: false

    /*!
     * \internal
     * The size of the left icon and the action icons.
     *
     * \since 0.3
     */
    property int iconSize: Units.gridUnit == 48 * Units.dp ? 20 * Units.dp : 24 * Units.dp

    /*!
     * Set to true to integrate the tab bar into a single row with the actions.
     *
     * \since 0.3
     */
    property bool integratedTabBar: false

    /*!
       The maximum number of actions that can be displayed before they spill over
       into a drop-down menu. When using an action bar with a page, this inherits
       from the global \l Toolbar::maxActionCount. If you are using an action bar
       for custom purposes outside of a toolbar, this defaults to \c 3.
     */
    property int maxActionCount: toolbar ? toolbar.maxActionCount : 3

    /*!
       The index of the selected tab. This will be an index from the \l tabs
       property.
     */
    property alias selectedTabIndex: tabBar.selectedIndex

    /*!
       The tab bar displayed below the actions in the action bar. Exposed for
       additional customization.
     */
    property alias tabBar: tabBar

    /*!
       The model to use as the tab items in the action bar. This can either be a Javascript
       array wih an object for each tab, or it can be a TabView object to display tabs for.

       If it is a Javascript array, each object represents one tab, and can either be a simple
       string (used as the tab title), or an object with title, iconName, and/or iconSource
       properties.

       If it is a TabView component, the title of each Tab object will be used, as well as
       iconName and iconSource properties if present (as provided by the Material subclass of Tab).

       When used in a page, this will be set to the tabs of the page, so set the \l Page::tabs
       property instead of changing this directly.
     */
    property alias tabs: tabBar.tabs

    /*!
       The title displayed in the action bar. When used in a page, the title will
       be set to the title of the page, so set the \l Page::title property instead
       of changing this directly.
     */
    property string title

    /*!
       \internal
       The toolbar containing this action bar.
     */
    property Item toolbar

    property int leftKeyline: label.x

    /*!
       \internal
       \qmlproperty bool overflowMenuShowing

       Returns \c true if the overflow menu is open.
     */
    readonly property alias overflowMenuShowing: overflowMenu.showing

    /*!
       \internal

       Returns true if the overflow menu is available.
     */
    readonly property bool overflowMenuAvailable: __internal.visibleActions.length > maxActionCount

    /*!
       \internal

       Opens the overflow menu, if it is present and not already open open.
     */
    function openOverflowMenu() {
        if (overflowMenuAvailable && !overflowMenuShowing)
            overflowMenu.open(overflowButton, 4 * Units.dp, -4 * Units.dp);
    }

    /*!
       \internal

       Closes the overflow menu, if it is present and already open open.
     */
    function closeOverflowMenu() {
        if (overflowMenuAvailable && overflowMenuShowing)
            overflowMenu.close();
    }

    QtObject {
        id: __internal

        property var visibleActions: Utils.filter(actions, function(action) {
            return action.visible
        })
    }

    IconButton {
        id: leftItem

        anchors {
            verticalCenter: actionsRow.verticalCenter
            left: parent.left
            leftMargin: leftItem.show ? 16 * Units.dp : -leftItem.width

            Behavior on leftMargin {
                NumberAnimation { duration: 200 }
            }
        }

        color: Theme.lightDark(actionBar.backgroundColor, Theme.light.iconColor,
                                                            Theme.dark.iconColor)
        size: iconSize
        action: backAction

        opacity: show ? enabled ? 1 : 0.6 : 0
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        property bool show: backAction && backAction.visible
    }

    Label {
        id: label

        anchors {
            verticalCenter: actionsRow.verticalCenter
            left: parent.left
            right: actionsRow.left
            leftMargin:16 * Units.dp + (leftItem.show ? 1 * Device.gridUnit * Units.dp : 0)
            rightMargin: 16 * Units.dp

            Behavior on leftMargin {
                NumberAnimation { duration: 200 }
            }
        }

        visible: customContentView.children.length === 0 &&
                (!integratedTabBar || !tabBar.visible)

        textFormat: Text.PlainText
        text: actionBar.title
        style: "title"
        color: Theme.lightDark(actionBar.backgroundColor, Theme.light.textColor,
                                                            Theme.dark.textColor)
        elide: Text.ElideRight
    }

    Row {
        id: actionsRow

        anchors {
            right: parent.right
            rightMargin: 16 * Units.dp
        }

        height: parent.implicitHeight

        spacing: 24 * Units.dp

        Repeater {
            model: __internal.visibleActions.length > maxActionCount
                    ? maxActionCount - 1
                    : __internal.visibleActions.length

            delegate: IconButton {
                id: iconAction

                objectName: "action/" + action.objectName

                action: __internal.visibleActions[index]

                color: Theme.lightDark(actionBar.backgroundColor, Theme.light.iconColor,
                                                                  Theme.dark.iconColor)
                size: iconSize

                anchors.verticalCenter: parent ? parent.verticalCenter : undefined
            }
        }

        IconButton {
            id: overflowButton

            iconName: "navigation/more_vert"
            objectName: "action/overflow"
            size: 27 * Units.dp
            color: Theme.lightDark(actionBar.backgroundColor, Theme.light.iconColor,
                                                              Theme.dark.iconColor)
            visible: actionBar.overflowMenuAvailable
            anchors.verticalCenter: parent.verticalCenter

            onClicked: openOverflowMenu()
        }
    }

    Item {
        id: customContentView

        height: parent.height

        anchors {
            left: label.left
            right: label.right
        }
    }

    Item {
        id: extendedContentView
        anchors {
            top: actionsRow.bottom
            left: label.left
            right: parent.right
            rightMargin: 16 * Units.dp
        }

        height: childrenRect.height
    }

    TabBar {
        id: tabBar

        darkBackground: Theme.isDarkColor(actionBar.backgroundColor)
        leftKeyline: actionBar.leftKeyline
        height: integratedTabBar ? parent.implicitHeight : implicitHeight

        anchors {
            top: integratedTabBar ? undefined : extendedContentView.bottom
            bottom: integratedTabBar ? actionsRow.bottom : undefined
            left: parent.left
            right: integratedTabBar ? actionsRow.left : parent.right
        }
    }

    Dropdown {
        id: overflowMenu
        objectName: "overflowMenu"

        width: 250 * Units.dp
        height: columnView.height + 16 * Units.dp

        ColumnLayout {
            id: columnView
            width: parent.width
            anchors.centerIn: parent

            Repeater {
                model: __internal.visibleActions.length - (maxActionCount - 1)

                ListItem.Standard {
                    id: listItem

                    objectName: "action/" + action.objectName

                    property Action action: __internal.visibleActions[index + maxActionCount - 1]

                    text: action.name
                    iconSource: action.iconSource
                    enabled: action.enabled

                    onClicked: {
                        action.triggered(listItem)
                        overflowMenu.close()
                    }
                }
            }
        }
    }
}
