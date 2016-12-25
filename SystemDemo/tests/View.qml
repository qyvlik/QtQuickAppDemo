import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

Container {
    id: container
    property bool immersive: false
    property real systemBarheight: 20 * dp

    contentItem: Item {
        anchors.fill: parent
        clip: true
        GridView {
            interactive: false
            anchors.fill: parent
            anchors.margins: 8 * dp
            cellHeight: 84 * dp
            cellWidth: 84 * dp
            model: container.contentModel

            move: Transition {
                NumberAnimation { properties: "x,y"; duration: 1000 }
            }
            add: Transition {
                NumberAnimation { properties: "x,y"; duration: 400}
            }

            displaced: Transition {
                NumberAnimation { properties: "x,y"; duration: 400}
            }
        }

    }



}
