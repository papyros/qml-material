/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer
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
import Material 0.1

Rectangle {
    width: 100
    height: 100

    ApplicationWindow {
        id: mainwin
        title: "Application Name"
        width: 100
        height: 100

        initialPage: Page {
            id: page
            title: "Page Title"

            Label {
                anchors.centerIn: parent
                text: "Hello World!"
            }
        }

        Component.onCompleted: mainwin.show()
    }

    TestCase {
        name: "PageStack Test"
        when: mainwin.visible

        function test_showCard() {
            wait(2000);
            console.log('here');

            verify( page !== null )
            verify( page !== undefined )
        }
    }

}
