import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.1
import Material.Extras 0.1

/*!
   \qmltype FullScreenDialog
   \inqmlmodule Material 0.1

   \brief Full-screen dialogs group complex tasks that require explicit
   action, such as save or create, before changes are committed or
   discarded, as in a calendar entry.
 */
PopupBase {
    id: dialog

    overlayLayer: "fullDialogOverlayLayer"
    overlayColor: Qt.rgba(0, 0, 0, 0.3)
    dismissOnTap: false

    opacity: showing ? 1 : 0
    visible: opacity > 0

    readonly property int _minimumWidth: 640
    readonly property int _minimumHeight: 1280
    readonly property real _rw: 1.25
    readonly property real _rh: 1.12

    onVisibleChanged: {
        // orientation > 1 means landscape, orientation < 1 means portrait
        var orientation = parent.width / parent.height
        if (orientation >= 1 /*landscape*/) {
            if (Units.dp(parent.width) <= _minimumWidth) {
                width = parent.width
            } else {
                width = parent.width / 2
            }
            height = parent.height
        } else {
            if (Units.dp(parent.height) < _minimumHeight) {
                width = parent.width
                height = parent.height
            } else {
                width = parent.width / _rw
                height = parent.height / _rh
            }
        }
    }

    property int contentMargins: Units.dp(16)

    /*!
      \qmlproperty color titleBarColor

      The color of the title bar. By default, it uses the application's primary color.
     */
    property color titleBarColor: Theme.primaryColor

    property alias title: titleLabel.text

    /*!
       \qmlproperty Button negativeButton

       The negative button, displayed as the leftmost button on the right of the dialog buttons.
       This is usually used to dismiss the dialog.
     */
    property alias negativeButton: negativeButton

    /*!
       \qmlproperty Button primaryButton

       The primary button, displayed as the rightmost button in the dialog buttons row. This is
       usually used to accept the dialog's action.
     */
    property alias positiveButton: positiveButton

    property string positiveButtonText: "Ok"
    property alias positiveButtonEnabled: positiveButton.enabled

    default property alias dialogContent: column.data

    signal accepted()
    signal rejected()

    anchors {
        bottom: parent.bottom
        horizontalCenter: parent.horizontalCenter
    }

    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Escape) {
            closeKeyPressed(event)
        }
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            closeKeyPressed(event)
        }
    }

    function closeKeyPressed(event) {
        if (dialog.showing) {
            if (dialog.dismissOnTap) {
                dialog.close()
            }
            event.accepted = true
        }
    }

    function show() {
        open()
    }

    View {
        id: dialogContainer

        anchors.fill: parent
        elevation: 5

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: false

            onClicked: {
                mouse.accepted = false
            }
        }

        View {
            id: headerView

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }

            backgroundColor: titleBarColor
            elevation: content.atYBeginning ? 0 : 1
            fullWidth: true
            height: Units.dp(56)

            IconButton {
                id: negativeButton

                anchors {
                    verticalCenter: titleLabel.verticalCenter
                    left: parent.left
                    leftMargin: Units.dp(16)
                }

                iconName: "navigation/close"
                color: Theme.lightDark(titleBarColor, Theme.light.iconColor,
                                       Theme.dark.iconColor)

                onClicked: {
                    close()
                    rejected();
                }
            }

            Label {
                id: titleLabel

                anchors {
                    left: parent.left
                    right: positiveButton.left
                    top: parent.top
                    leftMargin: Units.dp(72)
                    rightMargin: Units.dp(16)
                    topMargin: Units.dp(16)
                }

                wrapMode: Text.Wrap
                style: "title"
                visible: text != ""
                color: Theme.lightDark(titleBarColor, Theme.light.textColor,
                                       Theme.dark.textColor)
            }

            Button {
                id: positiveButton
                text: positiveButtonText

                anchors {
                    verticalCenter: titleLabel.verticalCenter
                    right: parent.right
                    rightMargin: Units.dp(16)
                }

                textColor: Theme.lightDark(titleBarColor, Theme.light.textColor,
                                           Theme.dark.textColor)

                onClicked: {
                    close()
                    accepted();
                }
            }
        }

        Flickable {
            id: content

            clip: true
            anchors {
                left: parent.left
                right: parent.right
                top: headerView.bottom
                bottom: parent.bottom
                bottomMargin: Units.dp(16)
            }
            interactive: contentHeight + Units.dp(8) > height
            bottomMargin: 0

            Column {
                id: column
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    margins: contentMargins
                }

                spacing: Units.dp(16)
            }
        }

        Scrollbar {
            flickableItem: content
        }
    }
}
