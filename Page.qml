import QtQuick 2.0

Rectangle {
    id: page

    property string title

    property alias actionBar: __actionBar

    ActionBar {
        id: __actionBar

        page: page
    }

    property list<Action> actions
    property Action backAction: Action {
        name: "Back"
        iconName: "navigation/arrow_back"
        onTriggered: pageStack.pop()
        visible: showBackButton
    }

    anchors.fill: parent

    property bool currentPage: pageStack.currentPage == page

    property bool dynamic: false

    signal close

    property bool showBackButton: true

    property var tabs: []
    property int selectedTab
    property Item transition

    property bool cardStyle: false

    z: 0

    color: theme.defaultBackground

    function push() {
        z = pageStack.count
    }

    function pop() {

    }
}
