import QtQuick 2.0

Component {
    Item {
        id: main
        width: grid.cellWidth;
        height: grid.cellHeight
        Image {
            id: item;
            parent: loc
            x: main.x + 5
            y: main.y + 5
            width: main.width - 10
            height: main.height - 10;
            fillMode: Image.PreserveAspectFit
            smooth: true
            source: icon
//            Rectangle {
//                anchors.fill: parent;
//                border.color: "#326487"; border.width: 6
//                color: "transparent"; radius: 5
//                visible: item.state != "active"
//            }
            Behavior on x { enabled: item.state != "active"
                NumberAnimation { duration: 400; easing.type: Easing.OutBack }
            }
            Behavior on y { enabled: item.state != "active";
                NumberAnimation { duration: 400; easing.type: Easing.OutBack }
            }
            SequentialAnimation on rotation {
                NumberAnimation { to:  2; duration: 60 }
                NumberAnimation { to: -2; duration: 120 }
                NumberAnimation { to:  0; duration: 60 }
                running: loc.currentId != -1 && item.state != "active"
                loops: Animation.Infinite;
                alwaysRunToEnd: true
            }
            states: State {
                name: "active"
                when: loc.currentId  == gridId
                PropertyChanges { target: item; x: loc.mouseX - width/2; y: loc.mouseY - height/2; scale: 0.5; z: 10 }
            }
            transitions: Transition { NumberAnimation { property: "scale"; duration: 200} }
        }
        Text {
            text: gridId
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("ddd");
            }
        }
    }
}
