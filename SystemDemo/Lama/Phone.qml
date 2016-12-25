import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.0

ApplicationWindow {
    id: phone
    visible: true
    width: 360 * dp
    height: 640 * dp
    property real dpScale:  1.5
    readonly property real dp: Math.max(Screen.pixelDensity * 25.4 / 160 * dpScale, 1)

    property bool traceItem: false
    property alias notificationList: drawer
    property alias stackView: stackView
    signal backKeyPressed()
    signal backKeyReleased()

    Drawer {
        id: drawer
        edge: Qt.TopEdge
        width: phone.width
        height: phone.height - 40* dp

        background: Item { }

        Item {
            anchors.fill: parent

            Item {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.topMargin: 20 * dp
                anchors.rightMargin: 20 * dp
                anchors.leftMargin: 20 * dp
                height: 40 * dp
                Row {
                    TimeLabel {
                        color: "white"
                        format: "hh:mm"
                        font.pixelSize: 32 * dp
                    }
                }

            }
        }

//        ListView {
//            anchors.fill: parent
//            anchors.margins: 40 * dp
//            clip: true
//            model: 10
//            delegate: Rectangle {
//                width: parent.width
//                height: 40 * dp
//                color: randomColor()
//                Label {
//                    text: "Content"
//                    anchors.centerIn: parent
//                }
//            }
//        }
    }

    function randomColor(opacity) {
        opacity = opacity || 1;
        return Qt.rgba(Math.random(),Math.random(),Math.random(), opacity)
    }


    StackView {
        id: stackView
        property int animationTime: 300
        anchors.fill: parent

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: stackView.animationTime
            }
            PropertyAnimation {
                property: "scale"
                from: 0
                to: 1
                duration: stackView.animationTime
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: stackView.animationTime
            }
            PropertyAnimation {
                property: "scale"
                from: 1
                to: 1.5
                duration: stackView.animationTime
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: stackView.animationTime
            }
            PropertyAnimation {
                property: "scale"
                from: 1.5
                to: 1
                duration: stackView.animationTime
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: stackView.animationTime
            }
            PropertyAnimation {
                property: "scale"
                from: 1
                to: 0
                duration: stackView.animationTime
            }
        }
    }

    footer: Item {
        width: parent.width
        height: 40 * dp
        Rectangle {
            anchors.fill: parent
            color: "black"
        }
        Rectangle {
            height: parent.height * 0.8
            width: parent.height * 1.6
            radius: parent.height * 0.4
            anchors.centerIn: parent
            MouseArea {
                anchors.fill: parent
                onPressed: backKeyPressed()
                onReleased: backKeyReleased()
            }
        }
    }
}
