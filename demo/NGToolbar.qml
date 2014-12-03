import QtQuick 2.0
import QtQuick.Controls 1.3 as Controls
import QtQuick.Layouts 1.1
import Material 0.1

View
{
    id: toolbar
    implicitHeight: Device.formFactor == "mobile" ? units.dp(48)
                                                       : Device.formFactor == "tablet" ? units.dp(56)
                                                                                         : units.dp(64)
    height: targetHeight

    property int targetHeight: implicitHeight + (tabs.length > 0 ? tabbar.height : 0)
                                              + (expanded ? implicitHeight : 0)

    property bool expanded: false

    Behavior on height {
        NumberAnimation { duration: MaterialAnimation.pageTransitionDuration }
    }

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    elevation: 2
    fullWidth: true
    clipContent: true

    property string color: "white"

    property alias tabs: tabbar.tabs
    property alias selectedTab: tabbar.selectedIndex

    property bool showBackButton

    property NavigationDrawer drawer

    property int maxActionCount: (Device.formFactor == "desktop"
                                  ? 5 : Device.formFactor == "tablet" ? 4 : 3) - (drawer ? 1 : 0)

    Controls.StackView {
        id: stack
        width: parent.width
        height: toolbar.implicitHeight

        delegate: Controls.StackViewDelegate {
            popTransition: Controls.StackViewTransition {
                SequentialAnimation {
                    id: previousShowAnimation

                    ParallelAnimation {

                        NumberAnimation {
                            duration: MaterialAnimation.pageTransitionDuration
                            target: enterItem
                            property: "opacity"
                            from: 0
                            to: 1
                        }

                        NumberAnimation {
                            duration: MaterialAnimation.pageTransitionDuration
                            target: enterItem
                            property: "y"
                            from: enterItem ? -enterItem.height : 0
                            to: 0
                        }
                    }
                }
                SequentialAnimation {
                    id: actionBarHideAnimation

                    ParallelAnimation {
                        NumberAnimation {
                            duration: MaterialAnimation.pageTransitionDuration
                            target: exitItem
                            property: "opacity"
                            from: 1
                            to: 0
                        }

                        NumberAnimation {
                            duration: MaterialAnimation.pageTransitionDuration
                            target: exitItem
                            property: "y"
                            to: exitItem.height
                            from: 0
                        }
                    }
                }

            }

            pushTransition: Controls.StackViewTransition {
                SequentialAnimation {
                    id: actionBarShowAnimation

                    ParallelAnimation {
                        NumberAnimation {
                            duration: MaterialAnimation.pageTransitionDuration
                            target: enterItem
                            property: "opacity"
                            from: 0
                            to: 1
                        }

                        NumberAnimation {
                            duration: MaterialAnimation.pageTransitionDuration
                            target: enterItem
                            property: "y"
                            from: enterItem.height
                            to: 0
                        }
                    }
                }
                SequentialAnimation {
                    id: previousHideAnimation

                    ParallelAnimation {

                        NumberAnimation {
                            duration: MaterialAnimation.pageTransitionDuration
                            target: exitItem
                            property: "opacity"
                            to: 0
                        }

                        NumberAnimation {
                            duration: MaterialAnimation.pageTransitionDuration
                            target: exitItem
                            property: "y"
                            to: exitItem ? -exitItem.height : 0
                        }
                    }
                }
            }

        }
    }

    function pop()
    {
        stack.pop()
    }

    function push( page )
    {
        stack.push(page.actionBar);
    }

    Tabs {
        id: tabbar
        height: parent.height / 2
        color: toolbar.backgroundColor
        highlight: Theme.accentColor
        visible: tabs.length > 0
    }

}

