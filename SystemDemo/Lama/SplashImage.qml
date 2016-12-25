import QtQuick 2.0

Item {
    id: splashImage

    property alias imageSource: image.source
    property alias image: image

    readonly property string showState: "SHOW"
    readonly property string hideState: "HIDE"

    function splash(time) {
        image.visible = true;
        time = time || 1000;
        ticker.interval = time;
        ticker.start();
    }

    Timer {
        id: ticker
        interval: 800
        repeat: false
        triggeredOnStart: false
        onTriggered: {
            image.visible = false;
        }

    }

    Image {
        id: image
        visible: false
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
        smooth: true
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignTop

        MouseArea {
            anchors.fill: parent
        }
    }

}
