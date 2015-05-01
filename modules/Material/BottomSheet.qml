import Material 0.1
import Material.ListItems 0.1
import QtQuick 2.0
import QtQuick.Layouts 1.1

PopupBase {
    id: bottomSheet

    property int margin: units.dp(16)
    property int maxHeight: parent.height * 0.6
    default property alias contentView: sheetContent.data

    overlayLayer: "dialogOverlayLayer"
    overlayColor: Qt.rgba(0, 0, 0, 0.3)
    height: maxHeight
    width: parent.width

    anchors {
        verticalCenter: parent.verticalCenter
        verticalCenterOffset: getOffset()
        Behavior on verticalCenterOffset {
            NumberAnimation {
                duration: 200
                easing {
                     type: Easing.OutCubic
                }
            }
        }
    }

    View {
        id:containerView
        anchors {
            fill:parent
        }
        elevation: 2
        backgroundColor: "#fff"

        Item {
            id:sheetContent
            anchors {
                leftMargin: margin
                rightMargin: margin
                topMargin: units.dp(8)
                bottomMargin: units.dp(8)
                fill: parent
            }
        }
    }

    function getOffset(){
        var x = (parent.height / 2) + (height / 2)
        if(showing){
            x -= height
        }
        return x
    }
}
