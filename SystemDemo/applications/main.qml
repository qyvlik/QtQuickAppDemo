import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

import Lama 1.0

ApplicationView {
    splashImage.imageSource: "../images/background/05.JPG"
    Button {
        text: "exit"
        anchors.centerIn: parent
        onClicked: {
            exitApplication();
        }
    }
}
