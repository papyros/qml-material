import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem

Page {
    id: page

    title: "Sub Page"

    ListView {
        anchors.fill: parent
        model: 3
        delegate: ListItem.Standard {
            text: "List Item #" + modelData
        }
    }
}
