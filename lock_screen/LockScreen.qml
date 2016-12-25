import QtQuick 2.0

Item {

    Row {
        id: row
        height: 10
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle {
            color:"green"
            width: 10; height: 10
        }
        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 100 }
            NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 100 }
            NumberAnimation { property: "x"; duration: 100 }
        }
    }

    Component {
        id: com
        Rectangle {
            color:"green"
            width: 10; height: 10
        }
    }

    Grid {
        id: grid
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: parent.width
        height: parent.width / 3 * 4
        columns: 3
        Repeater {
            model: 12
            Rectangle {
                id: cell
                width: grid.width / 3
                height: grid.width / 3
                border.color: "black"

                Rectangle {
                    anchors.fill: parent
                    anchors.margins: parent.width * 0.1
                    color: "red"
                    Text {
                        anchors.centerIn: parent
                        text: cell.Positioner.index
                        font.family: "微软雅黑"
                        font.pixelSize: 20
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            com.createObject(row);
                            console.log(cell.Positioner.index);
                        }
                    }
                }
            }

        }
    }
}
