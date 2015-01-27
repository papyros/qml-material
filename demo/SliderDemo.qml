import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.1

Item {

    Flickable {
        id: flickable
        clip: true
        anchors.fill: parent
        contentWidth: width
        contentHeight: contents.height
        interactive: contents.height > height

        Item {
            width: flickable.width
            height:  childrenRect.height
            id: contents

            Column {
                anchors.centerIn: parent
                spacing: units.dp(20)

                Repeater {
                    model: 2

                    Rectangle {
                        color: index == 0 ? "#EEE" : "#333"
                        width: grid.implicitWidth + units.dp(50)
                        height: grid.implicitHeight + units.dp(50)
                        radius: units.dp(2)

                        GridLayout {
                            id: grid
                            anchors.centerIn: parent
                            columns: 2
                            rowSpacing: units.dp(20)
                            columnSpacing: units.dp(10)

                            Label {
                                text: "Normal"
                                color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                            }

                            Slider {
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                                darkBackground: index == 1
                                orientation: Qt.Vertical
                            }

                            Label {
                                text: "Tickmarks"
                                color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                            }

                            Slider {
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                                tickmarksEnabled: true
                                stepSize: 20
                                minimumValue: 0
                                maximumValue: 100
                                darkBackground: index == 1
                            }

                            Label {
                                text: "Numeric Value Label"
                                Layout.alignment:  Qt.AlignBottom
                                color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                            }

                            Slider {
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                                tickmarksEnabled: true
                                numericValueLabel: true
                                stepSize: 20
                                minimumValue: 0
                                maximumValue: 100
                                darkBackground: index == 1
                            }

                            Label {
                                text: "Numeric Value Label + Active Focus on Press"
                                wrapMode: Text.WordWrap
                                Layout.alignment:  Qt.AlignBottom
                                color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                            }

                            Slider {
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                                tickmarksEnabled: true
                                numericValueLabel: true
                                stepSize: 20
                                minimumValue: 0
                                maximumValue: 100
                                activeFocusOnPress: true
                                darkBackground: index == 1
                            }

                            Label {
                                text: "Disabled"
                                color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                            }

                            Slider {
                                enabled: false
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                                darkBackground: index == 1
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
}
