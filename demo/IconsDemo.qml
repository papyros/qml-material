import QtQuick 2.4
import Material 0.1
import Material.ListItems 0.1 as ListItem
import Material.Extras 0.1
import Qt.labs.folderlistmodel 2.1

Item {
    id: section
    state: "list"

    AwesomeIcon {
        id: awesomeIcon
        visible: false
    }

    Icon {
        id: icon
        visible: false
    }

    Flickable {
        id: flickable

        anchors.fill: parent
        contentHeight: content.height + Units.dp(16)
        contentWidth: width

        Column {
            id: content
            width: flickable.width
            y: Units.dp(8)

            Repeater {
                model: [
                    "Action", "Alert", "AV", "Communication", "Content", "Device", "Editor", "File",
                    "Hardware", "Image", "Maps", "Navigation", "Notification", "Social", "Toggle"
                ]

                delegate: Column {
                    width: parent.width

                    ListItem.SectionHeader {
                        id: header
                        text: modelData + " (" + folderModel.count + ")"

                        ThinDivider {
                            anchors {
                                left: parent.left
                                right: parent.right
                                top: parent.top
                            }
                            visible: header.expanded
                        }
                    }

                    FolderListModel {
                        id: folderModel
                        folder: icon.iconDirectory + "/" + modelData.toLowerCase()
                    }

                    Item {
                        width: parent.width
                        height: Units.dp(8)
                        visible: header.expanded
                    }

                    Flow {
                        anchors {
                            left: parent.left
                            right: parent.right
                            margins: Units.dp(16)
                        }

                        visible: header.expanded
                        spacing: Units.dp(10)

                        Repeater {
                            model: folderModel
                            delegate: Item {
                                width: section.state == "list" ? Units.dp(240) : icon.size
                                height: icon.size
                                visible: icon.valid
                                Row {
                                    spacing: Units.dp(20)

                                    Icon {
                                        id: icon
                                        name: {
                                            var iconName = modelData.toLowerCase() + "/" + fileName

                                            var index = iconName.indexOf("svg")

                                            return iconName.substring(0, index - 1)
                                        }
                                        size: section.state == "list" ? Units.dp(24) : Units.dp(64)
                                    }

                                    Label {
                                        id: iconLabel
                                        visible: section.state == "list"
                                        text: {
                                            var index = fileName.indexOf("svg")

                                            return fileName.substring(0, index - 1).replace(/_/g, " ")
                                        }
                                    }

                                }
                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    Tooltip {
                                        text: icon.name
                                        mouseArea: parent
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        width: parent.width
                        height: Units.dp(16)
                        visible: header.expanded
                    }

                    ThinDivider {
                        anchors {
                            left: parent.left
                            right: parent.right
                        }
                        visible: header.expanded
                    }
                }
            }

            ListItem.SectionHeader {
                id: fontHeader
                text: "FontAwesome" + " (" + awesomeList.count + ")"

                ThinDivider {
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                    }
                    visible: fontHeader.expanded
                }
            }

            Item {
                width: parent.width
                height: Units.dp(8)
                visible: fontHeader.expanded
            }

            Flow {
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Units.dp(16)
                }

                visible: fontHeader.expanded
                spacing: Units.dp(10)

                Repeater {
                    id: awesomeList
                    model: Object.keys(awesomeIcon.icons)
                    delegate: Item {
                        width: section.state == "list" ? Units.dp(240) : icon.size
                        height: icon.size
                        visible: icon.valid
                        Row {
                            spacing: Units.dp(20)

                            Icon {
                                id: icon
                                name: "awesome/" + modelData
                                size: section.state === "list" ? Units.dp(24) : Units.dp(64)
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Label {
                                visible: section.state === "list"
                                text: modelData
                                anchors.verticalCenter: parent.verticalCenter
                            }

                        }
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            Tooltip {
                                text: icon.name
                                mouseArea: parent
                            }
                        }
                    }
                }
            }
        }
    }

    Scrollbar {
        flickableItem: flickable
    }


    ActionButton {
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: Units.dp(32)
        }

        iconName: section.state === "list" ? "action/view_module"
                                           : "action/view_list"

        onClicked: {
            if (section.state === "list")
                section.state = "module"
            else
                section.state = "list"
        }
    }

    states: [
        State {
            name: "list"
        },
        State {
            name: "module"
        }
    ]
}

