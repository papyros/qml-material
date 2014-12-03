import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import Material 0.1

Rectangle {
    id: container
    color: Theme.backgroundColor

    default property alias sourceComponent: __contentArea.sourceComponent
    property alias source: __contentArea.source

    property string title: ''
    property alias actionBar: __actionBar
    property list<Action> actions
    property bool cardStyle: false

    ActionBar {
        id: __actionBar
        page: container
        maxActionCount: 0
    }

    property alias backAction: __backAction
    Action {
        id: __backAction
        name: "Back"
        iconName: "navigation/arrow_back"
        onTriggered: container.pop()
        visible: false
    }

    property alias page: __contentArea.item

    function pop()
    {
        Controls.Stack.view.pop();
    }

    function push( component, properties )
    {
        Controls.Stack.view.push( {item: component, properties: properties} );
    }

    Loader {
        id: __contentArea
        anchors.fill: parent
    }
}
