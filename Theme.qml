import QtQuick 2.0

QtObject {

    property color primary: "#5677fc"
    property color secondary: "white"

    property color temp

    function blackColor(style) {
        if (style == 'text') {
            return Qt.rgba(0,0,0,0.7)
            //return Qt.rgba(0,0,0,0.87)
        } else if (style == 'secondary' || style == 'icon') {
            return Qt.rgba(0,0,0,0.54)
        } else if (style == 'hint') {
            return Qt.rgba(0,0,0,0.26)
        } else if (style == 'divider') {
            return Qt.rgba(0,0,0,0.12)
        }
    }

    function colorize(color, alpha) {
        temp = color
        print(temp.r,temp.g,temp.b,alpha)
        print(Qt.rgba(temp.r,temp.g,temp.b,alpha))
        return Qt.rgba(temp.r,temp.g,temp.b,alpha)
    }

    function styleColor(style) {
        if (style == "default")
            return blackColor('text')
        else
            return primary
    }
}
