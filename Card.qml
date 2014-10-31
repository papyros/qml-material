import QtQuick 2.0

View {
    width: units.gu(30)
    height: units.gu(20)
    elevation: flat ? 0 : 1

    property bool flat: false

    border.color: flat ? Qt.rgba(0,0,0,0.2) : "transparent"
    radius: fullWidth || fullHeight ? 0 : units.dp(2)

}
