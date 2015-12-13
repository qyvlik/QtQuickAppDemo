import QtQuick 2.5
import QtQuick.Window 2.2
import QtQml.Models 2.2
import "./Component"

Rectangle {

    width: 700
    height: 700
    color: "gray"

    Rectangle {
        id: root
        width: 360
        height: 640
        anchors.centerIn: parent
        color: "transparent"
        clip: true

        MainView {
            id: view
            anchors.fill: parent

            backgroundSource : "./images/background.jpg"

            model: ObjectModel {
                id: itemsModel
                HomePage {

                }
                MusicPage {
                    id: musicPage
                    musicSource: "./music/日笠阳子 - 苍空のモノローグ.mp3"
                    musicImage: "./music/日笠阳子 - 苍空のモノローグ.jpg"
                }
            }
            onCurrentIndexChanged: {
                if(currentIndex == 0) {
                    musicText.anchors.leftMargin
                            = musicText.contentWidth*0.3;
                    musicPage.goto_hide_state();
                } else if(currentIndex == 1) {
                    musicText.anchors.leftMargin
                            = root.width / 2 - musicText.contentWidth * 0.5;
                    musicPage.goto_show_state();
                }
            }
        }

        Item {
            id: bottomBar
            width: parent.width
            height: 40
            anchors.bottom: parent.bottom

            SampleLabel{
                id: musicText

                anchors.left: parent.left
                anchors.leftMargin: contentWidth * 0.3
                font.pointSize: 12

                text: "@Music"
                color: "white"

                Behavior on anchors.leftMargin {  NumberAnimation { duration: 500 } }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(musicText.anchors.leftMargin == musicText.contentWidth*0.3) {
                            musicText.anchors.leftMargin
                                    = root.width / 2 - musicText.contentWidth * 0.5;
                            view.currentIndex = 1;

                        } else {
                            musicText.anchors.leftMargin
                                    = musicText.contentWidth*0.3;
                            view.currentIndex = 0;
                        }
                    }
                }
            }
        }
    }
}

