import QtQuick 2.0
import Material 0.1

QtObject {
    id: appTheme

    property color primaryColor: Theme.primaryColor
    property color primaryDarkColor: Theme.primaryDarkColor
    property color accentColor: Theme.accentColor
    property color backgroundColor: Theme.backgroundColor

    onPrimaryColorChanged: Theme.primaryColor = primaryColor
    onPrimaryDarkColorChanged: Theme.primaryDarkColor = primaryDarkColor
    onAccentColorChanged: Theme.accentColor = accentColor
    onBackgroundColorChanged: Theme.backgroundColor = backgroundColor
}

