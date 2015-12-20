import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Particles 2.0

ApplicationWindow {
    id: root
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

    property int leftWins: 0
    property int rightWins: 0

    Rectangle {
        id: leftpaddle
        color: "blue"
        width: 10
        height: 100
        anchors.left: parent.left
        y: parent.height/2 - height/2

        Affector {  // Top Edge
            anchors.fill: parent
            height: 5
            system: ps

            onAffectParticles: {
                for (var i=0; i<particles.length; i++) {
                    particles[i].vx *= -1;
                }
            }
        }

        Behavior on y { NumberAnimation { duration: 100 } }
    }

    Rectangle {
        id: rightpaddle
        color: "green"
        width: 10
        height: 100
        anchors.right: parent.right
        y: parent.height/2 - height/2

        Affector {  // Top Edge
            anchors.fill: parent
            anchors.rightMargin: parent.width-2
            height: 5
            system: ps

            onAffectParticles: {
                for (var i=0; i<particles.length; i++) {
                    particles[i].vx *= -1;
                }
            }
        }

        Behavior on y { NumberAnimation { duration: 100 } }
    }

    Item {
        focus: true
        property int delta: 40
        Keys.onPressed: {
            if (event.key === Qt.Key_W) {
                leftpaddle.y = leftpaddle.y - delta
            }
            if (event.key === Qt.Key_S) {
                leftpaddle.y = leftpaddle.y + delta
            }
            if (event.key === Qt.Key_I) {
                rightpaddle.y = rightpaddle.y - delta
            }
            if (event.key === Qt.Key_K) {
                rightpaddle.y = rightpaddle.y + delta
            }
        }
    }

    ParticleSystem {
        id: ps
    }
    ItemParticle {
        system: ps
        fade: false
        delegate: Rectangle {
            width: 30
            height: width
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
            radius: width/2
        }
    }
    Emitter {
        id: emitter
        system: ps
        emitRate: 0
        anchors.centerIn: parent
        lifeSpan: Emitter.InfiniteLife
        size: 64
        velocity: AngleDirection {
            angle: -45; magnitude: 200
        }
    }
    Affector {  // Top Edge
        anchors { left: parent.left; right: parent.right; top: parent.top }
        height: 5
        system: ps

        onAffectParticles: {
            for (var i=0; i<particles.length; i++) {
                particles[i].vy *= -1;
            }
        }
    }
    Affector {  // Bottom Edge
        anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
        height: 5
        system: ps

        onAffectParticles: {
            for (var i=0; i<particles.length; i++) {
                particles[i].vy *= -1;
            }
        }
    }

    Age {  // Left Edge
        anchors { right: parent.left; bottom: parent.bottom; top: parent.top }
        width: 5
        system: ps
        lifeLeft: 0
        onAffected: root.rightWins++
    }
    Age {  // Right Edge
        anchors { left: parent.right; bottom: parent.bottom; top: parent.top }
        width: 5
        system: ps
        lifeLeft: 0
        onAffected: root.leftWins++
    }

    Text {
        anchors { left: parent.left; top: parent.top; margins: 10 }
        text: "SCORE " + root.leftWins
    }
    Text {
        anchors { right: parent.right; top: parent.top; margins: 10 }
        text: "SCORE " + root.rightWins
    }

    MouseArea {
        anchors.fill: parent
        onClicked: emitter.burst(1)
    }
}
