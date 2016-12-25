import QtQuick 2.0
import QtQuick.Controls 2.0

Label {
    id: timeLabel
    property string format: "yyyy-MM-dd hh:mm:ss.zzz"
    property alias interval: timer.interval
    Timer {
        id: timer
        interval: 500
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered:{
            timeLabel.text = Qt.formatDateTime(new Date(), format);
        }
    }
}

