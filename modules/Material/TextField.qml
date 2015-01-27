/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Bogdan Cuza <bogdan.cuza@hotmail.com>
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
import QtQuick 2.2
import Material 0.1

/*
 * Note that this is a FocusScope, not a TextInput. If you need to read or
 * write properties of the input itself, use the input property.
 */
FocusScope {
   id: field

   property color accentColor: Theme.accentColor
   property color errorColor: "#F44336"
   property bool floatingLabel: false
   property bool showHelperText: helperText.length > 0
   property alias helperText: helperTextLabel.text
   property bool displayError: false
   property bool showCharacterCounter: characterLimit > 0
   property int characterLimit
   readonly property int characterCount: text.length
   readonly property rect inputRect: Qt.rect(textInput.x, textInput.y, textInput.width, textInput.height)
   property alias text: textInput.text
   property alias placeholderText: fieldPlaceholder.text
   readonly property alias input: textInput

   signal accepted()
   signal editingFinished()

   implicitHeight: showHelperText ? helperTextLabel.y + helperTextLabel.height + units.dp(4)
                          : underline.y + units.dp(8)
   width: units.dp(200)

   MouseArea {
      anchors.fill: parent
      onClicked: field.forceActiveFocus(Qt.MouseFocusReason)
   }

   TextInput {
      id: textInput
      focus: true
      color: "black"
      selectedTextColor: "white"
      selectionColor: Qt.darker(field.accentColor, 1)
      selectByMouse: Device.type === Device.desktop
      activeFocusOnTab: true
      width: parent.width
      clip: true
      y: {
         if( !floatingLabel )
            return units.dp(16)
         if( floatingLabel && !showHelperText )
            return units.dp(40)
         return units.dp(28)
      }
      font {
         family: echoMode == TextInput.Password && field.text.length > 0 ? "" : "Roboto"
         pixelSize: units.dp(16)
      }

      onAccepted: field.accepted()
      onEditingFinished: field.editingFinished()
   }

   Label {
      id: fieldPlaceholder
      text: field.placeholderText
      font.pixelSize: units.dp(16)
      anchors.baseline: textInput.baseline
      anchors.bottomMargin: units.dp(8)
      color: Theme.light.hintColor

      states: [
         State {
            name: "floating"
            when: textInput.text.length > 0 && floatingLabel
            AnchorChanges {
               target: fieldPlaceholder
               anchors.baseline: undefined
               anchors.bottom: textInput.top
            }
            PropertyChanges {
               target: fieldPlaceholder
               font.pixelSize: units.dp(12)
            }
         },
         State {
            name: "hidden"
            when: textInput.text.length > 0 && !floatingLabel
            PropertyChanges {
               target: fieldPlaceholder
               visible: false
            }
         }
      ]
      transitions: [
         Transition {
            id: floatingTransition
            enabled: false
            AnchorAnimation {
               duration: 200
            }
            NumberAnimation {
               duration: 200
               property: "font.pixelSize"
            }
         }
      ]

      Component.onCompleted: floatingTransition.enabled = true
   }

   Rectangle {
      id: underline
      color: field.displayError ||
             (field.showCharacterCounter &&
              field.characterCount > field.characterLimit) ? field.errorColor
                                                           : field.activeFocus ? field.accentColor
                                                                               : Theme.light.hintColor
      height: field.activeFocus ? units.dp(2) : units.dp(1)
      anchors {
         left: parent.left
         right: parent.right
         top: textInput.bottom
         topMargin: units.dp(8)
      }

      Behavior on height {
         NumberAnimation { duration: 200 }
      }

      Behavior on color {
         ColorAnimation { duration: 200 }
      }
   }

   Label {
      id: helperTextLabel
      visible: field.showHelperText
      font.pixelSize: units.dp(12)
      color: field.displayError? field.errorColor : Qt.darker(Theme.light.hintColor)
      anchors {
         left: parent.left
         right: parent.right
         top: underline.top
         topMargin: units.dp(4)
      }

      Behavior on color {
         ColorAnimation { duration: 200 }
      }
   }

   Label {
      id: characterCounterLabel
      visible: field.showCharacterCounter
      font.pixelSize: units.dp(12)
      font.weight: Font.Light
      color: field.characterCount <= field.characterLimit? Qt.darker(Theme.light.hintColor) : field.errorColor
      text: field.characterCount + " / " + field.characterLimit
      anchors {
         right: parent.right
         top: underline.top
         topMargin: units.dp(8)
      }

      Behavior on color {
         ColorAnimation { duration: 200 }
      }
   }
}
