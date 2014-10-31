import QtQuick 2.3

Image {
    id: icon

    source: {
        var list = name.split("/")

        if (list[0] == "awesome")
            return ""

        print(Qt.resolvedUrl("icons/%1/ic_%2_%3_48dp.png".arg(list[0]).arg(list[1]).arg(color)))

        return Qt.resolvedUrl("icons/%1/ic_%2_%3_48dp.png".arg(list[0]).arg(list[1]).arg(color))
    }

    /*!
       The name of the icon to display.
       \qmlproperty string name
    */
    property string name

    property int size: units.dp(24)

    width: icon.name.indexOf("awesome/") == 0
           ? height : sourceSize.width * height/sourceSize.height
    height: size

    property string color: "grey600"

    mipmap: true

    AwesomeIcon {
        anchors.centerIn: parent
        size: icon.size * 0.9

        visible: icon.name.indexOf("awesome/") == 0

        name: {
            var list = icon.name.split("/")

            print(list[1])

            if (list[0] == "awesome") {
                return list[1]
            }

            return ''
        }

        color: icon.color
    }
}
