import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

import Lama 1.0

Phone {
    id: phoneScreen
    // traceItem :true
    font.family: "微软雅黑"

    Window {
        id: debugWindow
        // visible: true
        x: 0
        y: 0
        Label {
            text: "notificationList.position: " + notificationList.position
        }
    }

    Rectangle {
        id: phoneScreenBar
        width: parent.width
        height: 20 * dp
        color: "transparent"
        visible: notificationList.position === 0

        Item {
            anchors.fill: parent
            anchors.rightMargin: 8 * dp
            anchors.leftMargin: 8 * dp

            TimeLabel {
                // color: "white"
                format: "hh:mm:ss"
                font.pixelSize: 12 * dp
            }
        }
    }


    Component {
        id: applicationView
        //        url: "./applications/main.qml"
        ApplicationView {
            splashImage.imageSource: "./images/background/05.JPG"
            Button {
                text: "exit"
                anchors.centerIn: parent
                onClicked: {
                    exitApplication();
                }
            }
        }
    }

    stackView.initialItem: Item {

        id: systemHomeScreen

        width: parent.width
        height: parent.height

        FastBlur {
            anchors.fill: wapper
            source: wapper
            radius: notificationList.position > 0.1 ? 32 : 1
            Behavior on radius {
                NumberAnimation { duration: 500 }
            }
        }

        Item {
            id: wapper
            anchors.fill: parent
            visible: notificationList.position == 0
            clip: true
            SwipeView {
                id: view
                anchors.fill: parent

                background: Item {

                    Image {
                        id: backgroundImage
                        fillMode: Image.PreserveAspectCrop
                        source: "./images/background/08.JPG"
                        anchors.fill: parent
                        smooth: true
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignTop
                    }
                }

                PhoneScreenPage {
                    id: firstPage

                    delegate: Item {
                        id: main
                        width: firstPage.cell
                        height: firstPage.cell
                        ApplicationIcon {
                            x: main.x
                            y: main.y
                            mouseArea: firstPage.mouseArea
                            anchors.centerIn: parent
                            iconSource: firstPage.gridModel.get(index).iconSource
                            iconLabel: firstPage.gridModel.get(index).iconLabel
                            applicationUrl: firstPage.gridModel.get(index).applicationUrl
                            gridId: firstPage.gridModel.get(index).gridId
                            onClicked: {
                                var component = Qt.createComponent(applicationUrl)
                                if(component.status === Component.Ready) {
                                    var item = stackView.push(component.createObject(stackView));
                                }
                            }
                        }
                    }

                    Component.onCompleted: {
                        var step = 10;
                        // 加载应用
                        while(step--) {
                            var obj = {
                                iconSource: Qt.resolvedUrl("./images/icons/01.png"),
                                applicationUrl:Qt.resolvedUrl("./applications/main.qml"),
                                gridId: step,
                                iconLabel: "应用"
                            };
                            firstPage.gridModel.append(obj);
                        }
                    }
                }

                PhoneScreenPage {
                    id: secondPage
                }
            }

            PageIndicator {
                id: indicator
                count: view.count
                currentIndex: view.currentIndex
                anchors.bottom: shortCutBar.top
                anchors.bottomMargin: 8 * dp
                anchors.horizontalCenter: parent.horizontalCenter
                delegate: Item {
                    width: 16 * dp
                    height: 16 * dp
                    Rectangle {
                        width: 16 * dp
                        height: 16 * dp
                        color: index == indicator.currentIndex
                               ? "black" : "gray"
                        radius: 8 * dp
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                view.currentIndex = index;
                            }
                        }
                    }
                }
            }

            RowLayout {
                id: shortCutBar
                width: parent.width
                height: 90 * dp
                anchors.bottom: parent.bottom
                Repeater {
                    model: 4
                    Item {
                        height: parent.height
                        Layout.fillWidth: true
                        ApplicationIcon {
                            anchors.centerIn: parent
                            iconSource: "./images/icons/01.png"
                            iconLabel: "应用"
                        }
                    }
                }
            }
        }
    }

    onBackKeyPressed: view.currentIndex = 1
}
