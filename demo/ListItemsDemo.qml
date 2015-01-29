import QtQuick 2.0
import Material 0.1
import Material.ListItems 0.1 as ListItem
import Material.Extras 0.1

Item {
    View {
        anchors {
            fill: parent
            margins: units.dp(32)
        }

        elevation: 1

        Column {
            anchors.fill: parent

            ListItem.Header {
                text: "Section header"
            }

            ListItem.Standard {
                text: "Standard list item"
            }

            ListItem.Subtitled {
                text: "Subtitled list item"
                subText: "With some subtext!"
            }

            ListItem.SimpleMenu {
                text: "Subtitled list item"
                model: ["A", "B", "C"]
            }
        }
    }
}
