/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2015 Jordan Neidlinger <JNeidlinger@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle
import QtQuick.Controls.Styles 1.3
import QtQuick.Controls.Private 1.0
import Material 0.3

/*!
   \qmltype DatePicker
   \inqmlmodule Material

   \brief Date Picker provides a simple way to select a valid, formatted date
 */
Controls.Calendar {

    /*!
       Set to \c true if the picker should lay itself in landscape mode
     */
    property bool isLandscape: false
    property int dayAreaBottomMargin : 0

    style: CalendarStyle {
        gridVisible: false

        property int calendarWidth: isLandscape ? 500 * Units.dp : 340 * Units.dp
        property int calendarHeight: isLandscape ? 280 * Units.dp : 440 * Units.dp

        background: Rectangle {
            color: "white"
            implicitWidth: calendarWidth
            implicitHeight: calendarHeight
        }

        navigationBar: Rectangle {
            height: isLandscape ? calendarHeight + 64 * Units.dp : 96 * Units.dp
			width: isLandscape ? calendarWidth / 3 : undefined
			color: Theme.accentColor

			ColumnLayout {
				anchors.verticalCenter: isLandscape ? undefined : parent.verticalCenter
				anchors.left: parent.left
				anchors.leftMargin: isLandscape ? 16 * Units.dp : 24 * Units.dp
				anchors.top: isLandscape ? parent.top : undefined
				anchors.topMargin: isLandscape ? 16 * Units.dp : undefined
				anchors.right: parent.right
				anchors.rightMargin: 36 * Units.dp
				spacing: 0

				Label {
					font.weight: Font.DemiBold
					style: "body2"
					color: Qt.rgba(1, 1, 1, 0.7)
					text: control.selectedDate.toLocaleString(control.__locale, "yyyy")
				}

				Label {
					id: dayTitle
					font.weight: Font.DemiBold
					font.pixelSize: 36 * Units.dp
					Layout.fillWidth: true
					lineHeight: 0.9
					wrapMode: Text.Wrap
					color: Theme.dark.textColor
					text: control.selectedDate.toLocaleString(control.__locale, "ddd, MMM dd")
				}
			}
        }

        dayOfWeekDelegate: Rectangle {
            color: "transparent"
            implicitHeight: 30 * Units.dp
            Label {
                text: control.__locale.dayName(styleData.dayOfWeek, Locale.NarrowFormat).substring(0, 1)
                color: Theme.light.subTextColor
                anchors.centerIn: parent
            }
        }

        dayDelegate: Item {
            visible: styleData.visibleMonth

            Rectangle {
                anchors.centerIn: parent
                width: 1 * Math.min(parent.width, parent.height)
                height: width

                color: styleData.selected ? Theme.accentColor : "transparent"
                radius: height/2
            }

            Label {
                text: styleData.date.getDate()
                anchors.centerIn: parent
                color: styleData.selected
                       ? "white" : styleData.today
						 ? Theme.accentColor : "black"
            }
        }

        panel: Item {
            id: panelItem

            implicitWidth: backgroundLoader.implicitWidth
            implicitHeight: backgroundLoader.implicitHeight

            property alias navigationBarItem: navigationBarLoader.item

            property alias dayOfWeekHeaderRow: dayOfWeekHeaderRow

            readonly property int weeksToShow: 6
            readonly property int rows: weeksToShow
            readonly property int columns: CalendarUtils.daysInAWeek

            // The combined available width and height to be shared amongst each cell.
            readonly property real availableWidth: viewContainer.width
            readonly property real availableHeight: viewContainer.height

            property int hoveredCellIndex: -1
            property int pressedCellIndex: -1
            property int pressCellIndex: -1

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.color: gridColor
                visible: control.frameVisible
            }

            Item {
                id: container
                anchors.fill: parent
                anchors.margins: control.frameVisible ? 1 : 0

                Loader {
                    id: backgroundLoader
                    anchors.fill: parent
                    sourceComponent: background
                }

                Loader {
                    id: navigationBarLoader
                    anchors.left: parent.left
                    anchors.right: isLandscape ? undefined: parent.right
                    anchors.top: parent.top
                    anchors.bottom: isLandscape ? parent.bottom : undefined
                    sourceComponent: navigationBar
                    active: control.navigationBarVisible

                    property QtObject styleData: QtObject {
                        readonly property string title: control.__locale.standaloneMonthName(control.visibleMonth)
                                                        + new Date(control.visibleYear, control.visibleMonth, 1).toLocaleDateString(control.__locale, " yyyy")
                    }
                }

                Rectangle {
                    id: dayOfWeekHeaderRow
                    anchors.top: control.isLandscape ? parent.top : navigationBarLoader.bottom
                    anchors.left: control.isLandscape ? navigationBarLoader.right : parent.left
                    anchors.right: parent.right
                    width: control.isLandscape ? parent.width / 2 : undefined
					height: control.isLandscape ? 72 * Units.dp : 80 * Units.dp
                    color: "transparent"

                    IconButton {
                        iconName: "navigation/chevron_left"
                        id: previousMonth
                        anchors.top: parent.top
						anchors.topMargin: control.isLandscape ? 12 * Units.dp : 16 * Units.dp
                        anchors.left: parent.left
						anchors.leftMargin: 16 * Units.dp
                        onClicked: control.showPreviousMonth()
                    }

                    IconButton {
                        iconName: "navigation/chevron_right"
                        id: nextMonth
                        anchors.top: parent.top
						anchors.topMargin: control.isLandscape ? 12 * Units.dp : 16 * Units.dp
                        anchors.right: parent.right
						anchors.rightMargin: 16 * Units.dp
                        onClicked: control.showNextMonth()
                    }

                    Label {
                        id: monthHeader
                        anchors.verticalCenter: previousMonth.verticalCenter
                        anchors.verticalCenterOffset: -1 * Units.dp
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.weight: Font.Black
                        style: "subheading"
                        text: control.__locale.standaloneMonthName(control.visibleMonth) + " " + control.visibleYear
                    }

                    Row {
                        id: calenderHeader
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
						anchors.leftMargin: (control.weekNumbersVisible ? weekNumbersItem.width : 0) + 8 * Units.dp
                        anchors.right: parent.right
						anchors.rightMargin: 8 * Units.dp

                        spacing: gridVisible ? __gridLineWidth : 0

                        Repeater {
                            id: repeater
                            model: CalendarHeaderModel {
                                locale: control.__locale
                            }
                            Loader {
                                id: dayOfWeekDelegateLoader
                                sourceComponent: dayOfWeekDelegate
                                width: __cellRectAt(index).width

                                readonly property int __index: index
                                readonly property var __dayOfWeek: dayOfWeek

                                property QtObject styleData: QtObject {
                                    readonly property alias index: dayOfWeekDelegateLoader.__index
                                    readonly property alias dayOfWeek: dayOfWeekDelegateLoader.__dayOfWeek
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    id: topGridLine
                    color: __horizontalSeparatorColor
					width: control.isLandscape ? parent.width * (2/3) : parent.width
                    height: __gridLineWidth
                    visible: gridVisible
                    anchors.top: dayOfWeekHeaderRow.bottom
                    anchors.right: control.isLandscape ? parent.right : undefined
                }

                Row {
                    id: gridRow
					width: weekNumbersItem.width + (control.isLandscape ? (viewContainer.width * (2/3)) : viewContainer.width) - 16 * Units.dp
                    height: viewContainer.height - dayAreaBottomMargin
                    anchors.top: topGridLine.bottom
                    anchors.left: control.isLandscape ? topGridLine.left : parent.left
					anchors.leftMargin: 8 * Units.dp

                    Column {
                        id: weekNumbersItem
                        visible: control.weekNumbersVisible
                        height: viewContainer.height - dayAreaBottomMargin
                        spacing: gridVisible ? __gridLineWidth : 0
                        Repeater {
                            id: weekNumberRepeater
                            model: panelItem.weeksToShow

                            Loader {
                                id: weekNumberDelegateLoader
                                height: __cellRectAt(index * panelItem.columns).height
                                sourceComponent: weekNumberDelegate

                                readonly property int __index: index
                                property int __weekNumber: control.__model.weekNumberAt(index)

                                Connections {
                                    target: control
                                    onVisibleMonthChanged: __weekNumber = control.__model.weekNumberAt(index)
                                    onVisibleYearChanged: __weekNumber = control.__model.weekNumberAt(index)
                                }

                                Connections {
                                    target: control.__model
                                    onCountChanged: __weekNumber = control.__model.weekNumberAt(index)
                                }

                                property QtObject styleData: QtObject {
                                    readonly property alias index: weekNumberDelegateLoader.__index
                                    readonly property int weekNumber: weekNumberDelegateLoader.__weekNumber
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: separator
                        anchors.topMargin: - dayOfWeekHeaderRow.height - 1
                        anchors.top: weekNumbersItem.top
                        anchors.bottom: weekNumbersItem.bottom

                        width: __gridLineWidth
                        color: __verticalSeparatorColor
                        visible: control.weekNumbersVisible
                    }

                    // Contains the grid lines and the grid itself.
                    Item {
                        id: viewContainer
						width: (control.isLandscape ? container.width * (2/3) : container.width) - (control.weekNumbersVisible ? weekNumbersItem.width + separator.width : 0) - 16 * Units.dp
                        height: container.height - (control.isLandscape ? 0 : navigationBarLoader.height) - dayOfWeekHeaderRow.height - topGridLine.height - dayAreaBottomMargin

                        Repeater {
                            id: verticalGridLineRepeater
                            model: panelItem.columns - 1
                            delegate: Rectangle {
                                x: __cellRectAt(index + 1).x - __gridLineWidth
                                y: 0
                                width: __gridLineWidth
                                height: viewContainer.height
                                color: gridColor
                                visible: gridVisible
                            }
                        }

                        Repeater {
                            id: horizontalGridLineRepeater
                            model: panelItem.rows - 1
                            delegate: Rectangle {
                                x: 0
                                y: __cellRectAt((index + 1) * panelItem.columns).y - __gridLineWidth
                                width: viewContainer.width
                                height: __gridLineWidth
                                color: gridColor
                                visible: gridVisible
                            }
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent

                            hoverEnabled: true

                            function cellIndexAt(mouseX, mouseY) {
                                var viewContainerPos = viewContainer.mapFromItem(mouseArea, mouseX, mouseY);
                                var child = viewContainer.childAt(viewContainerPos.x, viewContainerPos.y);
                                // In the tests, the mouseArea sometimes gets picked instead of the cells,
                                // probably because stuff is still loading. To be safe, we check for that here.
                                return child && child !== mouseArea ? child.__index : -1;
                            }

                            onEntered: {
                                hoveredCellIndex = cellIndexAt(mouseX, mouseY);
                                if (hoveredCellIndex === undefined) {
                                    hoveredCellIndex = cellIndexAt(mouseX, mouseY);
                                }

                                var date = view.model.dateAt(hoveredCellIndex);
                                if (__isValidDate(date)) {
                                    control.hovered(date);
                                }
                            }

                            onExited: {
                                hoveredCellIndex = -1;
                            }

                            onPositionChanged: {
                                var indexOfCell = cellIndexAt(mouse.x, mouse.y);
                                var previousHoveredCellIndex = hoveredCellIndex;
                                hoveredCellIndex = indexOfCell;
                                if (indexOfCell !== -1) {
                                    var date = view.model.dateAt(indexOfCell);
                                    if (__isValidDate(date)) {
                                        if (hoveredCellIndex !== previousHoveredCellIndex)
                                            control.hovered(date);

                                        // The date must be different for the pressed signal to be emitted.
                                        if (pressed && date.getTime() !== control.selectedDate.getTime()) {
                                            control.pressed(date);

                                            // You can't select dates in a different month while dragging.
                                            if (date.getMonth() === control.selectedDate.getMonth()) {
                                                control.selectedDate = date;
                                                pressedCellIndex = indexOfCell;
                                            }
                                        }
                                    }
                                }
                            }

                            onPressed: {
                                pressCellIndex = cellIndexAt(mouse.x, mouse.y);
                                if (pressCellIndex !== -1) {
                                    var date = view.model.dateAt(pressCellIndex);
                                    pressedCellIndex = pressCellIndex;
                                    if (__isValidDate(date) && (date.getMonth() === control.visibleMonth && date.getFullYear() === control.visibleYear)) {
                                        control.selectedDate = date;
                                        control.pressed(date);
                                    }
                                }
                            }

                            onReleased: {
                                var indexOfCell = cellIndexAt(mouse.x, mouse.y);
                                if (indexOfCell !== -1) {
                                    // The cell index might be valid, but the date has to be too. We could let the
                                    // selected date validation take care of this, but then the selected date would
                                    // change to the earliest day if a day before the minimum date is clicked, for example.
                                    var date = view.model.dateAt(indexOfCell);
                                    if (__isValidDate(date)) {
                                        control.released(date);
                                    }
                                }
                                pressedCellIndex = -1;
                            }

                            onClicked: {
                                var indexOfCell = cellIndexAt(mouse.x, mouse.y);
                                if (indexOfCell !== -1 && indexOfCell === pressCellIndex) {
                                    var date = view.model.dateAt(indexOfCell);
                                    if (__isValidDate(date))
                                        control.clicked(date);
                                }
                            }

                            onDoubleClicked: {
                                var indexOfCell = cellIndexAt(mouse.x, mouse.y);
                                if (indexOfCell !== -1) {
                                    var date = view.model.dateAt(indexOfCell);
                                    if (__isValidDate(date))
                                        control.doubleClicked(date);
                                }
                            }

                            onPressAndHold: {
                                var indexOfCell = cellIndexAt(mouse.x, mouse.y);
                                if (indexOfCell !== -1 && indexOfCell === pressCellIndex) {
                                    var date = view.model.dateAt(indexOfCell);
                                    if (__isValidDate(date))
                                        control.pressAndHold(date);
                                }
                            }
                        }

                        Connections {
                            target: control
                            onSelectedDateChanged: view.selectedDateChanged()
                        }

                        Repeater {
                            id: view

                            property int currentIndex: -1

                            model: control.__model

                            Component.onCompleted: selectedDateChanged()

                            function selectedDateChanged() {
                                if (model !== undefined && model.locale !== undefined) {
                                    currentIndex = model.indexAt(control.selectedDate);
                                }
                            }

                            delegate: Loader {
                                id: delegateLoader

                                x: __cellRectAt(index).x
                                y: __cellRectAt(index).y
                                width: __cellRectAt(index).width
                                height: __cellRectAt(index).height
                                sourceComponent: dayDelegate

                                readonly property int __index: index
                                readonly property date __date: date
                                // We rely on the fact that an invalid QDate will be converted to a Date
                                // whose year is -4713, which is always an invalid date since our
                                // earliest minimum date is the year 1.
                                readonly property bool valid: __isValidDate(date)

                                property QtObject styleData: QtObject {
                                    readonly property alias index: delegateLoader.__index
                                    readonly property bool selected: control.selectedDate.getTime() === date.getTime()
                                    readonly property alias date: delegateLoader.__date
                                    readonly property bool valid: delegateLoader.valid
                                    // TODO: this will not be correct if the app is running when a new day begins.
                                    readonly property bool today: date.getTime() === new Date().setHours(0, 0, 0, 0)
                                    readonly property bool visibleMonth: date.getMonth() === control.visibleMonth
                                    readonly property bool hovered: panelItem.hoveredCellIndex == index
                                    readonly property bool pressed: panelItem.pressedCellIndex == index
                                    // todo: pressed property here, clicked and doubleClicked in the control itself
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
