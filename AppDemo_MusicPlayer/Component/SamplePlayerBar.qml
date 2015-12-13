import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtMultimedia 5.5

RowLayout {
    // play bar
    id: root
    Layout.fillWidth: true
    height: 64

    property alias musicSource: playMusic.source
    property url musicImage
    property alias metaData: playMusic.metaData
    property alias playbackState: playMusic.playbackState

    signal playButtonClicked()

    state: "show"

    states : [
        State {
            name: "show"
        },
        State {
            name: "hide"
            PropertyChanges {
                target: circularProgress
                progress: 0
            }
        }
    ]

    transitions: [
//        Transition {
//            from: "show"
//            to: "hide"

//            NumberAnimation {
//                target: circularProgress
//                property: "progress"
//                duration: 1000
//                easing.type: Easing.InOutQuad
//            }

//        },
        Transition {
//            from: "hide"
//            to: "show"
            NumberAnimation {
                target: circularProgress
                property: "progress"
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }
    ]


    Audio {
        id: playMusic
        readonly property int durationMinutes: Math.floor(playMusic.duration / 60000)

        readonly property int durationSeconds: Math.round((playMusic.duration % 60000) / 1000)

        readonly property int durationHours : (playMusic.duration / 3600000 > 1)
                                              ?Math.floor(playMusic.duration / 3600000)
                                              :0

        readonly property int positionSeconds: Math.round((playMusic.position % 60000) / 1000)

        readonly property int positionMinutes: Math.floor(playMusic.position / 60000)

        readonly property int positionHours : (playMusic.position / 3600000 > 1)
                                              ?Math.floor(playMusic.position / 3600000)
                                              :0
    }

    Item {
        id: playButton

        width:  root.height * 0.9
        height: root.height * 0.9

        property bool play: false

        Layout.leftMargin: 20

        Connections {
            target: playButton
            onPlayChanged: {
                playButtonImage.visible = !playButtonImage.visible;
                pauseButtonImage.visible = !pauseButtonImage.visible;
            }
        }

        CircularProgress {
            id: circularProgress
            anchors.fill: parent
            arcBackgroundColor: "transparent"
            arcColor: "white"
            arcWidth: 3
            radius: root.height / 2 - 5
            progress: 360
            Behavior on progress {
                NumberAnimation {
                    easing.type: Easing.InCubic
                    duration: 450
                }
            }
        }

        Image {
            id: playButtonImage
            anchors.centerIn: parent
            source: "./images/media_play_72px_24382_easyicon.net.png"
            sourceSize: Qt.size( root.height-10, root.height-10)
            visible: false
        }

        Image {
            id: pauseButtonImage
            anchors.centerIn: parent
            source: "./images/pause_72px_1169497_easyicon.net.png"
            sourceSize: Qt.size( root.height-10, root.height-10)
            visible: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                playButton.play = !playButton.play;
                playOrPause()
                playButtonClicked()
            }
        }
    }

    ColumnLayout {
        height: root.height
        Layout.fillWidth: true
        Layout.rightMargin: 20

        ProgressBar {
            value: playMusic.position / playMusic.duration
            Layout.fillWidth: true
            style: ProgressBarStyle {
                background: Rectangle {
                    color: "gray"
                    implicitHeight: 5
                }
                progress: Rectangle {
                    color: "white"
                    implicitHeight: 5
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            SampleLabel {
                Layout.alignment: Qt.AlignLeft
                color: "white"
                text: playMusic.durationHours + ":" +
                      playMusic.durationMinutes + ":" + playMusic.durationSeconds
            }

            Item { Layout.fillWidth: true }

            SampleLabel {
                // show duration
                Layout.alignment: Qt.AlignRight
                color: "white"
                text: playMusic.positionHours + ":" +
                      playMusic.positionMinutes + ":" + playMusic.positionSeconds
            }
        }


    }

    function playOrPause() {
        var nil = playMusic.playbackState == MediaPlayer.PlayingState
                ? playMusic.pause()
                : playMusic.play();
    }
}

