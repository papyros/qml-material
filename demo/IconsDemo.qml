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
        contentHeight: content.height + units.dp(16)
        contentWidth: width

        Column {
            id: content
            width: flickable.width
            height: implicitHeight + units.dp(16)

            Repeater {
                model: [
                    "Action", "Alert", "AV", "Communication", "Content", "Device", "Editor", "File",
                    "Hardware", "Image", "Maps", "Navigation", "Notification", "Social", "Toggle"
                ]

                delegate: Column {
                    width: parent.width

                    ListItem.Header {
                        text: modelData
                    }

                    FolderListModel {
                        id: folderModel
                        folder: icon.iconDirectory + "/" + modelData.toLowerCase()
                    }

                    Grid {
                        anchors {
                            left: parent.left
                            right: parent.right
                            margins: units.dp(16)
                        }

                        rowSpacing: units.dp(10)
                        columns: Math.floor(width/units.dp(240))

                        Repeater {
                            model: folderModel
                            delegate: Row {
                                spacing: units.dp(20)
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
                }
            }

            ListItem.Header {
                text: "FontAwesome"
            }

            Grid {
                id: grid
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: units.dp(16)
                }

                rowSpacing: units.dp(10)
                columns: Math.floor(width/units.dp(240))

                Repeater {
                    model: ListUtils.objectKeys(awesomeIcon.icons)
                    delegate: Row {
                        spacing: units.dp(20)
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

