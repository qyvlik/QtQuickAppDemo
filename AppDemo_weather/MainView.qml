import QtQuick 2.5
import QtQuick.Layouts 1.1

import "./Component"

Image {
    id: root
    width: 360
    height: 640
    source: "./images/background.jpg"

    Item {
        id: statesBar
        width: parent.width
        height: sampleLabel.contentHeight

        RowLayout {
            anchors.fill: parent
            SampleLabel {
                id: sampleLabel
                text: "中国移动"
                color: "white"
            }

            SampleLabel {
                Layout.alignment: Qt.AlignRight
                text: (new Date).toLocaleString()
                color: "white"
                Timer {
                    interval: 1000
                    repeat: true
                    running: true
                    onTriggered: {
                        parent.text = (new Date).toLocaleString();
                    }
                }
            }
        }
    }

    state: "A"
    clip: true

    states: [
        State {
            name: "A"
        },
        State {
            name: "B"

            PropertyChanges {
                target: move_item_1
                y: move_item_1.height * 2
            }

            PropertyChanges {
                target: move_item_1_1
                opacity: 0.2
            }

            PropertyChanges {
                target: move_item_2
                y: -root.height+move_item_2.height+statesBar.height + 60
                height: 100
            }

            PropertyChanges {
                target: move_item_2_1
                scale: 0.5
                opacity: 0
            }

            PropertyChanges {
                target: move_item_4_1
                scale: 0.5
                opacity: 0
            }

            PropertyChanges {
                target: move_item_3
                y: -root.height+move_item_3.height+statesBar.height
            }

            PropertyChanges {
                target:　move_item_3_1
                scale: 0.5
                opacity: 0
            }

            PropertyChanges {
                target: move_item_4
                y: -root.height+move_item_4.height+statesBar.height + 60
                height: 100
            }
        }
    ]

    transitions: [
        Transition {
            from: "A"
            to: "B"
            NumberAnimation {
                targets: [
                    move_item_1,
                    move_item_2,
                    move_item_4
                ]
                properties: "y,height"
                duration: 1500
            }

            NumberAnimation {
                target: move_item_3
                properties: "y,height"
                duration: 1300
                easing.type: Easing.InBack
            }

            NumberAnimation {
                target: move_item_1_1
                properties: "scale,opacity"
                duration: 1300
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                targets: [move_item_2_1,move_item_3_1,move_item_4_1]
                properties: "scale,opacity"
                duration: 1300
                easing.type: Easing.InOutQuad
            }

            onRunningChanged: {
                // stop
                if(!running) {
                    move_item_5.state = "B"
                }
            }

        },
        Transition {
            from: "B"
            to: "A"
            NumberAnimation {
                targets: [
                    move_item_1,
                    move_item_2,
                    move_item_4
                ]
                properties: "y,height"
                duration: 1500
            }

            NumberAnimation {
                target: move_item_3
                properties: "y,height"
                duration: 1300
                easing.type: Easing.InBack
            }

            NumberAnimation {
                target: move_item_1_1
                properties: "scale,opacity"
                duration: 1300
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                targets: [move_item_2_1,move_item_3_1,move_item_4_1]
                properties: "scale,opacity"
                duration: 1300
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                targets: [move_item_5_1, move_item_5_2]
                properties: "scale,opacity"
                duration: 1300
                easing.type: Easing.InOutQuad
            }

            onRunningChanged: {
                // stop
                if(!running) {
                    move_item_5.state = "A"
                }
            }
        }
    ]


    Item {
        id: move_item_5
        width: parent.width
        anchors.top: statesBar.bottom
        anchors.bottom: columnLayout.top

        state: "A"

        states : [
            State {
                name:"A"
            },
            State {
                name: "B"
                PropertyChanges {
                    target: move_item_5_1
                    opacity: 0
                    scale: 0.3
                }
                PropertyChanges {
                    target: move_item_5_2
                    opacity: 0
                    scale: 0.3
                }
            }
        ]

        transitions: [
            Transition {
                from: "B"
                to: "A"
                NumberAnimation {
                    targets: [move_item_5_1, move_item_5_2]
                    properties: "scale,opacity"
                    duration: 1300
                    easing.type: Easing.InOutQuad
                }
            },
            Transition {
                from: "A"
                to: "B"
                NumberAnimation {
                    targets: [move_item_5_1, move_item_5_2]
                    properties: "scale,opacity"
                    duration: 1300
                    easing.type: Easing.InOutQuad
                }
            }
        ]

        ColumnLayout {
            anchors.fill: parent
            SampleLabel {
                id: move_item_5_2
                Layout.alignment: Qt.AlignHCenter
                font.pointSize: 28
                color: "white"
                text: "Cloudy"
            }

            Image {
                // 云朵
                id: move_item_5_1
                Layout.alignment: Qt.AlignHCenter
                source: "./images/cloud_197.09665653495px_1193803_easyicon.net.png"
                sourceSize: Qt.size(64, 64)
            }



            Item { Layout.fillHeight: true }
        }

    }

    ColumnLayout {
        id: columnLayout
        width: parent.width
        height: parent.height * 0.5
        anchors.bottom: parent.bottom

        clip: false
        spacing: 0

        Rectangle {

            id: move_item_1

            Layout.fillWidth: true
            height: columnLayout.height * 0.5
            color: "#000000"
            opacity: 0.5
            z: 1

            RowLayout {
                anchors.fill: parent

                SampleLabel {
                    id: move_item_1_1
                    font.pointSize: 20
                    text: "London UK\nMonday 20°\nMax 2°Min -6°"
                    color: "white"
                }

                Item {
                    Layout.fillWidth: true
                }

                SampleLabel {
                    font.pointSize: 28
                    text: "-4°"
                    color: "white"
                }

            }

        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            Rectangle {
                id: move_item_2
                color: Qt.rgba(1/255, 55/255, 91/255)
                Layout.fillWidth: true
                Layout.fillHeight: true

                SampleLabel {
                    id: move_item_2_1
                    anchors.centerIn: parent
                    font.pointSize: 28
                    text: "Tue\n1°"
                    color: "white"
                }
            }
            Rectangle {
                id: move_item_3
                color: Qt.rgba(15/255, 79/255, 114/255)
                Layout.fillWidth: true
                Layout.fillHeight: true
                SampleLabel {
                    id: move_item_3_1
                    anchors.centerIn: parent
                    font.pointSize: 28
                    text: "Wed\n4°"
                    color: "white"
                }
            }
            Rectangle {
                id: move_item_4
                color: Qt.rgba(63/255, 107/255, 141/255)
                Layout.fillWidth: true
                Layout.fillHeight: true
                SampleLabel {
                    id: move_item_4_1
                    anchors.centerIn: parent
                    font.pointSize: 28
                    text: "Thu\n5°"
                    color: "white"
                }
            }
        }
    }
}
