import QtQuick 2.0
import "./Component"

Rectangle {
    width: 360
    height: 640
    color: "transparent"

    SampleLabel {
        id: showTime
        anchors.centerIn: parent
        text: "Home Page"
        font.family: "Verdana"
        color: "white"
        font.pointSize: 32

        Timer {
            triggeredOnStart: true
            running: true
            interval: 1000
            repeat: true
            onTriggered: {
                var hour = (new Date).getHours();
                var min = (new Date).getMinutes();
                showTime.text = hour + ":" + min
            }
        }
    }

}

