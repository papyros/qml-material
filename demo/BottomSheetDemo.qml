import QtQuick 2.0
import Material 0.1
import Material.ListItems 0.1

Item {
    anchors.fill: parent
    id: bottomSheetDemo

    Button {
        anchors.centerIn: parent
        elevation: 1
        text: "Open Bottom Sheet"
        onClicked: {
            actionSheet.open()
        }
    }

    property list<Action> actions: [
            Action {
                iconName: "social/share"
                name: "Share"
            },

            Action {
                iconName: "file/file_download"
                name: "Download"
            },

            Action {
                iconName: "action/autorenew"
                name: "Sync"
            },

            Action {
                iconName: "action/settings"
                name: "Details"
            },

            Action {
                iconName: "content/forward"
                name: "Move"
            },

            Action {
                iconName: "action/delete"
                name: "Delete"
            },

            Action {
                iconName: "content/create"
                name: "Rename"
            }
        ]

    BottomSheet {
        id: actionSheet

        height: Math.min(maxHeight, listView.contentHeight) + actionSheet.margin

        ListView {
            id: listView
            model: actions
            anchors{
                fill: parent
                left: parent.left
                right: parent.right
            }

            delegate: Standard {
                id: listDelegateItem
                text: modelData.name
                iconName: modelData.iconName
                onClicked: {
                    actionSheet.toggle()
                }
            }
        }
    }
}

