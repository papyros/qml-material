/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    title: qsTr("Hello World")
    width: 640
    height: 480

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }

    toolBar: ToolBar {
        ToolButton {
            text: "Test" 
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    ColumnLayout {
        anchors.centerIn: parent

        CheckBox {
            id: checkBox1
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Check Box")
        }

        RadioButton {
            id: radioButton1
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Radio button")
        }

        Slider {
            anchors.horizontalCenter: parent.horizontalCenter
        }

        GridLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            TextField {
                placeholderText: "Type in contact's name"
            }
            TextField {
                placeholderText: "Type in contact's phone"
             }
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                id: button1
                text: qsTr("Press Me 1")
                onClicked: messageDialog.show(qsTr("Button 1 pressed"))
            }

            Button {
                id: button2
                text: qsTr("Press Me 2")
                onClicked: messageDialog.show(qsTr("Button 2 pressed"))
            }

            Button {
                id: button3
                text: qsTr("Press Me 3")
                onClicked: messageDialog.show(qsTr("Button 3 pressed"))
            }
        }
    }

    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
}
