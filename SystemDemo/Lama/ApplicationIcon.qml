import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: icon
    width: 64 * dp
    height: 64 * dp

    color: "transparent"

    Tracker{}

    property var mouseArea
    property int gridId: -1
    property alias iconSource: iconImage.source
    property alias iconLabel: iconLabel.text
    property string applicationUrl
    signal clicked(string applicationUrl)

    Behavior on x {
        enabled: icon.state != "active"
        NumberAnimation {
            duration: 400
            easing.type: Easing.OutBack
        }
    }

    Behavior on y {
        enabled: icon.state != "active"
        NumberAnimation {
            duration: 400
            easing.type: Easing.OutBack
        }
    }

//    SequentialAnimation on rotation {
//        NumberAnimation { to:  2; duration: 60 }
//        NumberAnimation { to: -2; duration: 120 }
//        NumberAnimation { to:  0; duration: 60 }
//        running: (mouseArea !== undefined && mouseArea.currentId !== -1)&& icon.state !== "active"
//        loops: Animation.Infinite;
//        alwaysRunToEnd: true
//    }

    states: State {
        name: "active"
        when: mouseArea.currentId === gridId
        PropertyChanges {
            target: icon
            x: mouseArea.mouseX - width/2
            y: mouseArea.mouseY - height/2
            scale: 0.5
            z: 10
        }
    }

    transitions: Transition {
        NumberAnimation { property: "scale"; duration: 200}
    }

    Item {
        id: iconArea
        width: 48 * dp
        height: 48 * dp
        anchors.top: parent.top
        anchors.topMargin: 4 * dp
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true

        Image {
            id: iconImage
            anchors.fill: parent

            Rectangle {
                id: iconAreaMask
                anchors.fill: parent
                color: "black"
                opacity: inlineMouseArea.pressed ? 0.2 : 0
            }
        }

        MouseArea {
            id: inlineMouseArea
            anchors.fill: parent
            onClicked: icon.clicked(applicationUrl)
        }
    }

    Label {
        anchors.top: iconArea.bottom
        anchors.topMargin: 4 * dp
        id: iconLabel
        anchors.horizontalCenter: parent.horizontalCenter
    }


}
