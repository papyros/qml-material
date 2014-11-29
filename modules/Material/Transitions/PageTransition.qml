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
import QtQuick 2.0
import Material 0.1

Item {
    id: trans
    anchors.fill: parent

    property PageStack pageStack

    parent: pageStack

    default property alias content: transView.children

    property Item page

    Rectangle {
        id: transView
        visible: false

        width: parent.width
        height: parent.height
        x: parent.width
    }

    function transitionTo(page) {
        print("Transitioning")
        trans.page = page

        page.parent = transView

        page.opacity = 1
        page.visible = true

        transView.visible = true

        trans.z = page.z

        animationTo.start()
    }

    function transitionBack() {
        animationBack.start()
    }

    SequentialAnimation {
        id: animationTo

        NumberAnimation {
            target: transView
            property: "x"
            from: trans.width
            to: 0
            duration: 200
        }

        ScriptAction {
            script: {
                page.parent = pageStack
            }
        }
    }

    SequentialAnimation {
        id: animationBack

        ScriptAction {
            script: {
                page.parent = transView
            }
        }

        NumberAnimation {
            target: transView
            property: "x"
            to: trans.width
            duration: 200
        }

        ScriptAction {
            script: {
                trans.visible = false
            }
        }
    }
}
