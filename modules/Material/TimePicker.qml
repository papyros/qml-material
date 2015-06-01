import QtQuick 2.0
import Material 0.1
import Material.Extras 0.1
import QtQuick.Controls 1.2 as QuickControls
import QtQuick.Controls.Styles 1.2

DialogBase {
    id: timePicker
    width: Units.dp(270)

    height: content.height

    property bool prefer24Hour: false
    property real clockPadding: Units.dp(24)
    property bool isHours: true
    property bool resetFlag: false

    signal accepted(real time)
    signal rejected()

    onHidden: {
        reset()
    }

    Column {
        id:content
        height: childrenRect.height
        width: parent.width

        Rectangle {
            id: headerView
            width: parent.width
            height: Units.dp(100)
            color: Theme.primaryColor

            Row {
                id: timeContainer
                anchors.centerIn: parent
                height: Units.dp(48)

                Label {
                    id:hoursLabel
                    style: "display3"
                    color: isHours ? "white" : "#99ffffff"
                    text: "12"
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
                    text:"00"
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

            Label {
                id: ampmLabel
                visible: !prefer24Hour
                style: "body2"
                text: amPmPicker.isAm ? "AM" : "PM"
                anchors {
                    bottom: timeContainer.bottom
                    left: timeContainer.right
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
                color: "#ddd"
                anchors.centerIn: parent
                width: parent.width * 0.8
                height: width
                radius: width / 2

                Rectangle {
                    id: centerPoint
                    anchors.centerIn: parent
                    color: "#444"
                    width: Units.dp(3)
                    height: Units.dp(3)
                    radius: width / 2
                }

                Rectangle {
                    id: pointer
                    color: "#000"
                    width: Units.dp(1)
                    height: circle.height / 2 - clockPadding
                    y: clockPadding
                    anchors.horizontalCenter: parent.horizontalCenter
                    transformOrigin: Item.Bottom
                    rotation: (360 / ((prefer24Hour && isHours) ? 24 : 12)) * pathView.currentIndex

                    Behavior on rotation {
                        RotationAnimation {
                            duration: 200
                            direction: RotationAnimation.Shortest
                            onRunningChanged: {
                                if(!running && isHours && !resetFlag){
                                    setIsHours(false)
                                    resetFlag = true
                                }
                            }
                        }

                    }
                }

                PathView {
                    id: pathView
                    anchors.fill: parent
                    model: {
                        var limit = isHours ? prefer24Hour ? 24 : 12 : 60
                        var zeroBased = !isHours || (isHours && prefer24Hour)
                        return getTimeList(limit, zeroBased)
                    }
                    highlightRangeMode: PathView.NoHighlightRange
                    highlightMoveDuration: 200

                    delegate: Rectangle {

                        width: Units.dp(20)
                        height: Units.dp(20)
                        color: "transparent"

                        Label {
                            anchors.centerIn: parent
                            text: modelData < 10 && !isHours ? "0" + modelData : modelData
                            visible: modelData >= 0
                            style: "body2"
                        }

                        MouseArea {
                            anchors.fill: parent
                            propagateComposedEvents: true
                            onClicked: {
                                var idx = parseInt(modelData)
                                if(isHours && prefer24Hour)
                                    currentIndex--
                                else if(!isHours)
                                    idx /= 5
                                pathView.currentIndex = idx
                                if(isHours){
                                    hoursLabel.text = modelData
                                }
                                else {
                                    var num = modelData
                                    if(num < 10)
                                        minutesLabel.text = "0" + num
                                    else
                                        minutesLabel.text = num
                                }
                            }
                        }
                    }

                    interactive: false
                    highlight: Rectangle {
                        id: highlight
                        width: Units.dp(40)
                        height: Units.dp(40)
                        color: Theme.accentColor
                        radius: width / 2
                    }

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

        Rectangle {
            id: amPmPicker
            height: Units.dp(40)
            width: circle.width
            anchors.horizontalCenter: parent.horizontalCenter
            visible: !prefer24Hour

            property bool isAm: true

            Rectangle {
                id: amButton
                height: Units.dp(40)
                width: Units.dp(40)
                radius: width / 2
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: amPmPicker.isAm ? Theme.primaryColor : "white"

                Label {
                    id: amLabel
                    text: "AM"
                    anchors.centerIn: parent
                    style: "menu"
                    color: amPmPicker.isAm ? "white" : "black"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        amPmPicker.isAm = true
                    }
                }
            }

            Rectangle {
                id: pmButton
                property bool selected: !amButton.selected
                height: Units.dp(40)
                width: Units.dp(40)
                radius: width / 2
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: !amPmPicker.isAm ? Theme.primaryColor : "white"

                Label {
                    id: pmLabel
                    text: "PM"
                    anchors.centerIn: parent
                    style: "menu"
                    color: !amPmPicker.isAm ? "white" : "black"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        amPmPicker.isAm = false
                    }
                }
            }
        }

        Rectangle {
            id: buttonContainer

            anchors {
                bottomMargin: Units.dp(8)
            }
            width: parent.width
            height: buttonView.height + Units.dp(16)

            View {
                id: buttonView
                anchors.verticalCenter: parent.verticalCenter
                height: negativeButton.height + Units.dp(8)
                width: parent.width

                Button {
                    id: negativeButton
                    text: "CANCEL"
                    textColor: Theme.accentColor
                    context: "dialog"

                    anchors {
                        top: parent.top
                        right: positiveButton.left
                        topMargin: Units.dp(8)
                        rightMargin: Units.dp(8)
                    }

                    onClicked: {
                        close();
                        rejected();
                    }
                }

                Button {
                    id: positiveButton
                    text: "OK"
                    textColor: Theme.accentColor
                    context: "dialog"

                    anchors {
                        top: parent.top
                        topMargin: Units.dp(8)
                        rightMargin: Units.dp(16)
                        right: parent.right
                    }

                    onClicked: {
                        close()
                        var date = new Date(Date.now())
                        var hours = parseInt(hoursLabel.text)
                        if(!amPmPicker.isAm && !prefer24Hour)
                            hours += 1
                        date.setHours(hoursLabel.text)
                        date.setMinutes(minutesLabel.text)
                        accepted(date.getTime())
                    }
                }
            }
        }
    }

    function setIsHours(_isHours) {
        isHours = _isHours
        var currentIndex = 0
        if(isHours) {
            currentIndex = parseInt(hoursLabel.text)
            if(!prefer24Hour && currentIndex === 12)
                currentIndex = 0
        } else {
            currentIndex = parseInt(minutesLabel.text) / 5
            if(currentIndex === 12)
                currentIndex = 0
        }
        if(currentIndex == 0 && !isHours)
            currentIndex = 0.1
        pathView.currentIndex = currentIndex
    }

    function reset(){
        pathView.currentIndex = 0
        hoursLabel.text = "12"
        minutesLabel.text = "00"
        isHours = true
        amPmPicker.isAm = true
    }

    function getTimeList(limit, isZeroBased) {
        var items = []
        if(!isZeroBased) {
            items[0] = limit
        }

        var start = isZeroBased ? 0 : 1

        var jump = limit > 24 ? 5 : 1
        for(var i = start; i < limit; i += jump) {
            items[i / jump] = i
        }
        return items
    }
}

