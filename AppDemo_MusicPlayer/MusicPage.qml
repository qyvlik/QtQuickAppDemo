import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtMultimedia 5.5
import "./Component"

Rectangle {
    id: root
    width: 360
    height: 640
    color: "transparent"
    clip: true

    property alias musicSource: playBar.musicSource
    property url musicImage

    function goto_hide_state() {
        rowLayout_1.state = "hide";
        singer_image.state = "hide";
        singer_name.state = "hide";
        rowLayout_2.state = "hide";
        playBar.state = "hide";
    }

    function goto_show_state() {
        rowLayout_1.state = "show";
        singer_image.state = "show";
        singer_name.state = "show";
        rowLayout_2.state = "show";
        playBar.state = "show";
    }


    ColumnLayout {
        id: mainLayout
        anchors.fill: parent

        spacing: 32

        Item {
            Layout.fillWidth: true
            height: root.height * 0.1
        }

        RowLayout {
            id: rowLayout_1
            Layout.fillWidth: true

            state: "show"
            states: [
                State { name: "show" },
                State {
                    name: "hide"
                    PropertyChanges {
                        target: rowLayout_1_1; scale: 0.1; opacity: 0.2
                    }
                    PropertyChanges {
                        target: rowLayout_1_2; scale: 0.1; opacity: 0.2
                    }
                }
            ]

            transitions: [
//                Transition {
//                    from: "show";  to: "hide"
//                    NumberAnimation {
//                        easing.type: Easing.OutCubic;
//                        properties: "scale,opacity"; duration: 1000 }
//                },
                Transition {
//                    from: "hide"; to: "show"
                    NumberAnimation {
                        easing.type: Easing.OutCubic;
                        properties: "scale,opacity"; duration: 1000 }
                }
            ]

            Icon {
                id: rowLayout_1_1
                iconSize: 16
                Layout.alignment: Qt.AlignLeft
                Layout.leftMargin: 32
                source: "./images/heart_72px_1137876_easyicon.net.png"
            }

            Item { Layout.fillWidth: true }

            Icon {
                id: rowLayout_1_2
                iconSize: 16
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: 32
                source: "./images/plus_72px_1137939_easyicon.net.png"
            }
        } // rowLayout_1

        CircularImage {
            id: singer_image
            imageSource: musicImage
            Layout.alignment: Qt.AlignCenter

            state: "show"
            states: [
                State { name: "show" },
                State {
                    name: "hide"
                    PropertyChanges { target: singer_image; x: root.width; opacity: 0.2 }
                }
            ]

            transitions: [
//                Transition {
//                    from: "show";  to: "hide"
//                    NumberAnimation {
//                        easing.type: Easing.OutCubic;
//                        properties: "x,opacity"; duration: 1000 }
//                },
                Transition {
//                    from: "hide";  to: "show"
                    NumberAnimation {
                        easing.type: Easing.OutCubic;
                        properties: "x,opacity"; duration: 1000 }
                }
            ]

            onRotationChanged: singer_image.requestPaint();

            NumberAnimation on rotation {
                id: singer_image_rotaion_animation
                duration: 3600
                from: 360
                to: 0
                loops: Animation.Infinite
                running: false
            }
        }

        Item {
            id: singer_name
            width: singer_name_label.contentWidth
            height: singer_name_label.contentHeight
            Layout.alignment: Qt.AlignCenter
            state: "show"
            states: [
                State { name: "show" },
                State {
                    name: "hide"
                    PropertyChanges {  target: singer_name;  x: root.width }
                }
            ]

            transitions: [
//                Transition {
//                    from: "show";  to: "hide"
//                    NumberAnimation {
//                        easing.type: Easing.OutCubic;
//                        properties: "x"; duration: 1000 }
//                },
                Transition {
//                    from: "hide";  to: "show"
                    NumberAnimation {
                        easing.type: Easing.OutCubic;
                        properties: "x"; duration: 1000 }
                }
            ]

            SampleLabel {
                id: singer_name_label
                color: "white"
                text: playBar.metaData.title || ""
                anchors.centerIn: parent
            }
        }



        RowLayout {
            id: rowLayout_2
            Layout.fillWidth: true
            height: 64
            spacing: 0
            clip: true

            state: "show"
            states: [
                State { name: "show" },
                State {
                    name: "hide"
                    PropertyChanges {
                        target: rowLayout_2_1
                        x: root.width
                        //y: rowLayout_2_1.height
                        // scale: 0.2

                    }
                    PropertyChanges {
                        target: rowLayout_2_2
                        x: root.width
                        //y: rowLayout_2_2.height
                        // scale: 0.2

                    }
                    PropertyChanges {
                        target: rowLayout_2_3
                        x: root.width
                        //y: rowLayout_2_3.height
                        // scale: 0.2

                    }
                }
            ]

            transitions: [
//                Transition {
//                    from: "show";  to: "hide"
//                    NumberAnimation {
//                        easing.type: Easing.OutCubic
//                        properties: "x,y,scale"; duration: 1300
//                    }
//                },
                Transition {
//                    from: "hide";  to: "show"
                    NumberAnimation {
                        easing.type: Easing.OutCubic
                        properties: "x,y,scale"; duration: 1300
                    }
                }
            ]

            Rectangle {
                id: rowLayout_2_1
                Layout.fillWidth: true
                height: rowLayout_2.height
                color: "#6628ccfd"
                clip: true
                SampleLabel {
                    font.pointSize: 10
                    color: "white"
                    text: "author\n" +
                          (playBar.metaData.author || "")
                }
            }
            Rectangle {
                id: rowLayout_2_2
                Layout.fillWidth: true
                height: rowLayout_2.height
                color: "#6628ccfd"
                clip: true
                SampleLabel {
                    font.pointSize: 10
                    color: "white"
                    text: "subTitle\n" +
                          (playBar.metaData.subTitle || "")
                }
            }
            Rectangle {
                id: rowLayout_2_3
                Layout.fillWidth: true
                height: rowLayout_2.height
                color: "#6628ccfd"
                clip: true
                SampleLabel {
                    font.pointSize: 10
                    color: "white"
                    text: "comment\n"
                          +(playBar.metaData.comment || "")
                }
            }
        } // rowLayout_2

        SamplePlayerBar {
            id: playBar
            musicImage: root.musicImage
            onPlaybackStateChanged: {
                if(singer_image_rotaion_animation.running) {
                    singer_image_rotaion_animation.paused =
                            !singer_image_rotaion_animation.paused;
                } else {
                    singer_image_rotaion_animation.running =
                            !singer_image_rotaion_animation.running
                }
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

    } // mainLayout
}

