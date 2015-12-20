import Qt3D 2.0
import Qt3D.Renderer 2.0
import QtQuick 2.1 as QQ2

Entity {
    id: root

    property Effect sceneEffect
    property vector3d position: Qt.vector3d(0, 0, 0)
    property int rotationAngle: 0
    property vector3d rotationAxis: Qt.vector3d(0, 0, 0)

    onPositionChanged: console.log("Cube position changed. x: " + position.x)

    CuboidMesh {
        id: cuboidMesh
        yzMeshResolution: Qt.size(2, 2)
        xzMeshResolution: Qt.size(2, 2)
        xyMeshResolution: Qt.size(2, 2)
    }

    property Transform transform : Transform {
        id: cubeTransform
        Rotate {
            angle: rotationAngle
            axis: rotationAxis
        }

        Translate {
            dx: position.x
            dy: position.y
            dz: position.z
        }
    }

    property Material material : Material {
        effect : sceneEffect
        parameters : Parameter { name : "meshColor"; value : "blue" }
    }

    components : [
        cuboidMesh,
        cubeTransform,
        material,
        sceneLayer
    ]
}
