import QtQuick 2.5
import Sparrow 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.2
import Qt.labs.folderlistmodel 2.1

Page {
    id: page
    focus: true
    color: "black"

    title: folder

    signal select(var fileUrls)

    property int rowCellCount: 3
    property bool selecting: true
    property alias folder: folderModel.folder

    property size cellSize: Qt.size(page.width/rowCellCount, page.width/rowCellCount)

    Keys.onBackPressed: {
        event.accepted = true;
        stackView.pop();
    }

    Keys.onPressed: {
        if(event.key == Qt.Key_Backspace) {
            event.accepted = true;
            stackView.pop();
        }
    }

    topBar: TopBar {
        RowLayout {
            Button {
                text: "退出"
                onClicked: stackView.pop();
            }
        }
    }

    FolderListModel {
        id: folderModel
        showDirs: false
        sortField: FolderListModel.Time
        nameFilters:
            ["*.bmp","*.gif","*.jpg",
            "*.jpeg","*.png","*.pbm"
            ,"*.pgm","*.ppm", "*.xbm",
            "*.xpm", "*.svg"]
    }

    Component {
        id: viewDelegate
        Flickable {
            id: root;

            property alias imageStatus: mediumPic.status;
            property alias loadingProgress: mediumPic.progress;

            function zoomIn(){
                bounceBackAnimation.to = mediumPic.scale < 1 ? 1 : pinchArea.maxScale;
                bounceBackAnimation.start();
            }
            function zoomOut(){
                bounceBackAnimation.to = pinchArea.minScale;
                bounceBackAnimation.start();
            }
            function reload(){
                mediumPic.source = "";
            }

            clip: true;

            implicitWidth: ListView.view.width;
            implicitHeight: ListView.view.height;

            contentWidth: imageContainer.width;
            contentHeight: imageContainer.height;

            onHeightChanged: if (mediumPic.status == Image.Ready) mediumPic.fitToScreen();

            Item {
                id: imageContainer;

                width: Math.max(mediumPic.width * mediumPic.scale, root.width);
                height: Math.max(mediumPic.height * mediumPic.scale, root.height);

                Image {
                    id: mediumPic;

                    property real prevScale
                    property point doubleClickedPos: Qt.point(0, 0)

                    function fitToScreen() {
                        scale = Math.min(root.width / width, root.height / height, 1)
                        pinchArea.minScale = scale
                        prevScale = scale
                    }

                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    source: fileURL
                    sourceSize.height: 1024
                    smooth: !root.moving
                    asynchronous: true

                    onStatusChanged: {
                        if (status == Image.Ready){
                            fitToScreen();
                            loadedAnimation.start();
                        }
                    }

                    NumberAnimation {
                        id: loadedAnimation
                        target: mediumPic;
                        property: "opacity"
                        duration: 250
                        from: 0; to: 1
                        easing.type: Easing.InOutQuad
                    }

                    onScaleChanged: {
                        if ((width * scale) > root.width) {
                            var xoff = (root.width / 2 + root.contentX) * scale / prevScale;
                            root.contentX = xoff - root.width / 2
                        }
                        if ((height * scale) > root.height) {
                            var yoff = (root.height / 2 + root.contentY) * scale / prevScale;
                            root.contentY = yoff - root.height / 2
                        }
                        prevScale = scale;
                    }
                }
            }

            PinchArea {
                id: pinchArea

                property real minScale: 1.0
                property real maxScale: 3.0

                anchors.fill: parent
                enabled: mediumPic.status === Image.Ready
                pinch.target: mediumPic
                pinch.minimumScale: minScale * 0.5 // This is to create "bounce back effect"
                pinch.maximumScale: maxScale * 1.5 // when over zoomed

                onPinchFinished: {
                    root.returnToBounds();
                    if (mediumPic.scale < pinchArea.minScale) {
                        bounceBackAnimation.to = pinchArea.minScale;
                        bounceBackAnimation.start();
                    }
                    else if (mediumPic.scale > pinchArea.maxScale) {
                        bounceBackAnimation.to = pinchArea.maxScale;
                        bounceBackAnimation.start();
                    }
                }

                NumberAnimation {
                    id: bounceBackAnimation
                    target: mediumPic
                    duration: 250
                    property: "scale"
                    from: mediumPic.scale
                }
            }
        }
    }

    // 夜切的pixiv
    ListView {
        id: view
        clip: true
        cacheBuffer: parent.width
        displayMarginBeginning: parent.width * 10
        displayMarginEnd: parent.width * 10

        anchors.fill: parent
        preferredHighlightBegin: 0
        preferredHighlightEnd: view.width
        highlightMoveDuration: 250
        highlightRangeMode: ListView.StrictlyEnforceRange
        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal
        boundsBehavior: ListView.StopAtBounds
        model: folderModel
        delegate: viewDelegate
    }
}

