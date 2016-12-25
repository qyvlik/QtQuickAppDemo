import QtQuick 2.0
import QtQuick.Controls 2.0

// @disable-check M300
Container {
    id: container
    property bool immersive: false
    property real systemBarheight: 20 * dp
    property real cell: 84 * dp

    property alias gridView: grid
    property alias delegate: grid.delegate

    property ListModel gridModel: ListModel {
        id: gridModel
    }


    contentItem: Item {
        anchors.fill: parent
        anchors.topMargin: immersive ? 0 : systemBarheight
        clip: true
        GridView {
            id: grid
            interactive: false
            anchors.fill: parent
            anchors.margins: 8 * dp
            cellHeight: cell
            cellWidth: cell
            //             model: container.contentModel
            model: gridModel
        }
    }
}
