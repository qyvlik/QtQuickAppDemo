import QtQuick 2.5
import QtQuick.Controls 1.3
import QtGraphicalEffects 1.0

Item {
    width: 700
    height: 680

    Rectangle {
        id: root
        width: 360
        height: 640
        anchors.centerIn: parent

        layer.enabled: true
        layer.effect: DropShadow {
            id: dropShadow
            anchors.fill: root
            source: root
            horizontalOffset: 10
            verticalOffset: 10
            radius: 8.0
            samples: 16
            color: "#000000"
            smooth: true
            transparentBorder: true
            spread: 0
        }

        MainView {
            id: maniView
            anchors.fill: parent
            smooth: true
        }

        Component.onCompleted:  maniView.state = "B";
    }

    Item {
        anchors.left: root.right
        width: 60
        height: root.height

        Button {
            text: "show"
            onClicked: {
                if(maniView.state == "A") {
                    maniView.state = "B";
                } else {
                    maniView.state = "A";
                }
            }
        }
    }
}

