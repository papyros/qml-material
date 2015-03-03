import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem

ApplicationWindow {
    id: demo

    theme {
        primaryColor: Palette.colors["blue"]["500"]
        primaryDarkColor: Palette.colors["blue"]["700"]
        accentColor: Palette.colors["teal"]["500"]
    }

    property var components: [
            "Button", "CheckBox", "Color Palette", "Dialog", "Forms", "Icon", "List Items", "Page Stack",
            "Progress Bar", "Radio Button", "Slider", "Switch", "TextField"
    ]

    property string selectedComponent: components[0]

    initialPage: Page {
        title: "Component Demo"

        actions: [
            Action {
                iconName: "image/color_lens"
                name: "Colors"
                onTriggered: colorPicker.show()
            },

            Action {
                iconName: "action/search"
                name: "Search"
            },

            Action {
                iconName: "action/language"
                name: "Language"
            },

            Action {
                iconName: "action/account_circle"
                name: "Account"
            },

            Action {
                iconName: "action/settings"
                name: "Settings"
            }
        ]

        Sidebar {
            id: sidebar

            Column {
                width: parent.width

                Repeater {
                    model: demo.components
                    delegate: ListItem.Standard {
                        text: modelData
                        selected: modelData == selectedComponent
                        onClicked: selectedComponent = modelData
                    }
                }
            }
        }
        Flickable {
            id: flickable
            anchors {
                left: sidebar.right
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
            clip: true
            contentHeight: Math.max(example.implicitHeight + 40, height)
            Loader {
                id: example
                anchors.fill: parent
                // selectedComponent will always be valid, as it defaults to the first component
                source: Qt.resolvedUrl("%1Demo.qml").arg(selectedComponent.replace(" ", ""))
            }
        }
        Scrollbar {
            flickableItem: flickable
        }
    }

    Dialog {
        id: colorPicker
        title: "Pick color"

        positiveButtonText: "Done"

        MenuField {
            id: selection
            model: ["Primary color", "Accent color", "Background color"]
            width: units.dp(160)
        }

        Grid {
            columns: 7
            spacing: units.dp(8)

            Repeater {
                model: [
                    "red", "pink", "purple", "deepPurple", "indigo",
                    "blue", "lightBlue", "cyan", "teal", "green",
                    "lightGreen", "lime", "yellow", "amber", "orange",
                    "deepOrange", "grey", "blueGrey", "brown", "black",
                    "white"
                ]

                Rectangle {
                    width: units.dp(30)
                    height: units.dp(30)
                    radius: units.dp(2)
                    color: Palette.colors[modelData]["500"]
                    border.width: modelData === "white" ? units.dp(2) : 0
                    border.color: Theme.alpha("#000", 0.26)

                    Ink {
                        anchors.fill: parent

                        onPressed: {
                            switch(selection.selectedIndex) {
                                case 0:
                                    theme.primaryColor = parent.color
                                    break;
                                case 1:
                                    theme.accentColor = parent.color
                                    break;
                                case 2:
                                    theme.backgroundColor = parent.color
                                    break;
                            }
                        }
                    }
                }
            }
        }
        
        onRejected: {
            // TODO set default colors again but we currently don't know what that is
        }
    }
}
