import QtQuick 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem
import Material.Extras 0.1
import Qt.labs.folderlistmodel 2.1

Item {
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

                    Grid {
                        anchors {
                            left: parent.left
                            right: parent.right
                            margins: Units.dp(16)
                        }

                        visible: header.expanded
                        rowSpacing: Units.dp(10)
                        columns: Math.floor(width/Units.dp(240))

                        Repeater {
                            model: folderModel
                            delegate: Row {
                                spacing: Units.dp(20)
                                width: grid.width/grid.columns
                                visible: icon.valid

                                Icon {
                                    id: icon
                                    name: {
                                        var iconName = modelData.toLowerCase() + "/" + fileName

                                        var index = iconName.indexOf("svg")

                                        return iconName.substring(0, index - 1)
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                Label {
                                    text: {
                                        var index = fileName.indexOf("svg")

                                        return fileName.substring(0, index - 1).replace(/_/g, " ")
                                    }
                                    width: parent.width - icon.width - parent.spacing
                                    wrapMode: Text.Wrap
                                    anchors.verticalCenter: parent.verticalCenter
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

            Grid {
                id: grid
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Units.dp(16)
                }

                visible: fontHeader.expanded
                rowSpacing: Units.dp(10)
                columns: Math.floor(width/Units.dp(240))

                Repeater {
                    id: awesomeList
                    model: Object.keys(awesomeIcon.icons)
                    delegate: Row {
                        spacing: Units.dp(20)
                        width: grid.width/grid.columns
                        visible: icon.valid

                        Icon {
                            id: icon
                            name: "awesome/" + modelData
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Label {
                            text: modelData
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }

    Scrollbar {
        flickableItem: flickable
    }
}

