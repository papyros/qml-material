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
import Material 0.1
import Material.Extras 0.1

/*!
   \qmltype OverlayView
   \inqmlmodule Material 0.1

   \brief A view that pops out of the content to display as an overlay.
 */
PopupBase {
	id: overlay

	overlayLayer: "dialogOverlayLayer"
	overlayColor: Qt.rgba(0, 0, 0, 0.3)

	visible: transitionOpacity > 0
	state: showing ? "visible" : "hidden"

    x: (parent.width - width)/2
    y: (parent.height - height)/2

    property alias transitionOpacity: shadow.opacity

    states: [
    	State {
    		name: "hidden"

    		PropertyChanges {
    			target: overlay
    			x: sourceView ? sourceView.mapToItem(overlay.parent, 0, 0).x : 0
    			y: sourceView ? sourceView.mapToItem(overlay.parent, 0, 0).y : 0
    			width: sourceView ? sourceView.width : 0
    			height: sourceView ? sourceView.height : 0
    		}
    	}
    ]

    transitions: Transition {
    	from: "*"; to: "*"

    	NumberAnimation {
    		target: overlay
    		properties: "x,y,width,height"
    	    duration: 300; easing.type: Easing.InOutQuad
        }
    }

    property Item sourceView

	function open(sourceView) {
		overlay.sourceView = sourceView;
		
		parent = Utils.findRootChild(overlay, overlayLayer)
        showing = true
        forceActiveFocus()
        parent.currentOverlay = overlay

        opened()
    }

    function close() {
        showing = false
        parent.currentOverlay = null
        sourceView = null
    }

    View {
    	id: shadow

    	anchors.fill: parent
    	opacity: showing ? 1 : 0
    	elevation: 5

    	Behavior on opacity {
    		NumberAnimation {
	    		duration: 300; easing.type: Easing.InOutQuad
	        }
    	}
    }
}
