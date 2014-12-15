import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem

ApplicationWindow {
    id: demo

    initialPage: page

    property var components: ["Button", "Switch"]
    property string selectedComponent: components[0]

    Page {
        id: page

        title: "Component Demo"

        Sidebar {
            id: sidebar

            Column {
                width: parent.width

                Repeater {
                    model: demo.components
                    delegate: ListItem.Standard {
                        text: modelData
                        selected: modelData == selectedComponent
                        onTriggered: selectedComponent = modelData
                    }
                }
            }
        }

        Loader {
            anchors {
                left: sidebar.right
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }

            // selectedComponent will always be valid, as it defaults to the first component
            source: Qt.resolvedUrl("%1Demo.qml").arg(selectedComponent)
        }
    }
}
