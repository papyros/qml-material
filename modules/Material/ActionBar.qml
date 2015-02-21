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
import Material.ListItems 0.1 as ListItem

/*!
   \qmltype ActionBar
   \inqmlmodule Material 0.1
   \ingroup material

   \brief An action bar holds the title and actions displayed in the application toolbar.

   The reason this exists separately from \l Toolbar is for animation purposes. Each page contains
   its own \c ActionBar, and when the application transitions between pages, the toolbar animates
   the transition between action bars.
 */
Item {
    id: actionBar

	// TODO: Replace with enum values for device.mode
    implicitHeight: Device.type === Device.phone
                    ? units.dp(48) : Device.type == Device.tablet
                      ? units.dp(56) : units.dp(64)

    anchors {
        left: parent.left
        right: parent.right
    }

    property bool hidden: false

    /*!
       \internal
       The page holding this \c ActionBar
     */
    property Item page

	/*!
	   The maximum number of actions that can be displayed before they spill over into a drop-down
	   menu. By default this inherits from the global \l Toolbar::maxActionCount.
	 */
    property int maxActionCount: toolbar ? toolbar.maxActionCount : 3

    property Item toolbar

	/*!
	   \internal
	   The action bar in the toolbar will only be shown if the page is not card-style. In that case,
	   there is a separate action bar in the card.
	 */
    property bool showContents: page != undefined && !page.cardStyle

	/*!
	   The background color for the toolbar when the action bar's page is active. By default this is
	   the primary color defined in \l Theme::primaryColor
	 */
    property color backgroundColor: Theme.primaryColor

    property int elevation: 2

    property alias title: label.text

    property Action backAction: page ? page.backAction : undefined

    IconButton {
        id: leftItem

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: leftItem.show ? units.dp(16) : -leftItem.width

            Behavior on leftMargin {
                NumberAnimation { duration: 200 }
            }
        }

        color: Theme.lightDark(actionBar.backgroundColor, Theme.light.iconColor,
                                                            Theme.dark.iconColor)
        size: units.dp(27)
        action: page.backAction

        opacity: show ? enabled ? 1 : 0.3 : 0

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        property bool show: backAction && backAction.visible &&
                            (!page || !page.cardStyle || !showContents)
    }

    Label {
        id: label

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: leftItem.show ? units.dp(72) : units.dp(16)

            Behavior on leftMargin {
                NumberAnimation { duration: 200 }
            }
        }

        text: showContents ? page.title : ""
        style: "title"
        color: Theme.lightDark(actionBar.backgroundColor, Theme.light.textColor,
                                                            Theme.dark.textColor)
    }

    Row {
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: units.dp(16)
        }

        spacing: units.dp(24)

        Repeater {
            model: !showContents ? []
                                : page.actions.length > maxActionCount
                                  ? maxActionCount - 1 : page.actions.length

            delegate: IconButton {
                id: iconAction

                action: page.actions[index]

                color: Theme.lightDark(actionBar.backgroundColor, Theme.light.textColor,
                                                                     Theme.dark.textColor)
                size: name == "content/add" ? units.dp(30) : units.dp(27)
                anchors.verticalCenter: parent ? parent.verticalCenter : undefined
            }
        }

        IconButton {
            id: overflowButton

            name: "navigation/more_vert"
            size: units.dp(27)
            color: Theme.lightDark(actionBar.backgroundColor, Theme.light.textColor,
                                                                 Theme.dark.textColor)
            visible: showContents && page && page.actions.length > maxActionCount
            anchors.verticalCenter: parent.verticalCenter

            onTriggered: overflowMenu.open(overflowButton, units.dp(4), units.dp(-4))
        }
    }

    Dropdown {
        id: overflowMenu

        width: units.dp(200)
        height: listView.contentHeight + units.dp(16)

        ListView {
            id: listView

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: units.dp(8)
            }

            interactive: false
            height: contentHeight

            model: page.actions.length - (maxActionCount - 1)

            delegate: ListItem.Standard {
                id: listItem

                property Action actionItem: page.actions[index + maxActionCount - 1]

                text: actionItem.name
                action: Icon {
                    name: listItem.actionItem.iconName
                    anchors.centerIn: parent
                }

                onTriggered: {
                    actionItem.triggered(listItem)
                    overflowMenu.close()
                }
            }
        }
    }
}
