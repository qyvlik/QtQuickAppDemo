import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

import Lama 1.0

ApplicationWindow {
    width: 360
    height: 640

    property real dpScale:  1.5
    readonly property real dp: Math.max(Screen.pixelDensity * 25.4 / 160 * dpScale, 1)

    property bool immersive: false

    function randomColor(opacity) {
        opacity = opacity || 1;
        return Qt.rgba(Math.random(),Math.random(),Math.random(), opacity)
    }

    Item {
        id: over
        width: parent.width
        height: parent.width
        anchors.centerIn: parent
        Grid {
            id: grid
            anchors.fill: parent
            anchors.margins: 10
            anchors.centerIn: parent
            rows: 4
            columns: 4
            spacing: 10
            Repeater {
                model: 16
                Rectangle {
                    id: iconParent
                    width: grid.width / 4 - 10
                    height: grid.height / 4- 10
                    // color: randomColor()
                    color: "red"
                    opacity: 0.5
                    Rectangle {
                        id: iconItem
                        width: iconParent.width
                        height: iconParent.height
                        color: randomColor(0.5)
                        MouseArea {
                            anchors.fill: parent
                            drag.target: iconItem
                            onPressed: {
                                iconItem.parent = over;
                            }
                            onReleased: {
                                iconItem.parent = iconParent;
                            }
                        }
                    }
                }
            }
        }
    }



    //    View {
    //        id: view
    //        anchors.fill: parent
    //        Repeater {
    //         model: 10
    //         Item {
    //             width: 84 * dp
    //             height: 84 * dp

    //             // clip: true

    //             Item {
    //                 id: item
    //                 width: parent.width
    //                 height: parent.height

    //                 Rectangle {
    //                     width: 64 * dp
    //                     height: 64 * dp
    //                     anchors.centerIn: parent
    //                     color: randomColor()

    //                     Label {
    //                         font.pointSize: 20 * dp
    //                         anchors.centerIn: parent
    //                         color: "black"
    //                         text: index
    //                     }
    //                 }

    //                 MouseArea {
    //                     id: mouseArea
    //                     anchors.fill: parent
    //                     // drag.target: item
    //                     onClicked: {
    //                         view.moveItem(index, index+1)
    //                     }
    //                 }
    //             }
    //         }
    //     }
    //    }

}
