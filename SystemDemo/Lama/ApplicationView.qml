import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.0

Item {
    id: root
    property bool immersive: false
    property real systemBarheight
    property alias overlay: overlayItem
    property alias splashImage: splashImage
    default property alias data: content.data
    signal splash()

    width: ApplicationWindow.window ? ApplicationWindow.window.width : 360
    height: ApplicationWindow.window ? ApplicationWindow.window.height : 640

    function exitApplication() {
        stackView.pop().destroy(stackView.animationTime);
    }

    Component.onCompleted: {
        root.splash.connect(content.splash);
        splashImage.splash();
    }


    Item {
        id: content
        anchors.fill: parent
        property alias overlay: overlayItem
        property alias immersive: root.immersive
        property alias systemBarheight: root.systemBarheight
        property alias splashImage: root.splashImage
        signal splash()
    }

    Item {
        id: overlayItem
        anchors.fill: parent

        SplashImage {
            id: splashImage
            anchors.fill: parent
            imageSource: "../images/background/07.JPG"
        }

    }
}
