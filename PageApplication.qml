import QtQuick 2.0
import "."

Application {
    id: app

    property alias initialPage: pageStack.initialPage

    Toolbar {
        id: toolbar
        z: 2

        backgroundColor: pageStack.currentPage ? pageStack.currentPage.actionBar.background : theme.primary

        tabs: pageStack.currentPage.tabs
        expanded: pageStack.currentPage.cardStyle
    }

    property alias pageStack: pageStack
    property alias toolbar: toolbar

    PageStack {
        id: pageStack

        anchors {
            left: parent.left
            right: parent.right
            top: toolbar.bottom
            bottom: parent.bottom
        }

        onPagePushed: toolbar.pushActionBar(newPage, oldPage)
        onPagePopped: toolbar.popActionBar(previousPage, currentPage)
    }
}
