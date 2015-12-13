import QtQuick 2.0

Image {
    id: icon
    property real iconSize: 16
    width: iconSize
    height: iconSize
    sourceSize: Qt.size(iconSize, iconSize)
    signal clicked()
    MouseArea {
        anchors.fill: parent
        onClicked: icon.clicked()
    }

}
