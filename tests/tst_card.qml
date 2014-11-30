import QtQuick 2.2
import QtTest 1.0
import Material 0.1

Card {
    width: 100
    height: 100
    id: card

    TestCase {
        name: "Card Test"
        when: windowShown

        function test_showCard() {
            wait(2000);
        }
    }

}
