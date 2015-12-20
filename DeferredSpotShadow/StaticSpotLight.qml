import Qt3D 2.0
import Qt3D.Renderer 2.0
import QtQuick 2.1 as QQ2

Entity {
    id: spotlight
    property Effect sceneEffect
    property color lightColor: "green"
    property vector3d position: Qt.vector3d(0, 0, 0)
    property int rotationAngle: 0

    readonly property Camera lightCamera: lightCamera
    readonly property matrix4x4 lightViewProjection: lightCamera.projectionMatrix.times(lightCamera.matrix)

    Mesh {
        id: lightMesh
        source: Qt.resolvedUrl("./assets/cone.obj")
    }

    property Transform transform : Transform {
        id: lightTransform
        Translate {
            dx: position.x
            dy: position.y
            dz: position.z
        }
        Rotate {
            angle: rotationAngle
            axis: Qt.vector3d(1, 0, 0)
        }
    }

    property Material material : Material {
        effect : sceneEffect
        parameters : Parameter { name : "meshColor"; value : "gray" }
    }

    property SpotLight light : SpotLight {
        color : lightColor
        intensity : 2.0
        direction: Qt.vector3d(0, -1, 0)
        cutOffAngle: 30.0
    }

    Camera {
        id: lightCamera
        objectName: "lightCameraLens"
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        aspectRatio: 1
        nearPlane : 0.1
        farPlane : 200.0
        position: spotlight.position
        viewCenter: Qt.vector3d(0.0, 0.0, 0.0)
        upVector: Qt.vector3d(0.0, 1.0, 0.0)
    }

    components : [
        lightMesh,
        lightTransform,
        material,
        light,
        sceneLayer
    ]
}

