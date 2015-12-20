// https://github.com/BrunoGeorgevich/PokeballQML/blob/master/Pokeball.qml
import QtQuick 2.0

Rectangle {
    id:pokeballRoot
    width: parent.width/2
    height: width
    radius: width/2

    property string upSideColor : "Red"
    property string bottomSideColor : "White"
    property string majorCentralCircleColor : "White"
    property string minorCentralCircleColor : "Black"
    property string lineColor : "Black"

    function log(text) {
        console.log(text)
    }

    state:"normal"
    transform: Rotation {
        id:rotationCenterRect
        axis { x:0;y:0;z:1 }
        angle:0

        origin.x:width/2
        origin.y:height/2
    }

    Canvas {
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            var centreX = width / 2;
            var centreY = height / 2;

            ctx.strokeStyle = lineColor
            ctx.lineWidth = 10;

            //Draw the red arc
            ctx.beginPath();
            ctx.fillStyle = upSideColor;
            ctx.moveTo(centreX, centreY);
            ctx.arc(centreX, centreY, width*(0.485) , 0, Math.PI, true);
            ctx.lineTo(centreX, centreY);
            ctx.fill();
            ctx.stroke();

            //Draw the white arc
            ctx.beginPath();
            ctx.fillStyle = bottomSideColor;
            ctx.arc(centreX, centreY, width*(0.485), Math.PI, 2*Math.PI, true);
            ctx.fill();
            ctx.stroke();

            //The major central circle
            ctx.beginPath();
            ctx.fillStyle = majorCentralCircleColor;
            ctx.arc(centreX, centreY, width / 10, 0, 2*Math.PI, true);
            ctx.fill();
            ctx.stroke();

            //The minor central circle
            ctx.beginPath();
            ctx.fillStyle = minorCentralCircleColor;
            ctx.arc(centreX, centreY, width / 20, 0, 2*Math.PI, true);
            ctx.fill();
            ctx.stroke();
        }

        MouseArea {
            anchors.fill: parent
            onClicked : {
                switch(pokeballRoot.state) {
                case "normal":
                    pokeballRoot.state = "capturing"
                    break;
                case "capturing":
                    pokeballRoot.state = "normal"
                    break;
                }
            }
        }
    }

    Rectangle {
        id:centralCircle
        anchors.centerIn: parent
        width: parent.width/13
        height: width
        radius: width/2
        color:minorCentralCircleColor
    }

    states: [
        State {
            name: "normal"
            PropertyChanges {
                target:pokeballRoot
                minorCentralCircleColor : "Black"
            }
            PropertyChanges {
                target:rotationCenterRect
                angle : 0
            }
        },
        State {
            name: "capturing"
        }
    ]

    transitions: [
        Transition {
            from: "normal"
            to: "capturing"
            ParallelAnimation {
                loops: Animation.Infinite
                SequentialAnimation {
                    SmoothedAnimation {
                        target:rotationCenterRect
                        property: "angle"
                        from:-20
                        to: 20
                        velocity: 80
                    }
                    SmoothedAnimation {
                        target:rotationCenterRect
                        property: "angle"
                        from:20
                        to: -20
                        velocity: 80
                    }
                }
            }
        },
        Transition {
            from: "capturing"
            to: "normal"
            SmoothedAnimation {
                target:rotationCenterRect
                property: "angle"
                to: 0
                velocity: 80
            }
        }
    ]
}
