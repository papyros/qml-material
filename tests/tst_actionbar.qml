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
import QtTest 1.0
import Material 0.2

Rectangle {
    width: 400
    height: 800

    ActionBar {
        id: actionBar

        width: parent.width

        actions: [
            Action {
                id: action1
                name: "Action 1"
                iconName: "content/add"
                objectName: "action1"
            },
            Action {
                name: "Action 2"
                iconName: "action/search"
            },
            Action {
                name: "Action 3"
                iconName: "action/settings"
            },
            Action {
                id: action4
                name: "Action 4"
                objectName: "action4"
                iconName: "action/alarm"
            }
        ]
    }

    OverlayLayer {
        id: tooltipOverlayLayer
        objectName: "tooltipOverlayLayer"
    }

    OverlayLayer {
        id: overlayLayer
    }

    SignalSpy {
        id: action1Spy
        target: action1
        signalName: "triggered"
    }

    SignalSpy {
        id: action4Spy
        target: action4
        signalName: "triggered"
    }

    SignalSpy {
        id: overflowSpy
        target: testCase.findChild(actionBar, "action/overflow")
        signalName: "clicked"
    }

    TestCase {
        id: testCase
        when: windowShown
        name: "ActionBar Test"

        function init() {
            var button = testCase.findChild(actionBar, "action/overflow")
            var overflow = testCase.findChild(actionBar, "overflowMenu")
            verify(button != null)
            verify(overflow != null)

            if (overflow.showing) {
                mouseClick(button, 10, 10)
                wait(10000)
            }

            verify(!overflow.showing)

            overflowSpy.clear()
        }

        function test_click_action() {
            var button = testCase.findChild(actionBar, "action/" + action1.objectName)

            verify(button != null)

            compare(action1Spy.count, 0)
            mouseClick(button, 10, 10)
            wait(10000) // Wait for the overflow to fully open
            compare(action1Spy.count, 1)
        }

        function test_open_overflow() {
            var button = testCase.findChild(actionBar, "action/overflow")
            var overflow = testCase.findChild(actionBar, "overflowMenu")

            verify(button != null)
            verify(overflow != null)

            verify(!overflow.showing)
            compare(overflowSpy.count, 0)
            mouseClick(button, 10, 10)
            wait(10000) // Wait for the overflow to fully open
            compare(overflowSpy.count, 1)
            verify(overflow.showing)
        }

        function test_click_action_in_overflow() {
            var button = testCase.findChild(actionBar, "action/overflow")
            var listItem = testCase.findChild(actionBar, "action/" + action4.objectName)
            var overflow = testCase.findChild(actionBar, "overflowMenu")

            verify(button != null)
            verify(listItem != null)
            verify(overflow != null)

            compare(action4Spy.count, 0)
            mouseClick(button, 10, 10)

            wait(10000) // Wait for the overflow to fully open

            verify(overflow.showing)
            mouseClick(listItem, 10, 10)
            compare(action4Spy.count, 1)

            wait(400)
        }
    }
}
