import QtQuick 2.0
import QtQuick.Controls 1.2 as QuickControls
import QtQuick.Layouts 1.1
import Material 0.1
import Material.Extras 0.1

Item {

    FullScreenDialog {
        id: searchDialog
        title: qsTr("Search")
        positiveButtonText: qsTr("Search")

        Column {
            width: parent.width
            spacing: Units.dp(16)

            TextField {
                id: searchText
                placeholderText: qsTr("Search for")
                floatingLabel: true
                Layout.fillWidth: true
            }

            Item {
                width: parent.width
                height: Units.dp(72)

                Ink {
                    anchors.fill: parent
                    z: -1
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.topMargin: Units.dp(16)
                    anchors.bottomMargin: Units.dp(16)

                    ColumnLayout {
                        spacing: Units.dp(3)

                        Label {
                            text: qsTr("Case sensitive")

                            Layout.fillWidth: true

                            elide: Text.ElideRight
                            style: "subheading"
                        }

                        Label {
                            Layout.fillWidth: true

                            text: caseSwitch.checked ? qsTr("Ignore the case") : qsTr("Match the case")
                            color: Theme.light.subTextColor
                            elide: Text.ElideRight
                            wrapMode: Text.WordWrap
                            style: "body1"
                        }
                    }

                    Switch {
                        id: caseSwitch
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            RowLayout {
                width: parent.width
                height: Units.dp(72)

                Label {
                    text: qsTr("Whole words only")

                    Layout.fillWidth: true

                    elide: Text.ElideRight
                    style: "subheading"
                }

                Switch {
                    id: wholeWordSwitch
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: Units.dp(20)

        Button {
            text: "Show full-screen dialog"
            anchors.horizontalCenter: parent.horizontalCenter
            elevation: 1
            onClicked: {
                searchDialog.show()
            }
        }
    }

    Snackbar {
        id: dialogSnackBar
    }
}
