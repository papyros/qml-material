import QtQuick 2.2
import QtTest 1.0
import Material 0.1

Rectangle {
    width: 100
    height: 100

    ApplicationWindow {
        id: mainwin
        title: "Application Name"
        initialPage: Page {
            id: page
            pageStack: mainwin.pageStack
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
