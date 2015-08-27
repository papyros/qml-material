/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014-2015 Michael Spencer <sonrisesoftware@gmail.com>
 *               2015 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
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
import QtQuick.Layouts 1.1
import Material 0.1
import Material.Extras 0.1
import Material.ListItems 0.1 as ListItem

/*!
   \qmltype ActionBar
   \inqmlmodule Material 0.1

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

    implicitHeight: Units.gu(1)

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
                                          (tabbar.visible ? tabbar.height : 0)

    /*!
       Set to true to hide the action bar. This is used when displaying an
       action bar in a toolbar through the use of a page and the page stack.
       If you are using an action bar for custom purposes, set the opacity or visibility
       instead.
     */
    property bool hidden: false

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
    property alias selectedTab: tabbar.selectedIndex

    /*!
       An array of tab titles displayed under the page title in the action bar.
       Each item can either be a simple string or a Javascript object with a title
       property and an optional icon property with the name of an icon from the Google
       Material Design icon collection.

       When used in a page, this will be set to the tabs of the page, so set the \l Page::tabs
       property instead of changing this directly.
     */
    property alias tabs: tabbar.tabs

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
            overflowMenu.open(overflowButton, Units.dp(4), Units.dp(-4));
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

        property var visibleActions: ListUtils.filter(actions, function(action) {
            return action.visible
        })
    }

    IconButton {
        id: leftItem

        anchors {
            verticalCenter: actionsRow.verticalCenter
            left: parent.left
            leftMargin: leftItem.show ? Units.dp(16) : -leftItem.width

            Behavior on leftMargin {
                NumberAnimation { duration: 200 }
            }
        }

        color: Theme.lightDark(actionBar.backgroundColor, Theme.light.iconColor,
                                                            Theme.dark.iconColor)
        size: Units.dp(24)
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
            leftMargin: leftItem.show ? Units.dp(72) : Units.dp(16)
            rightMargin: Units.dp(16)

            Behavior on leftMargin {
                NumberAnimation { duration: 200 }
            }
        }

        visible: customContentView.children.length === 0

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
            rightMargin: Units.dp(16)
        }

        height: parent.implicitHeight

        spacing: Units.dp(24)

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
                size: iconSource == "icon://content/add" ? Units.dp(27) : Units.dp(24)

                anchors.verticalCenter: parent ? parent.verticalCenter : undefined
            }
        }

        IconButton {
            id: overflowButton

            iconName: "navigation/more_vert"
            objectName: "action/overflow"
            size: Units.dp(27)
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
            rightMargin: Units.dp(16)
        }

        height: childrenRect.height
    }

    Tabbar {
        id: tabbar

        visible: tabs.length > 0
        darkBackground: Theme.isDarkColor(actionBar.backgroundColor)
        leftKeyline: actionBar.leftKeyline

        anchors {
            top: extendedContentView.bottom
            left: parent.left
            right: parent.right
        }
    }

    Dropdown {
        id: overflowMenu
        objectName: "overflowMenu"

        width: Units.dp(250)
        height: columnView.height + Units.dp(16)

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
