import QtQuick 2.0
import Material 0.1
import Material.Extras 0.1
import QtQuick.Controls 1.2 as QuickControls
import QtQuick.Controls.Styles 1.2

Item {
    id: timePicker
    width: parent.width

    height: content.height

    property bool prefer24Hour: false
    property real clockPadding: Units.dp(24)
    property bool isHours: true
    property int changeCount: 0
    property bool resetFlag: false

    property date timePicked: new Date(Date.now())
    property bool completed: false

    Component.onCompleted: {
        completed = true
        var date = new Date(timePicked)
        var minutes = date.getMinutes()
        date.setMinutes(minutes)
        timePicked = date
    }

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

            var minutes = timePicked.getMinutes()
            minutesPathView.currentIndex = (Math.floor(minutes / 5) * 5) / 5
        }
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
                    text: timePicked.getHours()
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
                    text: timePicked.getMinutes()
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
                    rotation: {
                        var idx = isHours ? hoursPathView.currentIndex : minutesPathView.currentIndex
                        return (360 / ((prefer24Hour && isHours) ? 24 : 12)) * idx
                    }

                    Behavior on rotation {
                        RotationAnimation {
                            id: pointerRotation
                            duration: 200
                            direction: RotationAnimation.Shortest
                            onRunningChanged: {
                                // Switch contexts after we intially set hours, and only then
                                if(!running && isHours && !resetFlag && changeCount > 0) {
                                    setIsHours(false)
                                    resetFlag = true
                                }
                            }
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

                        width: Units.dp(20)
                        height: Units.dp(20)
                        color: "transparent"

                        Label {
                            anchors.centerIn: parent
                            text:{
                                var model = isHours ? hoursPathView.model : minutesPathView.model
                                return model.data < 10 && !isHours ? "0" + modelData : modelData
                            }
                            visible: modelData >= 0
                            style: "body2"
                        }

                        MouseArea {
                            anchors.fill: parent
                            propagateComposedEvents: true
                            onClicked: {
                                var newDate = new Date(timePicked) // Grab a new date from existing

                                var time = parseInt(modelData)
                                if(isHours) {
                                    if(!prefer24Hour && !amPmPicker.isAm)
                                        time += 12

                                    newDate.setHours(time)
                                } else {
                                    newDate.setMinutes(time)
                                }

                                changeCount++
                                timePicked = newDate
                            }
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

                    onCurrentIndexChanged: {
                        var minutes = currentIndex * 5
                        minutesLabel.text = minutes < 10 ? "0" + minutes : minutes
                    }

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
    }

    /**
      Switches contexts

      If previously we hadn't set hours, and we're now switching contexts, disable the auto switch to minutes
      */
    function setIsHours(_isHours) {
        if(_isHours == isHours)
            return

        if(!resetFlag)
            resetFlag = true

        var prevRotation = pointerRotation.duration
        pointerRotation.duration = 0
        isHours = _isHours
        pointerRotation.duration = prevRotation
    }

    /**
      Resets the view after closing
    */
    function reset(){
        changeCount = 0
        isHours = true
        resetFlag = false
        amPmPicker.isAm = true
        timePicked = new Date(Date.now())
    }

    /**
      Provides list of ints for pathview based on the context and user prefs
     */
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

