import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.1
import Material.ListItems 0.1 as ListItem
import Material.Extras 0.1

ColumnLayout {

    DatePickerDialog {
        id: datePickerDialog
    }

    DatePickerDialog {
        id: landscapeDatePickerDialog
        datePicker.isLandscape: true
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: Units.dp(16)

        Button {
            Layout.alignment: Qt.AlignCenter
            text: "Show DatePicker Dialog"
            elevation: 1
            onClicked: {
                datePickerDialog.show()
            }
        }

        Button {
            Layout.alignment: Qt.AlignCenter
            text: "Show Landscape DatePicker Dialog"
            elevation: 1
            onClicked: {
                landscapeDatePickerDialog.show()
            }
        }

        DatePicker {
            Layout.alignment: Qt.AlignCenter
        }

        DatePicker {
            Layout.alignment: Qt.AlignCenter
            isLandscape: true
        }
    }
}
