import QtQuick 2.3
import QtTest 1.0
import Material 0.1

PageStack {
    id: pageStack
    anchors.fill: parent

    Page {
        id: page1
    }

    Page {
        id: page2
    }

    initialPage: page1

    TestCase {
        name: "PageStack Test"
        when: windowShown

        function test_showCard() {
            wait(2000);
        }
    }
}

