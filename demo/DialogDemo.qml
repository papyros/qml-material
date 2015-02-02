import QtQuick 2.0
import QtQuick.Controls 1.2 as QuickControls
import Material 0.1
import Material.Extras 0.1

Item {
    property string currentText

    Dialog {
        id: actionableDialog
        title: "Change Text"
        hasActions: true

        TextField {
            id: optionText
            text: currentText
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "New Option to Confirm"
        }

        onAccepted: {
            currentText = optionText.text
        }
    }

    Dialog {
        id: scrollingDialog
        title: "Choose Size"
        hasActions: false

        Flickable {
            id: mainFlick
            z: parent.z + 1
            width: units.dp(200)
            height: units.dp(200)
            clip: true
            interactive: contentHeight > height
            contentHeight: mainCol.height
            contentWidth: width

            Column {
                id: mainCol

                QuickControls.ExclusiveGroup {
                    id: optionGroup
                }

                RadioButton {
                    text: "Small"
                    checked: true
                    exclusiveGroup: optionGroup
                }
                RadioButton {
                    text: "Normal"
                    exclusiveGroup: optionGroup
                }
                RadioButton {
                    text: "Big"
                    exclusiveGroup: optionGroup
                }
                RadioButton {
                    text: "Gigantic"
                    exclusiveGroup: optionGroup
                }
                RadioButton {
                    text: "Enourmous"
                    exclusiveGroup: optionGroup
                }
                RadioButton {
                    text: "Titanic"
                    exclusiveGroup: optionGroup
                }
                RadioButton {
                    text: "Humongous"
                    exclusiveGroup: optionGroup
                }
                RadioButton {
                    text: "Ginourmous"
                    exclusiveGroup: optionGroup
                }
            }
        }

        Scrollbar {
            flickableItem: mainFlick
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: units.dp(20)

        Button {
            text: "Show Action Dialog"
            anchors.horizontalCenter: parent.horizontalCenter
            elevation: 1
            onClicked: {
                actionableDialog.show()
            }
        }

        Button {
            text: "Show Scrolling Dialog"
            anchors.horizontalCenter: parent.horizontalCenter
            elevation: 1
            onClicked: {
                scrollingDialog.show()
            }
        }

        Label {
            text: currentText
        }
    }
}
