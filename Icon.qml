import QtQuick 2.3

Image {
    id: icon

    source: {
        var list = name.split("/")

        if (name == "" || list[0] == "awesome")
            return ""

        var color = icon.color

        if (color == 'gray' || color == 'grey')
            color = 'grey600'

        var dp_size = "18"

        if (size > units.dp(36))
            dp_size = "48"
        if (size > units.dp(24))
            dp_size = "36"
        else if (size > units.dp(18))
            dp_size = "24"


        return Qt.resolvedUrl("icons/%1/ic_%2_%3_%4dp.png".arg(list[0]).arg(list[1]).arg(color).arg(dp_size))
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

            if (list[0] == "awesome") {
                return list[1]
            }

            return ''
        }

        color: icon.color
    }
}
