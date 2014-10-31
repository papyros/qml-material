import QtQuick 2.0

QtObject {
    property string name
    property string description
    property string shortcut
    property string iconName
    property string style: "default"
    property bool hasDividerAfter

    signal triggered
}
