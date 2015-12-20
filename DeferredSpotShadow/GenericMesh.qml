import Qt3D 2.0
import Qt3D.Renderer 2.0
import QtQuick 2.1 as QQ2

Entity {
    id: root

    property string meshSource
    property Effect sceneEffect
    property vector3d position: Qt.vector3d(0, 0, 0)
    property int rotationAngle: 0
    property vector3d rotationAxis: Qt.vector3d(0, 0, 0)

    onMeshSourceChanged: console.log("Mesh source changed to: " + meshSource)

    Mesh {
        id: refMesh
        source: meshSource
    }
    Transform {
        id: refTransform
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
        parameters : Parameter { name : "meshColor"; value : "gray" }
    }

    components : [
        refMesh,
        refTransform,
        material,
        sceneLayer
    ]
}
