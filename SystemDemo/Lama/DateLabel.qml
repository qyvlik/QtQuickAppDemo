import QtQuick 2.0
import QtQuick.Controls 2.0

Label {
    id: timeLabel
    property alias interval: timer.interval
    Timer {
        id: timer
        interval: 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered:{
            timeLabel.text = Qt.locale().dateFormat(Locale.ShortFormat);
        }
    }
}

