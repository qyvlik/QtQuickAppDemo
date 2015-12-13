import QtQuick 2.0

ListView {
    id: view

    property alias backgroundSource: backgroundImage.source

    preferredHighlightBegin: 0
    preferredHighlightEnd: 0
    highlightMoveDuration: 800
    highlightRangeMode: ListView.StrictlyEnforceRange
    snapMode: ListView.SnapOneItem
    boundsBehavior: ListView.StopAtBounds
    orientation: ListView.Horizontal

    clip: true

    Image {
        id: backgroundImage
        fillMode: Image.PreserveAspectCrop
        z: parent.z -1
        Behavior on x {
            NumberAnimation{
                duration: 550
            }
        }
    }

    onCurrentIndexChanged: {
        backgroundImage.x =
                - backgroundImage.width * (currentIndex / view.count);
    }
}


