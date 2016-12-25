import QtQuick 2.0

Rectangle {
    width: 640; height: 480
    color: "#222222"
    GridView {
        id: grid
        interactive: false
        anchors {
            topMargin: 60; bottomMargin: 60
            leftMargin: 140; rightMargin: 140
            fill: parent
        }
        cellWidth: 120
        cellHeight: 120

        model: WidgetModel { id: icons }

        delegate: IconItem { }

        MouseArea {
            id: loc
            property int currentId: -1 // Original position in model
            property int newIndex // Current Position in model
            property int index: grid.indexAt(mouseX, mouseY) // Item underneath cursor
            anchors.fill: parent
            preventStealing: false
            propagateComposedEvents: true
            onPressAndHold: currentId = icons.get(newIndex = index).gridId
            onReleased: {
                currentId = -1;
            }
            onPositionChanged: {
                if(loc.currentId != -1 && index!= -1 && index != newIndex) {
                    icons.move(newIndex, newIndex = index, 1)
                }
            }
            onClicked: {
                // console.log(grid.indexAt(mouseX, mouseY));
                mouse.accepted = false
            }
        }
    }
}
