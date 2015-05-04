import QtQuick 2.0
import Material 0.1

Dialog {
    id: inputDialog
    
    hasActions: true

    positiveButtonEnabled: textField.acceptableInput

    property alias textField: textField

    property alias validator: textField.validator
    property alias inputMask: textField.inputMask
    property alias inputMethodHints: textField.inputMethodHints
    
    property alias placeholderText: textField.placeholderText
    property alias value: textField.text

    TextField {
        id: textField

        anchors {
            left: parent.left
            right: parent.right
        }
    }
}
