/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Steve Coffey
 * Copyright (C) 2015 Jordan Neidlinger <JNeidlinger@gmail.com>
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
import Material 0.1
import Material.Extras 0.1
import QtQuick.Controls 1.3 as QuickControls
import QtQuick.Controls.Styles 1.3

FocusScope {
    id: timePicker

    width: Units.dp(300)
    height: content.height

    /*!
       Set to \c true if selection is 24 hour based. Defaults to false
     */
    property bool prefer24Hour: false

    /*!
       The visual padding around the clock element
     */
    property real clockPadding: Units.dp(24)

    /*!
       Set to \c true if the time picker should first show the hours. Defaults to true
     */
    property bool isHours: true

    /*!
       Sets the bottom margin for the time picker
     */
    property int bottomMargin: 0

    Keys.onUpPressed: {
        var date = internal.timePicked

        if(isHours)
            date.setHours(internal.timePicked.getHours() + 1)
        else
            date.setMinutes(internal.timePicked.getMinutes() + 1)

        internal.timePicked = date
    }

    Keys.onDownPressed: {
        var date = internal.timePicked

        if(isHours)
            date.setHours(internal.timePicked.getHours() - 1)
        else
            date.setMinutes(internal.timePicked.getMinutes() - 1)

        internal.timePicked = date
    }

    Keys.onLeftPressed: {
        if(!isHours)
            setIsHours(true)
    }

    Keys.onRightPressed: {
        if(isHours)
            setIsHours(false)
    }

    property string __digitsPressed

    Keys.onDigit0Pressed: setDigitsPressed(0)
    Keys.onDigit1Pressed: setDigitsPressed(1)
    Keys.onDigit2Pressed: setDigitsPressed(2)
    Keys.onDigit3Pressed: setDigitsPressed(3)
    Keys.onDigit4Pressed: setDigitsPressed(4)
    Keys.onDigit5Pressed: setDigitsPressed(5)
    Keys.onDigit6Pressed: setDigitsPressed(6)
    Keys.onDigit7Pressed: setDigitsPressed(7)
    Keys.onDigit8Pressed: setDigitsPressed(8)
    Keys.onDigit9Pressed: setDigitsPressed(9)

    QtObject {
        id: internal
        property bool resetFlag: false
        property date timePicked
        property bool completed: false

        onTimePickedChanged: {
            if(completed) {
                var hours = timePicked.getHours()
                if(hours > 11 && !prefer24Hour){
                    hours -= 12
                    amPmPicker.isAm = false
                } else {
                    amPmPicker.isAm = true
                }

                hoursPathView.currentIndex = hours

                var minutes = internal.timePicked.getMinutes()
                minutesPathView.currentIndex = minutes
            }
        }
    }

    Component.onCompleted: {
        internal.completed = true
        internal.timePicked = new Date(Date.now())
                forceActiveFocus()
    }

    Column {
        id:content
        height: childrenRect.height + bottomMargin
        width: parent.width

        Rectangle {
            id: headerView
            width: parent.width
            height: Units.dp(88)
            color: Theme.accentColor

            Row {
                id: timeContainer
                anchors.centerIn: parent
                height: Units.dp(48)

                Label {
                    id:hoursLabel
                    style: "display3"
                    color: isHours ? "white" : "#99ffffff"
                    text: internal.timePicked.getHours()
                    anchors.verticalCenter: parent.verticalCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(!isHours){
                                setIsHours(true)
                            }
                        }
                    }
                }

                Label {
                    style: "display3"
                    color: "white"
                    text:":"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Label {
                    id: minutesLabel
                    style: "display3"
                    color: !isHours ? "white" : "#99ffffff"
                    text: internal.timePicked.getMinutes() < 10 ? "0" +  internal.timePicked.getMinutes() : internal.timePicked.getMinutes()
                    anchors.verticalCenter: parent.verticalCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(isHours){
                                setIsHours(false)
                            }
                        }
                    }
                }
            }

            Column {
                id: amPmPicker
                visible: !prefer24Hour

                property bool isAm: true

                anchors {
                    bottom: timeContainer.bottom
                    left: timeContainer.right
                    leftMargin: Units.dp(12)
                }

                spacing: Units.dp(4)

                Label {
                    style: "subheading"
                    font.weight: Font.DemiBold
                    color: amPmPicker.isAm ? "white" : "#99ffffff"
                    text: "AM"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: amPmPicker.isAm = true
                    }
                }

                Label {
                    style: "subheading"
                    font.weight: Font.DemiBold
                    color: !amPmPicker.isAm ? "white" : "#99ffffff"
                    text: "PM"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: amPmPicker.isAm = false
                    }
                }
            }
        }

        Rectangle {
            id: picker
            width: parent.width
            height: width
            color: "white"

            Rectangle {
                id: circle
                color: "#eee"
                anchors.centerIn: parent
                width: parent.width * 0.9
                height: width
                radius: width / 2

                Rectangle {
                    id: centerPoint
                    anchors.centerIn: parent
                    color: Theme.accentColor
                    width: Units.dp(8)
                    height: Units.dp(8)
                    radius: width / 2
                }

                Rectangle {
                    id: pointer
                    color: Theme.accentColor
                    width: Units.dp(2)
                    height: circle.height / 2 - clockPadding
                    y: clockPadding
                    anchors.horizontalCenter: parent.horizontalCenter
                    antialiasing: true
                    transformOrigin: Item.Bottom

                    Connections {
                        target: hoursPathView
                        onCurrentIndexChanged: {
                            if(isHours)
                                pointer.setAngle()
                        }
                    }

                    Connections {
                        target: minutesPathView
                        onCurrentIndexChanged: {
                            if(!isHours)
                                pointer.setAngle()
                        }
                    }

                    Connections {
                        target: timePicker
                        onIsHoursChanged: pointer.setAngle()
                    }

                    function setAngle()
                    {
                        var idx = isHours ? hoursPathView.currentIndex : minutesPathView.currentIndex
                        var angle
                        if(isHours)
                            angle = (360 / ((prefer24Hour) ? 24 : 12)) * idx
                        else
                            angle = 360 / 60 * idx

                        if(Math.abs(pointer.rotation - angle) == 180)
                            pointerRotation.direction = RotationAnimation.Clockwise
                        else
                            pointerRotation.direction = RotationAnimation.Shortest

                        pointer.rotation = angle
                    }

                    Behavior on rotation {
                        RotationAnimation {
                            id: pointerRotation
                            duration: 200
                            direction: RotationAnimation.Shortest
                        }
                    }
                }

                Component {
                    id: pathViewHighlight
                    Rectangle {
                        id: highlight
                        width: Units.dp(40)
                        height: Units.dp(40)
                        color: Theme.accentColor
                        radius: width / 2
                    }
                }

                Component {
                    id: pathViewItem
                    Rectangle {
                        id: rectangle
                        width: !isHours && modelData % 5 == 0 ? Units.dp(12) : isHours ? Units.dp(30) : Units.dp(8)
                        height: !isHours && modelData % 5 == 0 ? Units.dp(12) : isHours ? Units.dp(30) : Units.dp(8)
                        color: "transparent"

                        property bool isSelected: false

                        Label {
                            anchors.centerIn: parent
                            text:{
                                var model = isHours ? hoursPathView.model : minutesPathView.model
                                return model.data < 10 && !isHours ? "0" + modelData : modelData
                            }
                            visible: modelData >= 0 && (isHours ? true : modelData % 5 == 0)
                            style: "subheading"
                        }

                        Connections {
                            target: parentMouseArea

                            onClicked: {
                                checkClick(false)
                            }

                            onPositionChanged: {
                                checkClick(true)
                            }

                            function checkClick(isPress)
                            {
                                if((isPress ? parentMouseArea.leftButtonPressed : true) && rectangle.visible) {
                                    var thisPosition = rectangle.mapToItem(null, 0, 0, width, height)

                                    if(parentMouseArea.globalX > thisPosition.x &&
                                        parentMouseArea.globalY > thisPosition.y &&
                                        parentMouseArea.globalX < (thisPosition.x + width) &&
                                        parentMouseArea.globalY < (thisPosition.y + height)) {

                                        if(!rectangle.isSelected) {
                                            rectangle.isSelected = true

                                            var newDate = new Date(internal.timePicked) // Grab a new date from existing

                                            var time = parseInt(modelData)
                                            if(isHours) {
                                                if(!prefer24Hour && !amPmPicker.isAm && time < 12) {
                                                    time += 12
                                                }
                                                else if(!prefer24Hour && amPmPicker.isAm && time === 12) {
                                                    time = 0
                                                }

                                                newDate.setHours(time)
                                            } else {
                                                newDate.setMinutes(time)
                                            }

                                            internal.timePicked = newDate
                                        }
                                    }
                                    else {
                                        rectangle.isSelected = false
                                    }
                                }
                            }
                        }
                    }
                }

                MouseArea {
                    property bool leftButtonPressed
                    property int globalX
                    property int globalY
                    id: parentMouseArea
                    anchors.fill: circle
                    hoverEnabled: true

                    onClicked: {
                        globalX = parentMouseArea.mapToItem(null, mouse.x, mouse.y).x
                        globalY = parentMouseArea.mapToItem(null, mouse.x, mouse.y).y
                    }

                    onPositionChanged: {
                        if(containsPress)
                        {
                            leftButtonPressed = true
                            globalX = parentMouseArea.mapToItem(null, mouse.x, mouse.y).x
                            globalY = parentMouseArea.mapToItem(null, mouse.x, mouse.y).y
                        }
                        else
                        {
                            leftButtonPressed = false
                        }
                    }
                }


                PathView {
                    id: hoursPathView
                    anchors.fill: parent
                    visible: isHours
                    model: {
                        var limit = prefer24Hour ? 24 : 12
                        var zeroBased = prefer24Hour
                        return getTimeList(limit, zeroBased)
                    }
                    highlightRangeMode: PathView.NoHighlightRange
                    highlightMoveDuration: 200

                    onCurrentIndexChanged: {
                        var newText = currentIndex
                        if(currentIndex == 0 && !prefer24Hour)
                            newText = 12
                        hoursLabel.text = newText
                    }

                    delegate: pathViewItem

                    interactive: false
                    highlight: pathViewHighlight

                    path: Path {
                        startX: circle.width / 2
                        startY: clockPadding

                        PathArc {
                            x: circle.width / 2
                            y: circle.height - clockPadding
                            radiusX: circle.width / 2 - clockPadding
                            radiusY: circle.width / 2 - clockPadding
                            useLargeArc: false
                        }

                        PathArc {
                            x: circle.width / 2
                            y: clockPadding
                            radiusX: circle.width / 2 - clockPadding
                            radiusY: circle.width / 2 - clockPadding
                            useLargeArc: false
                        }
                    }
                }

                PathView {
                    id: minutesPathView
                    anchors.fill: parent
                    visible: !isHours
                    model: {
                        return getTimeList(60, true)
                    }
                    highlightRangeMode: PathView.NoHighlightRange
                    highlightMoveDuration: 200
                    delegate: pathViewItem
                    highlight: pathViewHighlight
                    interactive: false

                    path: Path {
                        startX: circle.width / 2
                        startY: clockPadding

                        PathArc {
                            x: circle.width / 2
                            y: circle.height - clockPadding
                            radiusX: circle.width / 2 - clockPadding
                            radiusY: circle.width / 2 - clockPadding
                            useLargeArc: false
                        }

                        PathArc {
                            x: circle.width / 2
                            y: clockPadding
                            radiusX: circle.width / 2 - clockPadding
                            radiusY: circle.width / 2 - clockPadding
                            useLargeArc: false
                        }
                    }
                }
            }
        }
    }

    /**
      Switches contexts

      If previously we hadn't set hours, and we're now switching contexts, disable the auto switch to minutes
      */
    function setIsHours(_isHours) {
        if(_isHours == isHours)
            return

        if(!internal.resetFlag)
            internal.resetFlag = true

        var prevRotation = pointerRotation.duration
        pointerRotation.duration = 0
        isHours = _isHours
        pointerRotation.duration = prevRotation
    }

    function getCurrentTime() {
        var date = new Date(internal.timePicked)
        if(amPmPicker.isAm && date.getHours() > 11)
            date.setHours(date.getHours() - 12)
        else if(!amPmPicker.isAm && date.getHours() < 11)
            date.setHours(date.getHours() + 12)

        return date
    }

    /*!
       \internal
       Resets the view after closing
     */
    function reset() {
        isHours = true
        internal.resetFlag = false
        amPmPicker.isAm = true
        internal.timePicked = new Date(Date.now())
    }

    /*!
       \internal
       Provides list of ints for pathview based on the context and user prefs
     */
    function getTimeList(limit, isZeroBased) {
        var items = []
        if(!isZeroBased) {
            items[0] = limit
        }

        var start = isZeroBased ? 0 : 1

        var jump = limit > 24 ? 1 : 1
        for(var i = start; i < limit; i += jump) {
            items[i / jump] = i
        }
        return items
    }

    /*!
       \internal
     */
    function setDigitsPressed(minute)
    {
        if(__digitsPressed.length > 1) {
            __digitsPressed = ""
            __digitsPressed = minute
        }
        else {
            __digitsPressed += minute
        }

        var date = internal.timePicked
        var value = parseInt(__digitsPressed)

        if((isHours && value > 23) || (!isHours && value > 59)) {
            __digitsPressed = ""
            return
        }

        if(isHours)
            date.setHours(value)
        else
            date.setMinutes(value)

        internal.timePicked = date
    }
}
